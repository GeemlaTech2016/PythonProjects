import os

from django.http import Http404
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.shortcuts import render, redirect
from datetime import datetime
import random, string
from django.core.mail import send_mail
from django.conf import settings

from joblib import load, dump

from .forms import *
from .models import *

# Create your views here.
def index(request):
    if 'uid' in request.session and 'role' in request.session:
        return redirect(dashboard)
    else:
        return render(request, 'myapp/index.html')


def dashboard(request):
    if 'uid' in request.session and 'role' in request.session:
        role = request.session['role']
        content_dict = {}
        if role == 'nucadmin':
            content_dict = nucadmindict()
        elif role == 'uniadmin':
            content_dict = uniadmindict(request.session['uid'])
        else:
            content_dict = userdict(request.session['uid'])

        return render(request, 'myapp/dashboard.html', content_dict)
    else:
        return redirect(index)


def nucadmindict():
    university = Universities.objects.all()
    total_univ = len(university)
    student = Students.objects.all()
    total_stud = len(student)
    faculty = Faculties.objects.all()
    total_fac = len(faculty)
    departments = Departments.objects.all()
    total_dept = len(departments)

    return {'universities': total_univ, 'students': total_stud, 'faculties': total_fac, 'departments': total_dept}


def uniadmindict(univemail):
    fac = Faculties.objects.filter(univcode=univemail)
    total_faculties = len(fac)
    student = Students.objects.filter(univcode=univemail)
    total_stud = len(student)
    departments = Departments.objects.all().select_related("facid")
    #depts = []
    '''for d in departments:
        #regd = Departments.objects.get(facid_id=d.facid_id)
        #f = Faculties.objects.get(facid=d.facid)
        depts.append(d.deptcode)
    #departments = Departments.objects.filter(univemail=univcode)'''
    total_dept = len(departments)

    return {'students': total_stud, 'faculties': total_faculties, 'depts': total_dept}


def userdict(studid):
    #regcse = Registercse.objects.filter(studentregno=studid)
    #total_regcse = len(regcse)

    return {}


def signinform(request):
    if request.method == 'POST':
        loginform = LoginForm(request.POST)

        if loginform.is_valid():
            # get form details
            f_userid = loginform.cleaned_data.get('userid')
            f_password = loginform.cleaned_data.get('password')

            # validate user
            try:
                user = Users.objects.get(userid=f_userid)
                if user.password == f_password and user.userid == f_userid:
                    request.session['uid'] = f_userid
                    request.session['role'] = user.role
                    request.session['status'] = user.status

                    if user.role == 'nucadmin':
                        request.session['fullname'] = 'Administrator'
                        request.session['dropname'] = 'Admin'
                        request.session['pic'] = "img-admin.jpg"
                    elif user.role == 'uniadmin':
                        university = Universities.objects.get(univemail=f_userid)
                        request.session['fullname'] = university.uniname
                        request.session['dropname'] = university.abbr
                        request.session['pic'] = university.logo
                        request.session['nucstatus'] = university.nucstatus
                    else:
                        student = Students.objects.get(matno=f_userid)
                        request.session['fullname'] = student.surname
                        request.session['dropname'] = student.matno
                        request.session['pic'] = student.photourl

                    return redirect(dashboard)
            except Users.DoesNotExist:
                raise Http404("No user matches the given query.")

    return render(request, 'myapp/index.html', {'result': 'Incorrect username or password supplied'})


def signout(request):
    try:
        request.session.flush()
    except KeyError:
        print('failed to flush data')
    return redirect(index)


def univregistration(request):
    return render(request, 'myapp/univregistration.html')


