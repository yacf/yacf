import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin

from pages.models import Page

class PageType(DjangoObjectType):
    class Meta:
        model = Page

class Query(graphene.ObjectType):
    pages = graphene.List(PageType)
    page = graphene.Field(PageType, id=graphene.Int(), url=graphene.String())

    def resolve_pages(self, info, **kwargs):
        if info.context.user.is_anonymous:
            return Page.objects.filter(authenticated=False)
        else:
            return Page.objects.all()

    def resolve_page(self, info, **kwargs):
        if info.context.user.is_anonymous:
            if kwargs.get('id') and kwargs.get('url'):
                return Page.objects.get(pk=kwargs.get('id'), url=kwargs.get('url'), authenticated=False)
            if kwargs.get('id'):
                return Page.objects.get(pk=kwargs.get('id'), authenticated=False)
            if kwargs.get('url'):
                return Page.objects.get(url=kwargs.get('url'), authenticated=False)
        else:
            if kwargs.get('id') and kwargs.get('url'):
                return Page.objects.get(pk=kwargs.get('id'), url=kwargs.get('url'))
            if kwargs.get('id'):
                return Page.objects.get(pk=kwargs.get('id'))
            if kwargs.get('url'):
                return Page.objects.get(url=kwargs.get('url'))

# ------------------- MUTATIONS -------------------

class CreatePage(graphene.Mutation):
    message = graphene.String()

    class Arguments:
        name = graphene.String(required=True)
        url = graphene.String(required=True)
        content = graphene.String(required=True)

    def mutate(self, info, name, url, content):
        validate_user_is_admin(info.context.user)
        
        page = Page(name=name, url=url, content=content)
        page.save()

        return CreatePage(message="Added")
    
class UpdatePage(graphene.Mutation):
    message = graphene.String()

    class Arguments:
        id  = graphene.Int(required=True)
        name = graphene.String(required=False)
        url  = graphene.String(required=False)
        content = graphene.String(required=False)

    def mutate(self, info, id, name=None, url=None, content=None):
        validate_user_is_admin(info.context.user)
        
        #TODO: Catch and send custom error message
        page = Page.objects.get(pk=id)

        if not name and not url and not content:
            raise Exception('Nothing to update') 

        if name:
            page.name = name
        if url:
            page.url = url
        if content:
            page.content = content

        page.save()

        return UpdatePage(message="Updated")

class DeletePage(graphene.Mutation):
    message = graphene.String()

    class Arguments:
        id  = graphene.Int(required=True)

    def mutate(self, info, id):
        validate_user_is_admin(info.context.user)
        
        #TODO: Catch and send custom error message
        page = Page.objects.get(pk=id)
        page.delete()

        return DeletePage(message="Deleted")

class Mutation(object):
    createpage = CreatePage.Field()
    updatepage = UpdatePage.Field()
    deletePage = DeletePage.Field()