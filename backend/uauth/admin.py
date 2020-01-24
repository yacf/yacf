from django.contrib import admin
from .models import AdminRegisterKey, Profile, LoginTracker

admin.site.register(AdminRegisterKey)
admin.site.register(Profile)
admin.site.register(LoginTracker)