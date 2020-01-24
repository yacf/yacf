import graphene
from graphene_django import DjangoObjectType
from uauth.validators import validate_user_is_authenticated, validate_user_is_admin, validate_user_is_staff
from settings.validators import validate_active_event
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User

from .models import Category

class CategoryType(DjangoObjectType):
    class Meta:
        model = Category

class Query(graphene.ObjectType):
    categories = graphene.List(CategoryType)

    def resolve_categories(self, info, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            return Category.objects.all()
        else:
            validate_active_event()
            return Category.objects.filter(hidden=False)

# ------------------- MUTATIONS -------------------

class AddCategory(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        name        = graphene.String(required=True)
        description = graphene.String(required=True)

    def mutate(self, info, name, description):
        validate_user_is_admin(info.context.user)

        Category(name=name, description=description).save(action="CR", user=info.context.user)

        return AddCategory(code=0)

class RemoveCategory(graphene.Mutation):
    message = graphene.String()

    class Arguments:
        id = graphene.Int(required=True)

    def mutate(self, info, id):
        validate_user_is_admin(info.context.user)
        # try:
        category = Category.objects.get(pk=id)
        category.delete(user=info.context.user)
        message = "success"
        # except:
        #     message = "failure"

        return RemoveCategory(message)

class UpdateCategory(graphene.Mutation):
    code = graphene.Int()

    class Arguments:
        id          = graphene.Int(required=True)
        name        = graphene.String(required=True)
        description = graphene.String(required=True)

    def mutate(self, info, id, name, description):
        validate_user_is_admin(info.context.user)
        
        category = Category.objects.get(pk=id)
        category.name = name
        category.description = description
        category.save()

        return UpdateCategory(code=0)

class Mutation(object):
    addcategory = AddCategory.Field()
    removeCategory = RemoveCategory.Field()
    updateCategory = UpdateCategory.Field()