# Generated by Django 2.1.8 on 2019-12-12 16:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('logs', '0002_log'),
        ('categories', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='category',
            name='logs',
            field=models.ManyToManyField(related_name='catlogs', to='logs.Log'),
        ),
    ]
