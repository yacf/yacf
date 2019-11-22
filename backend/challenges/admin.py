from django.contrib import admin
from .models import Challenge, Hash, Flag, Hint

admin.site.register(Challenge)
admin.site.register(Hash)
admin.site.register(Flag)
admin.site.register(Hint)