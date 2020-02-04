from django.db import models
from logs.models import Log

# TODO: On delete? What happens to the challenges?
class Category(models.Model):
    name = models.CharField(max_length=25, unique=True)
    description = models.CharField(max_length=1000)
    
    hidden = models.BooleanField(default=False) 
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # logs = models.ManyToManyField(Log, related_name='catlogs')

    # def save( self, action=None, user=None, *args, **kwargs ):
    #     log = Log(action=action, category="CA", user=user)
    #     log.save()
    #     super( Category, self ).save( *args, **kwargs )
    #     self.logs.add(log)

    # def delete(self, user=None, *args, **kwargs):
    #     Log(action="DL", category="CA", user=user).save()
    #     super(ImageQuerySet, self).delete(*args, **kwargs)

    def __str__(self):
        return self.name