def reguniv(request):
    jscript_success = "<script>alert('Registration successful. Proceed to Login'); window.location.href='/';</script>"
    jscript_failed = "<script>alert('Registration failed!'); window.location.href='/univregistration/';</script>"
    if request.method == 'POST':
        regform = UniversityRegForm(request.POST)
        print(regform.errors)
        if regform.is_valid():
            #f_univcode = regform.cleaned_data.get('univcode')
            f_univemail = regform.cleaned_data.get('univemail')
            f_uniname = regform.cleaned_data.get('uniname')
            f_abbr = regform.cleaned_data.get('abbr')
            f_phone = regform.cleaned_data.get('phone')
            f_address = regform.cleaned_data.get('address')

            uploadedfilename = request.FILES['photo'].name
            extension = os.path.splitext(uploadedfilename)[1]
            newfilename = datetime.today().strftime('%Y%m%d%H%M%S') + extension

            fs = FileSystemStorage()
            upload_file = fs.save("myapp/static/myapp/uploads/" + newfilename, request.FILES['photo'])
            filepath = fs.url(upload_file)

            new_user_entry = Users(userid=f_univemail, password=f_univemail, role='uniadmin', status='active')
            new_univ_entry = Universities(univemail=f_univemail, uniname=f_uniname, abbr=f_abbr,
                                     phone=f_phone, address=f_address,
                                     logo=newfilename, nucstatus='pending')

            new_user_entry.save()
            new_univ_entry.save()
            return HttpResponse(jscript_success)
        else:
            return HttpResponse(jscript_failed)


def approvedunis(request):
    if 'uid' in request.session and 'role' in request.session:
        approveduniv = Universities.objects.filter(nucstatus='approved');
        content_dict = {'approveduniv': approveduniv}

        return render(request, 'myapp/approvedunis.html', content_dict)
    else:
        return redirect(index)


def pendingapproval(request):
    if 'uid' in request.session and 'role' in request.session:
        pending = Universities.objects.filter(nucstatus='pending');
        content_dict = {'pending': pending}

        return render(request, 'myapp/pendingapproval.html', content_dict)
    else:
        return redirect(index)


def viewunivdetails(request, univemail):
    if 'uid' in request.session and 'role' in request.session:
        approveduniv = Universities.objects.get(univemail=univemail)
        facs = Faculties.objects.filter(univcode=approveduniv.univemail)
        processed_depts = {}
        depts = Departments.objects.all()

        for f in facs:
            depts = Departments.objects.filter(facid=f.id)

        content_dict = {'univ': approveduniv, 'faculties': facs, 'depts': depts}

        return render(request, 'myapp/viewunivdetails.html', content_dict)
    else:
        return redirect(index)


def removeuni(request):
    if request.method == 'POST':
        remform = RemUnivForm(request.POST)

        if remform.is_valid():
            f_univemail = remform.cleaned_data.get('delid')
            user = Users.objects.get(userid=f_univemail)
            uni = Universities.objects.get(univemail=f_univemail)
            photo = "myapp/static/myapp/uploads/" + uni.photo

            if os.path.exists(photo):
                os.remove(photo)

            user.delete()
            uni.delete()
        return redirect(pendingapproval)


def approveuni(request):
    if request.method == 'POST':
        remform = ApproveUnivForm(request.POST)
        print(remform.errors)
        if remform.is_valid():
            f_univemail = remform.cleaned_data.get('appid')
            try:
                uni = Universities.objects.get(univemail=f_univemail)
            except Universities.DoesNotExist:
                return redirect(pendingapproval)
            uni.nucstatus = 'approved'
            uni.save()
        return redirect(pendingapproval)


def showfaculties(request):
    if 'uid' in request.session and 'role' in request.session:
        facs = Faculties.objects.filter(univcode=request.session['uid'])
        #sub_cse = []
        #for sc in facs:
         #   sub_cse.append(sc.coursecode)

        content_dict = {'faculties': facs}
        return render(request, 'myapp/faculties.html', content_dict)
    else:
        return redirect(index)


def faculties(request):
    jscript_failed = "<script>alert('Registration failed!'); window.location.href='/showfaculties/';</script>"
    if 'uid' in request.session and 'role' in request.session:
        if request.method == 'POST':
            regform = FacultyRegForm(request.POST)
            print(regform.errors)
            if regform.is_valid():
                f_univcode = request.session['uid']
                f_facid = 'fac'+datetime.today().strftime('%Y%m%d%H%M%S')
                f_name = regform.cleaned_data.get('facname')

                new_fac_entry = Faculties(facid=f_facid, facname=f_name, univcode=f_univcode)

                new_fac_entry.save()
                return redirect(showfaculties)
            else:
                return HttpResponse(jscript_failed)


