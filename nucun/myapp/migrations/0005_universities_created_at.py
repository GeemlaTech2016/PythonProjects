# Generated by Django 3.0.8 on 2021-03-02 07:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0004_auto_20210301_2254'),
    ]

    operations = [
        migrations.AddField(
            model_name='universities',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, default='2021-03-02 00:00:00'),
            preserve_default=False,
        ),
    ]
