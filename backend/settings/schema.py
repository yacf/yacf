import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin

from settings.models import Event

class EventType(DjangoObjectType):
    class Meta:
        model = Event

class Query(graphene.ObjectType):
    event = graphene.Field(EventType)

    def resolve_event(self, info, **kwargs):
        return Event.objects.all().first()



# ------------------- MUTATIONS -------------------

# class CreatePage(graphene.Mutation):
#     message = graphene.String()

#     class Arguments:
#         name = graphene.String(required=True)
#         url = graphene.String(required=True)
#         content = graphene.String(required=True)

#     def mutate(self, info, name, url, content):
#         validate_user_is_admin(info.context.user)
        
#         page = Page(name=name, url=url, content=content)
#         page.save()

#         return CreatePage(message="Added")
    

# class Mutation(object):
#     createpage = CreatePage.Field()