def removefac(request):
    if request.method == 'POST':
        remform = RemFacultyForm(request.POST)

        if remform.is_valid():
            f_id = remform.cleaned_data.get('delid')
            fac = Faculties.objects.get(id=f_id)

            fac.delete()
        return redirect(showfaculties)


def showdepartments(request):
    if 'uid' in request.session and 'role' in request.session:
        facs = Faculties.objects.filter(univcode=request.session['uid'])
        depts = Departments.objects.all()
        processed_depts = {}

        for dp in depts:
            #department = Departments.objects.get(facid=dp.facid)
            faculty = Faculties.objects.get(id=dp.facid_id)

            sub_depts = {'facname': faculty.facname, 'deptcode': dp.deptcode,
                           'deptname': dp.deptname, 'facid': dp.facid}

            processed_depts[dp.deptcode] = sub_depts

        content_dict = {'departments': processed_depts, 'faculties':facs}
        return render(request, 'myapp/departments.html', content_dict)
    else:
        return redirect(index)


def departments(request):
    jscript_failed = "<script>alert('Registration failed!'); window.location.href='/showdepartments/';</script>"
    if 'uid' in request.session and 'role' in request.session:
        if request.method == 'POST':
            regform = DeptRegForm(request.POST)
            print(regform.errors)
            if regform.is_valid():
                d_deptid = 'd'+datetime.today().strftime('%Y%m%d%H%M%S')
                d_name = regform.cleaned_data.get('deptname')
                f_facid = regform.cleaned_data.get('faculty')
                fac = Faculties.objects.get(id=f_facid)

                new_dept_entry = Departments(deptcode=d_deptid, deptname=d_name, facid=fac)

                new_dept_entry.save()
                return redirect(showdepartments)
            else:
                return HttpResponse(jscript_failed)


def removedept(request):
    if request.method == 'POST':
        remform = RemDeptForm(request.POST)

        if remform.is_valid():
            f_id = remform.cleaned_data.get('delid')
            dept = Departments.objects.get(id=f_id)

            dept.delete()
        return redirect(showdepartments)


def liststudents(request):
    if 'uid' in request.session and 'role' in request.session:
        students = Students.objects.filter(univcode=request.session['uid'])
        facs = Faculties.objects.filter(univcode=request.session['uid'])
        depts = Departments.objects.all()
        processed_stds = {}

        for std in students:
            department = Departments.objects.get(deptcode=std.deptcode)
            faculty = Faculties.objects.get(id=department.facid_id)

            sub_stds = {'surname': std.surname, 'othernames': std.othernames, 'nucno':std.nucno, 'matno':std.matno,
                        'yearofgrade': std.yearofgrade, 'phone': std.phone, 'photourl':std.photourl,
                        'facname': faculty.facname, 'deptcode': department.deptcode, 'deptname': department.deptname}

            processed_stds[std.nucno] = sub_stds

        content_dict = {'studs': processed_stds}

        return render(request, 'myapp/liststudents.html', content_dict)
    else:
        return redirect(index)


def removestudent(request):
    if request.method == 'POST':
        remform = RemStudentForm(request.POST)

        if remform.is_valid():
            f_id = remform.cleaned_data.get('delid')
            std = Students.objects.get(id=f_id)

            std.delete()
        return redirect(liststudents)


def showstudentform(request):
    if 'uid' in request.session and 'role' in request.session:
        univ = Universities.objects.get(univemail=request.session['uid'])
        facs = Faculties.objects.filter(univcode=request.session['uid'])
        depts = Departments.objects.all()
        processed_depts = {}

        for dp in depts:
            #department = Departments.objects.get(facid=dp.facid_id)
            faculty = Faculties.objects.get(id=dp.facid_id)

            sub_depts = {'facname': faculty.facname, 'deptcode': dp.deptcode,
                         'deptname': dp.deptname, 'facid': dp.facid}

            processed_depts[dp.deptcode] = sub_depts

        content_dict = {'faculties': facs, 'depts': processed_depts, 'departments': depts, 'abbr': univ.abbr, 'univcode': univ.univemail}

        return render(request, 'myapp/newstudent.html', content_dict)
    else:
        return redirect(index)


