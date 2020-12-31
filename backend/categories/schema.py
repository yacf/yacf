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
    category = graphene.Field(CategoryType, id=graphene.Int())
    categories = graphene.List(CategoryType, first=graphene.Int(), skip=graphene.Int())
    categories_count = graphene.Int()

    def resolve_category(self, info, id=None, **kwargs):
        if validate_user_is_staff(info.context.user):
            return Category.objects.get(id=id)
        else:
            raise Exception("Bad permissions.")

    def resolve_categories(self, info, first=None, skip=None, **kwargs):
        validate_user_is_authenticated(info.context.user)
        if validate_user_is_staff(info.context.user):
            categories = Category.objects.all()
            if skip is not None : 
                categories = categories[skip:]
            if first is not None: 
                categories = categories[:first]
            return categories
        else:
            validate_active_event()
            return Category.objects.filter(hidden=False)

    def resolve_categories_count(self, info, **kwargs):
        if validate_user_is_staff(info.context.user):
            return Category.objects.count()
        else:
            raise Exception("You are not authorized to view this information.")

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