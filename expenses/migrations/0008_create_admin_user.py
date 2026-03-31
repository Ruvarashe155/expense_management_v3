from django.db import migrations
from django.contrib.auth.hashers import make_password

def create_admin_user(apps, schema_editor):
    CustomUser = apps.get_model("expenses", "CustomUser")
    if not CustomUser.objects.filter(email="admin@gmail.com").exists():
        user = CustomUser(
            email="admin@gmail.com",
            username="admin@gmail.com",
            fullname="Ruvarashe Shoko",
            role="Admin",
            is_staff=True,
            is_superuser=True,
            is_active=True,
            password=make_password("1234"),  # hash the password properly
        )
        user.save()

class Migration(migrations.Migration):

    dependencies = [
        ("expenses", "0007_customuser_username"),  # replace with your latest migration name
    ]

    operations = [
        migrations.RunPython(create_admin_user),
    ]
