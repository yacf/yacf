import channels.layers
from asgiref.sync import async_to_sync
from django.db.models import Q

import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin, validate_user_is_staff
from uauth.models import Profile

import string, random, json

from settings.models import Event
from teams.models import Team, AccessCode, SolvedChallenge, Failure, FlagTracker

class TeamType(DjangoObjectType):
    points = graphene.Int()
    members = graphene.Int()
    correct_flags = graphene.Int()
    wrong_flags = graphene.Int()

    class Meta:
        model = Team

    def resolve_email(self, info):
        if validate_user_is_staff(info.context.user):
            return self.email
        else:
            raise Exception('Not authorized to view email information for teams')

class SolvedChallengeType(DjangoObjectType):
    class Meta:
        model = SolvedChallenge

class FailureType(DjangoObjectType):
    class Meta:
        model = Failure

class AccessCodeType(DjangoObjectType):
    class Meta:
        model = AccessCode

    def resolve_value(self, info):
        if validate_user_is_staff(info.context.user):
            return self.value
        else:
            raise Exception('Not authorized to view accesscode information for teams')

class FlagTrackerType(DjangoObjectType):
    class Meta:
        model = FlagTracker

class Query(graphene.ObjectType):
    teams = graphene.List(TeamType, hidden=graphene.Boolean(), first=graphene.Int(), skip=graphene.Int())
    solves = graphene.List(SolvedChallengeType, first=graphene.Int(), skip=graphene.Int())
    failures = graphene.List(FailureType, first=graphene.Int(), skip=graphene.Int())

    team_name = graphene.Field(TeamType, name=graphene.String())
    team = graphene.Field(TeamType)

    searchteam = graphene.List(TeamType, query=graphene.String())

    team_sovle = graphene.List(SolvedChallengeType)

    flag_tracker = graphene.List(FlagTrackerType)

    def resolve_teams(self, info, hidden=None, first=None, skip=None, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            if hidden is True:
                return Team.objects.filter(hidden=True)
            elif hidden is False:
                return Team.objects.filter(hidden=False)
            else:
                return Team.objects.all()
        else:
            if Event.objects.first() and Event.objects.first().private is True:
                raise Exception("This event is being run in privacy mode. You are not allowed to query all teams.")
            else:
                teams = Team.objects.filter(hidden=False)


        if skip is not None : 
            teams = teams[skip:]
        if first is not None: 
            teams = teams[:first]
        
        return teams

    def resolve_team_name(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)

        if validate_user_is_staff(info.context.user):
            return Team.objects.get(name__iexact=kwargs.get('name'))
        else:
            if Event.objects.first() and Event.objects.first().private is True:
                team = Team.objects.get(name__iexact=kwargs.get('name'))
                if info.context.user.profile.team == team:
                    return team
                else:
                    raise Exception("This event is being run in privacy mode. You are not allowed to query teams. If you are querying for your team please use the team query")
            else:
                return Team.objects.get(name__iexact=kwargs.get('name'))

    def resolve_team(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        return info.context.user.profile.team
    
    def resolve_solves(self, info, first=None, skip=None, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            solves = SolvedChallenge.objects.all().order_by('-timestamp')
        else:
            if Event.objects.first() and Event.objects.first().private is True:
                raise Exception("This event is being run in privacy mode. You are not allowed to query solves. If you want to query your team solves please use the teamsolves query.")
            else:
                solves = SolvedChallenge.objects.all().order_by('-timestamp')

        if skip is not None : 
            solves = solves[skip:]
        if first is not None: 
            solves = solves[:first]

        return solves

    def resolve_failures(self, info, first=None, skip=None, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            failures = Failure.objects.all().order_by('-timestamp')
        else:
            if Event.objects.first() and Event.objects.first().private is True:
                raise Exception("This event is being run in privacy mode. You are not allowed to query failures.")
            else:
                failures = Failure.objects.all().order_by('-timestamp')
        
        if skip is not None : 
            failures = failures[skip:]
        if first is not None: 
            failures = failures[:first]

        return failures

    def resolve_searchteam(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            return Team.objects.filter(Q(name__contains=kwargs.get('query')) | Q(affiliation__contains=kwargs.get('query')) | Q(website__contains=kwargs.get('query')))
        else:
            if Event.objects.first() and Event.objects.first().private is True:
                raise Exception("This event is being run in privacy mode. You are not allowed to search teams.")

            return Team.objects.filter(hidden=False).filter(Q(name__contains=kwargs.get('query')) | Q(affiliation__contains=kwargs.get('query')) | Q(website__contains=kwargs.get('query')))           

    def resolve_team_sovle(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        profile = Profile.objects.get(user=info.context.user)
        return SolvedChallenge.objects.filter(team=profile.team)

    def resolve_flag_tracker(self, info, **kwargs):
        if validate_user_is_staff(info.context.user):
            return FlagTracker.objects.all()
        else:
            raise Exception('Not authorized to view flag tracking information')


# ------------------- MUTATIONS -------------------

class AddTeam(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        name        = graphene.String(required=True)
        email       = graphene.String(required=True)
        affiliation = graphene.String(required=True)
        accesscode  = graphene.String(required=False)

    # TODO: VALIDATION CHECK!!
    def mutate(self, info, name, email, affiliation, accesscode=None):
        validate_user_is_admin(info.context.user)

        
        team = Team(name=name, email=email, affiliation=affiliation)
        team.save()

        if accesscode:
            AccessCode(team=team, value=accesscode).save()
        else:
            AccessCode(team=team, value=''.join(random.choices(string.ascii_uppercase + string.digits, k=10))).save()

        return AddTeam(code=0)

class UpdateTeam(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        id          = graphene.Int(required=True)
        name        = graphene.String(required=True)
        affiliation = graphene.String(required=True)
        email       = graphene.String(required=True)
        website     = graphene.String(required=True)
        accesscode  = graphene.String(required=True)
        

    # TODO: VALIDATION CHECK!!
    # TODO: Make it so it is not need to submit every state to change the info
    def mutate(self, info, id, name, affiliation, email, website, accesscode): #, accesscode=None):
        validate_user_is_admin(info.context.user)
        try:
            team = Team.objects.get(pk=id)
            team.name = name
            team.affiliation = affiliation
            team.email = email
            team.website = website
            team.accesscode.value = accesscode
            team.save()

            code = 0
        except:
            code = 1

        return UpdateTeam(code)

class RemoveTeam(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        name        = graphene.String(required=True)

    # TODO: VALIDATION CHECK!!
    def mutate(self, info, name): #, accesscode=None):
        validate_user_is_admin(info.context.user)
        try:
            team = Team.objects.get(name=name)
            team.delete()
            code = 0
        except:
            code = 1

        return RemoveTeam(code)


#TODO: Move to queries
class TeamGraph(graphene.Mutation):
    timeline = graphene.String()
    message = graphene.String() 

    class Arguments:
        name = graphene.String(required=True)

    def mutate(self, info, name):
        validate_user_is_authenticated(info.context.user)

        team = Team.objects.get(name__iexact=name)
        # print(team)
        # print(team.solved.all().order_by('timestamp'))

        graph = [{'label': team.name, 'data': [], 'backgroundColor': '#FFD700', 'borderColor': '#FFD700', 'fill': 'false'}]

        for solve in team.solved.all().order_by('timestamp'):
            if graph[0]['data']:
                graph[0]['data'].append(graph[0]['data'][-1]+solve.challenge.points)
            else:
                graph[0]['data'].append(solve.challenge.points)

        timeline = []
        for solve in team.solved.all().order_by('timestamp'):
            timeline.append(solve.timestamp.strftime("%I:%M:%S"))

        # print(graph, timeline)

        return TeamGraph(json.dumps(timeline), json.dumps(graph))

class Graph(graphene.Mutation):
    timeline = graphene.String()
    message = graphene.String()

    class Arguments:
        number = graphene.Int(required=False)

    def mutate(self, info, number=10):
        validate_user_is_authenticated(info.context.user)

        if not validate_user_is_staff(info.context.user):
            if Event.objects.first() and Event.objects.first().private is True:
                    raise Exception("This event is being run in privacy mode. You are not allowed to query teams.")

        # Sort to get the top 5 by point value
        if validate_user_is_staff(info.context.user):
            teams = sorted(list(Team.objects.all()), key=lambda x: x.points, reverse=True)[:5]
        else:
            teams = sorted(list(Team.objects.filter(hidden=False)), key=lambda x: x.points, reverse=True)[:5]

        # Get all solved challenges from the top 5 teams.
        solved = SolvedChallenge.objects.filter(team__name__in=[team.name for team in teams]).order_by('timestamp')

        graph = []
        for team in teams:
            graph.append({'label': team.name, 'data': [0], 'backgroundColor': '', 'borderColor': '', 'fill': 'false'})

        colors = ['#FFD700', '#909497', '#A46628', '#3232CD', '#93C54B']

        # Build colors
        for i, team in enumerate(graph):
            team['backgroundColor'] = colors[i]
            team['borderColor'] = colors[i]


        # Construct the data for solved timelinw
        for solve in solved:

            for team in graph:
                if team["label"] == solve.team.name:
                    if team['data']:
                        team['data'].append(team['data'][-1]+solve.challenge.points)
                    else:
                        team['data'].append(solve.challenge.points)
                else:
                    if team['data']:
                        team['data'].append(team['data'][-1])
                    else:
                        team['data'].append(0)


        # Construct time for all solved challenges.
        timeline = [0]
        for solve in solved:
            print(solve.timestamp)
            timeline.append(solve.timestamp.strftime("%I:%M:%S"))


        return Graph(json.dumps(timeline), json.dumps(graph))

class Mutation(object):
    addteam = AddTeam.Field()
    removeteam = RemoveTeam.Field()
    updateteam = UpdateTeam.Field()
    teamgraph = TeamGraph.Field()
    graph   = Graph.Field()