def newstudent(request):
    jscript_success = "<script>alert('Student registered successfully!'); window.location.href='/newstudent/';</script>"
    jscript_failed = "<script>alert('Registration failed!'); window.location.href='/newstudent/';</script>"
    if request.method == 'POST':
        regform = StudentRegForm(request.POST)
        print(regform.errors)
        if regform.is_valid():
            f_matno = regform.cleaned_data.get('matno')
            f_surname = regform.cleaned_data.get('surname')
            f_othernames = regform.cleaned_data.get('othernames')
            f_gender = regform.cleaned_data.get('gender')
            f_abbr = regform.cleaned_data.get('abbr')
            f_phone = regform.cleaned_data.get('phone')
            f_email = regform.cleaned_data.get('email')
            f_facid = regform.cleaned_data.get('facid')
            f_deptcode = regform.cleaned_data.get('deptcode')
            f_courseofstudy = regform.cleaned_data.get('courseofstudy')
            f_coursealias = regform.cleaned_data.get('coursealias')
            f_fullyear = regform.cleaned_data.get('fullyear')
            f_yearofgrad = f_fullyear[0:4]
            f_certificateno = regform.cleaned_data.get('certificateno')
            f_univcode = request.session['uid']

            f_nucno = 'NUC/'+f_abbr+'/'+f_coursealias+'/'+f_yearofgrad+'/'+''.join(random.choices(string.ascii_letters + string.digits, k=6))

            uploadedfilename = request.FILES['photourl'].name
            extension = os.path.splitext(uploadedfilename)[1]
            newfilename = datetime.today().strftime('%Y%m%d%H%M%S') + extension

            fs = FileSystemStorage()
            upload_file = fs.save("myapp/static/myapp/uploads/" + newfilename, request.FILES['photourl'])
            filepath = fs.url(upload_file)

            certfilename = request.FILES['certphotourl'].name
            extension2 = os.path.splitext(certfilename)[1]
            newfilename2 = datetime.today().strftime('%Y%m%d%H%M%S') + extension2

            fs = FileSystemStorage()
            upload_file2 = fs.save("myapp/static/myapp/uploads/" + newfilename2, request.FILES['certphotourl'])
            filepath2 = fs.url(upload_file2)

            new_user_entry = Users(userid=f_matno, password=f_matno, role='student', status='active')
            new_std_entry = Students(nucno=f_nucno, matno=f_matno, surname=f_surname, othernames=f_othernames,
                                     gender=f_gender, phone=f_phone, email=f_email, univcode=f_univcode,facid=f_facid,
                                     deptcode=f_deptcode, courseofstudy=f_courseofstudy, yearofgrade=f_yearofgrad,
                                     fullyear=f_fullyear, photourl=newfilename)
            new_cert_entry = Certificates(matno=f_matno, fullyear=f_fullyear, certificateno=f_certificateno,
                                     certimageurl=newfilename2)

            new_user_entry.save()
            new_std_entry.save()
            new_cert_entry.save()
            return HttpResponse(jscript_success)
        else:
            return HttpResponse(jscript_failed)


def searchstudent(request):
    return render(request, 'myapp/searchstudent.html')


#Send Email
def sendemail(request):
    sub = forms.SearchStudentForm()
    otp = ''
    if request.method == 'POST':
        otp = ''.join(random.choices(string.ascii_letters + string.digits, k=6))
        otpid = 'otp'+datetime.today().strftime('%Y%m%d%H%M%S')
        sub = forms.SearchStudentForm(request.POST)
        subject = 'NUC Unique ID Portal'
        message = 'Your One-Time-Pin is: ' + otp
        f_orgemail = sub.cleaned_data.get('orgemail')
        f_nucid = sub.cleaned_data.get('nucid')
        send_mail(subject, message, settings.EMAIL_HOST_USER, [f_orgemail], fail_silently = False)

        new_otp_entry = Otps(otpid=otpid, userid=f_orgemail, otpvalue=otp, expirydate=datetime.today().strftime('%Y%m%d%H%M%S'))
        new_otp_entry.save()

        return render(request, 'myapp/success.html', {'recepient': f_orgemail, 'nucid': f_nucid})
    return render(request, 'myapp/index.html', {'form':sub})