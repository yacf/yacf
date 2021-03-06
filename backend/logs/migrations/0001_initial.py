# Generated by Django 2.2.9 on 2021-01-02 20:34

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='LoginTracker',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time', models.DateTimeField(auto_now_add=True)),
                ('address', models.CharField(max_length=16)),
                ('agent', models.CharField(max_length=200)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='track', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Log',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('action', models.CharField(choices=[('CR', 'Create'), ('DL', 'Delete'), ('UP', 'Update')], max_length=2)),
                ('category', models.CharField(choices=[('CA', 'Category'), ('CH', 'Challenge'), ('TE', 'Team'), ('US', 'User'), ('PG', 'Page'), ('SL', 'Solves'), ('SU', 'Survey')], max_length=2)),
                ('time', models.DateTimeField(auto_now_add=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='log', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
