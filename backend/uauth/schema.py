import graphene
from graphene_django import DjangoObjectType
from graphene import relay
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin, validate_user_is_staff, validate_password
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.db.models import Q

from uauth.models import AdminRegisterKey, Profile
from logs.models import LoginTracker
from teams.models import Team, AccessCode
from settings.models import Team as S_Team

from django.utils import timezone

class Me(DjangoObjectType):
    class Meta:
        model = User
        exclude_fields = ['password']

class UserType(DjangoObjectType):
    class Meta:
        model = User
        exclude_fields = ['password']

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

class LoginTrackerType(DjangoObjectType):
    class Meta:
        model = LoginTracker

class UserConnection(relay.Connection):
    class Meta:
        node = UserType

    total_count = graphene.Int()
    def resolve_total_count(self, info, **kwargs):
        return self.iterable.count()

class Query(object):
    # users = graphene.List(UserType, search=graphene.String(), first=graphene.Int(), skip=graphene.Int(), hidden=graphene.Boolean())
    user = graphene.Field(UserType, id=graphene.Int())
    user_count = graphene.Int()

    me = graphene.Field(Me)
    profile = graphene.Field(ProfileType)

    login_tracker = graphene.List(LoginTrackerType)

    users = relay.ConnectionField(UserConnection, search=graphene.String())

    def resolve_users(root, info, search=None, **kwargs):
        validate_user_is_admin(info.context.user)
        if search:
            return User.objects.filter(Q(username__icontains=search) | Q(first_name__icontains=search) | Q(last_name__icontains=search))
        else:
            return User.objects.all()


    # def resolve_users(self, info, search=None, first=None, skip=None, hidden=None):
    #     validate_user_is_admin(info.context.user)
    #     if validate_user_is_staff(info.context.user):
    #         if hidden is True:
    #             users = User.objects.filter(profile__hidden=True)
    #         elif hidden is False:
    #             users = User.objects.filter(profile__hidden=False)
    #         else:
    #             users = User.objects.all()
            
    #         if search:
    #             users = users.filter(Q(username__icontains=search) | Q(first_name__icontains=search) | Q(last_name__icontains=search))

    #         if skip is not None : 
    #             users = users[skip:]
    #         if first is not None: 
    #             users = users[:first]
            
    #         return users
    #     else:
    #         raise Exception('Not authorized to view query users')

    def resolve_user(self, info, id=None):
        validate_user_is_admin(info.context.user)
        if validate_user_is_staff(info.context.user):
            if id:
                return User.objects.get(id=id)
            else:
                raise Exception('No user ID was provided')
        else:
            raise Exception('Not authorized to view query users')

    def resolve_user_count(self, info, **kwargs):
        if validate_user_is_staff(info.context.user):
            return User.objects.count()
        else:
            raise Exception("You are not authorized to view this information.")

    def resolve_me(self, info):
        validate_user_is_authenticated(info.context.user)
        return info.context.user

    def resolve_login_tracker(self, info):
        validate_user_is_admin(info.context.user)
        return LoginTracker.objects.all()

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

        if registerkey.singleuse:
            registerkey.active = False
            registerkey.save()

        try:
            logintracker = LoginTracker(user=user, address=info.context.META.get('HTTP_X_REAL_IP'), agent=info.context.META.get('HTTP_USER_AGENT'))
            logintracker.save()
        except:
            pass

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
            team = AccessCode.objects.get(value=accesscode).team
        except:
            raise Exception("Bad Access code")

        if team.players.count() <= S_Team.objects.first().capacity:
            newUser = User.objects.create_user(username=username, first_name=firstname, last_name=lastname, email=email, password=password)
            newProfile = Profile(user=newUser, verified=False, team=team, hidden=False)
            newProfile.save()
        else:
            raise Exception("Team is full")

        try:
            logintracker = LoginTracker(user=userobj, address=info.context.META.get('HTTP_X_REAL_IP'), agent=info.context.META.get('HTTP_USER_AGENT'))
            logintracker.save()
        except:
            pass

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

        # print(info.context.META.get('HTTP_X_FORWARDED_FOR'), info.context.META.get('HTTP_X_REAL_IP'), info.context.META.get('HTTP_USER_AGENT'))
        try:
            logintracker = LoginTracker(user=userobj, address=info.context.META.get('HTTP_X_REAL_IP'), agent=info.context.META.get('HTTP_USER_AGENT'))
            logintracker.save()
        except:
            pass

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