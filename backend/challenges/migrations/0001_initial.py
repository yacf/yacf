# Generated by Django 2.2.9 on 2021-01-02 20:34

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('categories', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Challenge',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=40, unique=True)),
                ('description', models.CharField(max_length=3000)),
                ('points', models.IntegerField(default=0)),
                ('encoded', models.BooleanField(default=False)),
                ('hidden', models.BooleanField(default=False)),
                ('resubmit', models.BooleanField(default=False)),
                ('release_time', models.DateTimeField(null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='challenges', to='categories.Category')),
            ],
        ),
        migrations.CreateModel(
            name='Hint',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=25)),
                ('description', models.CharField(max_length=1000)),
                ('hidden', models.BooleanField(default=True)),
                ('challenge', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='hints', to='challenges.Challenge')),
            ],
        ),
        migrations.CreateModel(
            name='Flag',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('value', models.CharField(max_length=100)),
                ('hashed', models.BooleanField(default=False)),
                ('case_sensitive', models.BooleanField(default=True)),
                ('resubmit', models.BooleanField(default=False)),
                ('challenge', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='flag', to='challenges.Challenge')),
            ],
        ),
    ]
