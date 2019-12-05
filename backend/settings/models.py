from django.db import models

class Event(models.Model):
    name = models.CharField(max_length=25)
    private = models.BooleanField(default=False)
    start = models.DateTimeField()
    end = models.DateTimeField()

    def __str__(self):
        return self.name

class Scoreboard(models.Model):
    hidden = models.BooleanField(default=False)

class Team(models.Model):
    capacity = models.IntegerField(default=0)