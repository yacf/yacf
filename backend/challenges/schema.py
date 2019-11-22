import channels.layers
from asgiref.sync import async_to_sync

import hashlib
import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin, validate_user_is_staff
from settings.validators import validate_active_event

from categories.models import Category
from challenges.models import Challenge, Flag, Hash, Hint
from teams.models import SolvedChallenge, Failure
from uauth.models import Profile

class ChallengeType(DjangoObjectType):
    class Meta:
        model = Challenge
        exclude_fields = ('flag')

class FlagType(DjangoObjectType):
    class Meta:
        model = Flag

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
    challenges = graphene.List(ChallengeType)
    challenge = graphene.Field(ChallengeType, id=graphene.Int())
    flag = graphene.Field(FlagType, cid=graphene.Int())

    statistic = graphene.Field(ChallengeType, category=graphene.String(), points=graphene.Int())
    total_points = graphene.Int()

    def resolve_challenges(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            return Challenge.objects.all().order_by('points')
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
    message = graphene.String()

    class Arguments:
        name        = graphene.String(required=True)
        description = graphene.String(required=True)
        points      = graphene.Int(required=False)
        flag        = graphene.String(required=False)
        algorithm   = graphene.String(required=False)
        hidden        = graphene.Boolean(required=False)

        category    = graphene.String(required=False)

    #TODO: Need to check and ensure no challenge is made with the same points as another challenge. If not, frontend stats break
    #TODO: Just fix the frontend :) ^^
    def mutate(self, info, name, description, points=0, flag="", algorithm="", hidden=False, category=None):
        validate_user_is_admin(info.context.user)

        if category:
            category = Category.objects.get(name=category)
        
        if algorithm:
            algorithm = Hash.objects.get(value=algorithm)
        
        if category:
            newChallenge = Challenge(name=name, description=description, points=points, hidden=hidden, category=category)
        else:
            newChallenge = Challenge(name=name, description=description, points=points, hidden=hidden)
        newChallenge.save()

        if flag:
            if algorithm:
                flag = Flag(value=flag, algorithm=algorithm, challenge=newChallenge)
            else:
                flag = Flag(value=flag, challenge=newChallenge)
            flag.save()

        return AddChallenge(message="Success")

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
    message = graphene.String()

    class Arguments:
        id          = graphene.Int(required=True)
        name        = graphene.String(required=True)
        description = graphene.String(required=True)
        points      = graphene.Int(required=False)
        flag        = graphene.String(required=False)
        show        = graphene.Boolean(required=False)

        category    = graphene.String(required=False)

    #TODO: Need to check and ensure no challenge is made with the same points as another challenge. If not, frontend stats break
    def mutate(self, info, id, name, description, points=0, flag="", show=False, category=None):
        validate_user_is_admin(info.context.user)

        # try:
        category = Category.objects.get(name=category)
        challenge = Challenge.objects.get(pk=id)
        challenge.name = name
        challenge.description = description
        challenge.points = points
        challenge.flag.value = flag
        challenge.show = show
        challenge.category = category

        challenge.save()


        message = "success"
        # except:
        #     message = "failure"

        return UpdateChallenge(message)


class SubmitFlag(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        #DOC: Challenge will equal the PK of the challenge a.k.a id
        challenge   = graphene.Int(required=True)
        flag        = graphene.String(required=True)

    def mutate(self, info, challenge, flag):
        validate_user_is_authenticated(info.context.user)
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

        algorithm = challenge.flag.algorithm.value

        solved = False
        if algorithm == None:
            if challenge.flag.value == flag:
                solved = True
        elif algorithm == 'md5':
            if challenge.flag.value == hashlib.md5(flag.encode('utf-8')).hexdigest():
                solved = True
        elif algorithm == 'sha224':
            if challenge.flag.value == hashlib.sha224(flag.encode('utf-8')).hexdigest():
                solved = True
        elif algorithm == 'sha256':
            if challenge.flag.value == hashlib.sha256(flag.encode('utf-8')).hexdigest():
                solved = True
        else:
            raise Exception('Error with flag algorithm')

        if solved:
            solve = SolvedChallenge(team=team, user=info.context.user, challenge=challenge)
            solve.save()
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