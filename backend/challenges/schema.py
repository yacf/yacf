import channels.layers
from asgiref.sync import async_to_sync

import hashlib
import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin, validate_user_is_staff
from settings.validators import validate_active_event

from categories.models import Category
from challenges.models import Challenge, Flag, Hint
from teams.models import SolvedChallenge, Failure, FlagTracker
from uauth.models import Profile

class ChallengeType(DjangoObjectType):
    class Meta:
        model = Challenge
        # exclude_fields = ['flag']

class FlagType(DjangoObjectType):
    value  = graphene.String()
    hashed = graphene.Boolean() 

    def resolve_value(self, info):
        validate_user_is_admin(info.context.user)
        return self.value

    def resolve_hashed(self, info):
        validate_user_is_admin(info.context.user)
        return self.hashed

    class Meta:
        model = Flag
        exclude_fields = ['challenge']

class HintType(DjangoObjectType):
    class Meta:
        model = Hint

    '''
    TODO: Need a catch all for non staff, show nothing
    '''
    def resolve_content(self, info):
        if not self.hidden:
            return self.content
        else:
            return ''

class Query(graphene.ObjectType):
    challenges = graphene.List(ChallengeType, first=graphene.Int(), skip=graphene.Int())
    challenge = graphene.Field(ChallengeType, id=graphene.Int())

    challenge_count = graphene.Int()

    flag = graphene.Field(FlagType, cid=graphene.Int())

    statistic = graphene.Field(ChallengeType, category=graphene.String(), points=graphene.Int())
    total_points = graphene.Int()

    def resolve_challenges(self, info, first=None, skip=None, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            challenges = Challenge.objects.all().order_by('name')
            if skip is not None : 
                challenges = challenges[skip:]
            if first is not None: 
                challenges = challenges[:first]
            return challenges
        else:
            validate_active_event()
            return Challenge.objects.filter(category__hidden=False, hidden=False).order_by('points')

    def resolve_challenge(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            return Challenge.objects.get(pk=kwargs.get('id'))
        else:
            validate_active_event()
            return Challenge.objects.get(pk=kwargs.get('id'), hidden=False)

    def resolve_challenge_count(self, info, **kwargs):
        if validate_user_is_staff(info.context.user):
            return Challenge.objects.count()
        else:
            raise Exception("You are not authorized to view this information.")

    def resolve_flag(self, info, **kwargs):
        validate_user_is_admin(info.context.user)
        return Flag.objects.get(challenge__pk=kwargs.get('cid'))

    def resolve_statistic(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        get_category = Category.objects.get( name__iexact=kwargs.get('category') )
        return Challenge.objects.filter(category=get_category, points=kwargs.get('points')).first()

    def resolve_total_points(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        return sum([challenge.points for challenge in Challenge.objects.all()])


# ------------------- MUTATIONS -------------------

class AddChallenge(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        name        = graphene.String(required=True)
        description = graphene.String(required=True)
        encoded     = graphene.Boolean(required=False)
        category    = graphene.String(required=True)
        points      = graphene.Int(required=False)
        flag        = graphene.String(required=True)
        precomputed = graphene.Boolean(required=True)
        hashed      = graphene.Boolean(required=False)

        hidden      = graphene.Boolean(required=False)

    #TODO: Need to check and ensure no challenge is made with the same points as another challenge. If not, frontend stats break
    #TODO: Just fix the frontend :) ^^
    def mutate(self, info, name, description, category, flag, precomputed, hashed, points=0, encoded=False, hidden=False):
        validate_user_is_admin(info.context.user)
        get_category = Category.objects.get(name=category)
        
        newChallenge = Challenge(name=name, description=description, encoded=encoded, points=points, hidden=hidden, category=get_category)
        newChallenge.save()

        if hashed:
            if precomputed:
                flag = Flag(value=flag, challenge=newChallenge)
            else:
                flag = Flag(value=hashlib.sha256(flag.encode('utf-8')).hexdigest(), challenge=newChallenge)
        else:
            flag = Flag(value=flag, challenge=newChallenge)

        flag.save()

        return AddChallenge(code=0)

class RemoveChallenge(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        id = graphene.Int(required=True)

    def mutate(self, info, id):
        validate_user_is_admin(info.context.user)

        try:
            challenge = Challenge.objects.get(pk=id)
            challenge.delete()
            code = 0
        except:
            code = 1

        return RemoveChallenge(code)

class UpdateChallenge(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        id          = graphene.Int(required=True)
        name        = graphene.String(required=True)
        description = graphene.String(required=True)
        points      = graphene.Int(required=False)
        show        = graphene.Boolean(required=False)

        category    = graphene.String(required=False)

    #TODO: Need to check and ensure no challenge is made with the same points as another challenge. If not, frontend stats break
    def mutate(self, info, id, name, description, points=0, show=False, category=None):
        validate_user_is_admin(info.context.user)

        # try:
        category = Category.objects.get(name=category)
        challenge = Challenge.objects.get(pk=id)
        challenge.name = name
        challenge.description = description
        challenge.points = points
        challenge.show = show
        challenge.category = category

        challenge.save()


        code = 0
        # except:
        #     message = "failure"

        return UpdateChallenge(code)


class SubmitFlag(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        #DOC: Challenge will equal the PK of the challenge a.k.a id
        challenge   = graphene.Int(required=True)
        flag        = graphene.String(required=True)

    def mutate(self, info, challenge, flag):
        validate_user_is_authenticated(info.context.user)

        # If user is not staff validate there is an active event.
        if not validate_user_is_staff(info.context.user):
            validate_active_event()
        
        try:
            team = Profile.objects.get(user=info.context.user).team
        except:
            raise Exception('You must be on a team to submit flags')

        try:
            challenge = Challenge.objects.get(pk=challenge)
        except:
            raise Exception('Challenge not found')

        # Check if challenge has been solved by the team 
        if team.solved.filter(challenge=challenge):
            raise Exception('Challenge already solved!')

        solved = False
        if challenge.flag.hashed:
            if challenge.flag.value == hashlib.sha256(flag.encode('utf-8')).hexdigest():
                solved = True
        else:
            if challenge.flag.value == flag:
                solved = True

        if solved:
            solve = SolvedChallenge(team=team, user=info.context.user, challenge=challenge)
            solve.save()

            '''
            Flag tracker
            '''
            # print(info.context.META.get('HTTP_X_FORWARDED_FOR'), info.context.META.get('HTTP_X_REAL_IP'), info.context.META.get('HTTP_USER_AGENT'))
            try:
                flagtracker = FlagTracker(solve=solve, address=info.context.META.get('HTTP_X_REAL_IP'), agent=info.context.META.get('HTTP_USER_AGENT'))
                flagtracker.save()
            except:
                pass

            code=1
        else:
            fail = Failure(team=team, user=info.context.user, challenge=challenge)
            fail.save()
            code=0

        # if code == 1:
        #     try:
        #         # Send signal to scoreboard
        #         channel_layer = channels.layers.get_channel_layer()
        #         async_to_sync(channel_layer.group_send)("scoreboard", {"type": "scoreboard.update", "team": team.name, "points": team.points, "added": get_challenge.points, "time": solve.timestamp.strftime("%I:%M:%S")} )
        #     except:
        #         pass

        return SubmitFlag(code=code)


class Mutation(object):
    addChallenge = AddChallenge.Field()
    removeChallenge = RemoveChallenge.Field()
    updateChallenge = UpdateChallenge.Field()
    submitflag = SubmitFlag.Field()