import os

from django.contrib import admin
from django.urls import path, re_path
from django.views.decorators.csrf import csrf_exempt
from django.views.generic import TemplateView
from graphene_django.views import GraphQLView

if os.environ.get("DEBUGGER") == 'True':
    show = True
else:
    show = True

urlpatterns = [
    path('21232f297a57a5a743894a0e4a801fc3/', admin.site.urls),
    path('api/', csrf_exempt(GraphQLView.as_view(graphiql=show))),
]
