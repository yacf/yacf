from django.db import models
from django.contrib.auth.models import User
from teams.models import Team

class AdminRegisterKey(models.Model):
    key = models.CharField(max_length=32)
    singleuse  = models.BooleanField()
    expiration = models.DateTimeField()
    active = models.BooleanField(default=True)

class Profile(models.Model):
    user = models.OneToOneField(User, related_name='profile', on_delete=models.CASCADE)
    verified = models.BooleanField(default=False)
    team = models.ForeignKey(Team, default=None, null=True, blank=True, related_name='players', on_delete=models.SET_NULL)
    hidden = models.BooleanField(default=False)

    def __str__(self):
        return self.user.username

class LoginTracker(models.Model):
    user = models.ForeignKey(User, related_name='tracking', on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True)
    address = models.CharField(max_length=16)
    agent = models.CharField(max_length=200)

    def __str__(self):
        return "%s - %s" % ( self.user.username, self.address )