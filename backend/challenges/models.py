from django.db import models
from categories.models import Category

class Challenge(models.Model):
    # TODO: REMOVE delete on cascade! We may not want to delete all the challenges too
    category = models.ForeignKey(Category, null=False, on_delete=models.CASCADE, related_name='challenges')

    name = models.CharField(max_length=25)
    description = models.CharField(max_length=1000)

    points = models.IntegerField(default=0)
    encoded = models.BooleanField(default=False)
    hidden = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Hint(models.Model):
    challenge = models.ForeignKey(Challenge, on_delete=models.CASCADE, related_name='hints')

    title = models.CharField(max_length=25)
    description = models.CharField(max_length=1000)
    hidden = models.BooleanField(default=True)

    def __str__(self):
        return self.challenge.name

class Hash(models.Model):
    value = models.CharField(max_length=10)

    def __str__(self):
        return self.value

class Flag(models.Model):
    challenge = models.OneToOneField(Challenge, on_delete=models.CASCADE, related_name='flag')
    value = models.CharField(max_length=100)
    algorithm = models.ForeignKey(Hash, null=True, blank=True, on_delete=models.SET_NULL, related_name='hash')

    def __str__(self):
        return self.challenge.name

