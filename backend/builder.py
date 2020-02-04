import yaml
import hashlib

import os, django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "core.settings")
django.setup()

import argparse, contextlib
import json
from django.utils import timezone
from datetime import timedelta
from core.settings import DATABASES
from django.contrib.auth.models import User
from uauth.models import Profile
from teams.models import Team, AccessCode
from categories.models import Category
from challenges.models import Challenge, Flag
from settings.models import Event
from settings.models import Team as Capacity 
from uauth.validators import validate_username, validate_password, validate_email

'''
Takes in YAML flag--
flag:
    - value: "test"
      precomputed: False
      hash: False
'''
def compute_flag(flag):
    if flag.get('hashed', False):
        if flag.get('precomputed', False):
            return flag['value']
        else:
            return hashlib.sha256(flag['value'].encode('utf-8')).hexdigest()
    else:
        return flag['value']


with open("../testing/config.yaml", 'r') as f:
    data = yaml.load(f, Loader=yaml.FullLoader)

    if data.get('event'):
        print(data.get('event'))
        event = Event(name=data['event']['name'], private=data['event']['privacy'], start=data['event']['time']['start'], end=data['event']['time']['end'])
        event.save()

    if data.get('setting'):
        cap = Capacity(capacity=data['setting']['team']['capacity'])
        cap.save()

    for cat in data['board']['categories']:
        print(cat['name'])

        ca = Category(name=cat['name'], description=cat['description'])
        ca.save()

        '''
            Challenge create. 
            Required: Category, Name, Description, Points, Flag 
        '''
        for challenge in cat['challenges']:
            print(" |--", challenge['name'])

            if challenge['name'] and challenge['description'] and challenge['points'] and challenge['flag']:
                chal = Challenge(category=ca, name=challenge['name'], description=challenge['description'], points=challenge['points'], hidden=False)
                chal.save()
                flag_v = compute_flag(challenge['flag'])
                flag = Flag(value=flag_v, hashed=challenge['flag']['hashed'], challenge=chal)
                flag.save()
            else:
                print("Failed", challenge)
                exit()

            
