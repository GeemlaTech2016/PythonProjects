from django.db import models

# Create your models here.
class Users(models.Model):
    userid = models.CharField(primary_key=True, max_length=50)
    password = models.CharField(max_length=30)
    role = models.CharField(max_length=10)
    status = models.CharField(max_length=10)


class Universities(models.Model):
    univemail = models.CharField(primary_key=True, max_length=30)
    uniname = models.CharField(max_length=150)
    abbr = models.CharField(max_length=5)
    phone = models.CharField(max_length=15)
    address = models.CharField(max_length=200)
    logo = models.CharField(max_length=100)
    nucstatus = models.CharField(max_length=10)
    created_at = models.DateTimeField(auto_now_add=True)


class Faculties(models.Model):
    facid = models.CharField(max_length=30)
    facname = models.CharField(max_length=60)
    univcode = models.CharField(max_length=30)


class Departments(models.Model):
    deptcode = models.CharField(max_length=20)
    deptname = models.CharField(max_length=60)
    facid = models.ForeignKey(Faculties, on_delete=models.SET_NULL,
        blank=True,
        null=True,)


class Courses(models.Model):
    coursecode = models.CharField(max_length=20)
    coursename = models.CharField(max_length=60)
    deptcode = models.CharField(max_length=20)


class Students(models.Model):
    nucno = models.CharField(primary_key=True, max_length=50)
    matno = models.CharField(unique=True, max_length=25)
    surname = models.CharField(max_length=20)
    othernames = models.CharField(max_length=50)
    gender = models.CharField(max_length=7)
    phone = models.CharField(max_length=15)
    email = models.CharField(max_length=30)
    univcode = models.CharField(max_length=30)
    facid = models.CharField(max_length=30)
    deptcode = models.CharField(max_length=30)
    courseofstudy = models.CharField(max_length=20)
    yearofgrade = models.CharField(max_length=4)
    fullyear = models.CharField(max_length=15)
    photourl = models.CharField(max_length=100)


class Certificates(models.Model):
    matno = models.CharField(primary_key=True, max_length=25)
    fullyear = models.CharField(max_length=15)
    certificateno = models.CharField(max_length=20)
    certimageurl = models.CharField(max_length=100)


class Otps(models.Model):
    otpid = models.CharField(primary_key=True, max_length=25)
    userid = models.CharField(max_length=25)
    otpvalue = models.CharField(max_length=10)
    expirydate = models.CharField(max_length=30)