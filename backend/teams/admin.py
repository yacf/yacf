from django.contrib import admin
from .models import Team, AccessCode, SolvedChallenge, Failure, FlagTracker

admin.site.register(Team)
admin.site.register(AccessCode)
admin.site.register(SolvedChallenge)
admin.site.register(Failure)
admin.site.register(FlagTracker)