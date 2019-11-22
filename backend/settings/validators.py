from settings.models import Event
from django.utils import timezone

# Confirm event is ongoing
def validate_active_event():
    event = Event.objects.first()
    if event:
        now = timezone.now()
        if now > event.start and now < event.end:
            return True
        else:
            raise Exception("Event has not started yet.")
    else:
        raise Exception("There is no event")