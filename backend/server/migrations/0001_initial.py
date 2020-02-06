# Generated by Django 2.2 on 2020-02-06 03:48

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Theme',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=25)),
                ('primary', models.CharField(max_length=8)),
                ('secondary', models.CharField(max_length=8)),
                ('foucs', models.CharField(max_length=8)),
                ('accent', models.CharField(max_length=8)),
            ],
        ),
    ]
