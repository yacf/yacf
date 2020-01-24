from django.db import models
from django.contrib.auth.models import User

class LoginTracker(models.Model):
    user = models.ForeignKey(User, related_name='track', on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True)
    address = models.CharField(max_length=16)
    agent = models.CharField(max_length=200)

    def __str__(self):
        return "%s - %s" % ( self.user.username, self.address )

class Log(models.Model):
    LOG_ACTION = [
        ('CR', 'Create'),
        ('DL', 'Delete'),
        ('UP', 'Update'),
    ]
    LOG_CATEGORY = [
        ('CA', 'Category'),
        ('CH', 'Challenge'),
        ('TE', 'Team'),
        ('US', 'User'),
        ('PG', 'Page'),
        ('SL', 'Solves'),
        ('SU', 'Survey'),
    ]

    action = models.CharField(max_length=2, choices=LOG_ACTION)
    category = models.CharField(max_length=2, choices=LOG_CATEGORY)

    user = models.ForeignKey(User, related_name='log', on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return "%s - %s - %s" % ( self.user.username, self.action, self.category )