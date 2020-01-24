import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin

from logs.models import Log

class LogType(DjangoObjectType):
    class Meta:
        model = Log

class Query(graphene.ObjectType):
    logs = graphene.List(LogType)

    def resolve_logs(self, info, **kwargs):
        validate_user_is_admin(info.context.user)
        return Log.objects.all()
