import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin, validate_user_is_staff, validate_password
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User

from uauth.models import AdminRegisterKey, Profile
from teams.models import Team
from settings.models import Team as S_Team

from django.utils import timezone

class Me(DjangoObjectType):
    class Meta:
        model = User
        exclude_fields = ('password')

class UserType(DjangoObjectType):
    class Meta:
        model = User
        exclude_fields = ('password')

    # def resolve_is_superuser(self, info):
    #     if validate_user_is_staff(info.context.user):
    #         return self.is_superuser
    #     else:
    #         raise Exception('Not authorized to view superuser information')

    def resolve_is_staff(self, info):
        if validate_user_is_staff(info.context.user):
            return self.is_staff
        else:
            raise Exception('Not authorized to view staff information')

    def resolve_is_active(self, info):
        if validate_user_is_staff(info.context.user):
            return self.is_active
        else:
            raise Exception('Not authorized to view active information')

    def resolve_last_login(self, info):
        if validate_user_is_staff(info.context.user):
            return self.last_login
        else:
            raise Exception('Not authorized to view last login information')

    def resolve_email(self, info):
        if validate_user_is_staff(info.context.user):
            return self.email
        else:
            raise Exception('Not authorized to view email information for users')

class ProfileType(DjangoObjectType):
    class Meta:
        model = Profile

class Query(object):
    users = graphene.List(UserType)
    me = graphene.Field(Me)
    profile = graphene.Field(ProfileType)

    def resolve_users(self, info):
        validate_user_is_admin(info.context.user)
        if validate_user_is_staff(info.context.user):
            return User.objects.all()
        else:
            raise Exception('Not authorized to view query users')

    def resolve_me(self, info):
        validate_user_is_authenticated(info.context.user)
        return info.context.user

# ------------------- MUTATIONS -------------------

class ValidateRegisterKey(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        key  = graphene.String(required=True)

    def mutate(self, info, key):
        try:
            registerkey = AdminRegisterKey.objects.get(key=key)
        except:
            raise Exception("Key does not exist")

        if registerkey.expiration < timezone.now():
            raise Exception("Expired Key")
        elif not registerkey.active:
            raise Exception("Access key is not active. Contact administrator.")         

        return ValidateRegisterKey(code=0)

class CreateAdmin(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        username = graphene.String(required=True)
        password = graphene.String(required=True)
        firstname = graphene.String(required=True)
        lastname  = graphene.String(required=True)

        key  = graphene.String(required=True)

    def mutate(self, info, username, password, firstname, lastname, key):
        try:
            registerkey = AdminRegisterKey.objects.get(key=key)
        except:
            raise Exception("Key does not exist")

        if registerkey.expiration < timezone.now():
            raise Exception("Expired Key")
        elif not registerkey.active:
            raise Exception("Not active access key")          

        if User.objects.filter(username=username).first():
            raise Exception("Username taken")

        validate_password(password)

        user = User.objects.create_superuser(username=username, password=password, first_name=firstname, last_name=lastname, email="")
        user.save()

        profile = Profile(user=user, verified=True, hidden=True)
        profile.save()

        registerkey.active = False
        registerkey.save()

        login(info.context, user)

        return CreateAdmin(code=0)

class AddUser(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        username   = graphene.String(required=True)
        email      = graphene.String(required=True)
        password   = graphene.String(required=True)
        firstname  = graphene.String(required=True)
        lastname   = graphene.String(required=True)
        accesscode = graphene.String(required=True)

    # TODO: VALIDATION CHECK!!
    # TODO: TRY CATCH
    def mutate(self, info, username, email, password, firstname, lastname, accesscode):
        # validate_user_is_admin(info.context.user)
        validate_password(password)

        try:
            team = Team.objects.get(accesscode=accesscode)
        except:
            raise Exception("Bad Access code")

        if team.players.count() <= S_Team.objects.first().capacity:
            newUser = User.objects.create_user(username=username, first_name=firstname, last_name=lastname, email=email, password=password)
            newProfile = Profile(user=newUser, verified=False, team=team, hidden=False)
            newProfile.save()
        else:
            raise Exception("Team is full")

        login(info.context, newUser)

        return AddUser(code=0)

class LogIn(graphene.Mutation):
    user = graphene.Field(UserType)

    class Arguments:
        username = graphene.String(required=True)
        password = graphene.String(required=True)

    def mutate(self, info, username, password):
        userobj = authenticate(username=username, password=password)

        if not userobj:
            raise Exception('Invalid username or password')

        login(info.context, userobj)

        return LogIn(user=userobj)
    
class LogOut(graphene.Mutation):
    status = graphene.String()

    def mutate(self, info):
        logout(info.context) 
        return LogOut(status='Logged Out')

class Mutation(object):
    validateregisterkey = ValidateRegisterKey.Field()
    createadmin = CreateAdmin.Field()
    adduser = AddUser.Field()
    login   = LogIn.Field()
    logout  = LogOut.Field()