from django import forms


class LoginForm(forms.Form):
    userid = forms.CharField(max_length=100)
    password = forms.CharField(widget=forms.PasswordInput())


class UniversityRegForm(forms.Form):
    univemail = forms.CharField(max_length=30)
    uniname = forms.CharField()
    abbr = forms.CharField()
    phone = forms.CharField()
    address = forms.CharField()
    # photo = forms.FileField()


class RemUnivForm(forms.Form):
    delid = forms.CharField(widget=forms.HiddenInput)


class ApproveUnivForm(forms.Form):
    appid = forms.CharField(widget=forms.HiddenInput)


class FacultyRegForm(forms.Form):
    facname = forms.CharField(max_length=50)


class RemFacultyForm(forms.Form):
    delid = forms.CharField(widget=forms.HiddenInput)


class RemDeptForm(forms.Form):
    delid = forms.CharField(widget=forms.HiddenInput)


class DeptRegForm(forms.Form):
    deptname = forms.CharField(max_length=50)
    faculty = forms.CharField(widget=forms.Select)


class RemStudentForm(forms.Form):
    delid = forms.CharField(widget=forms.HiddenInput)


class StudentRegForm(forms.Form):
    matno = forms.CharField(max_length=30)
    surname = forms.CharField()
    othernames = forms.CharField()
    gender = forms.CharField(widget=forms.Select)
    abbr = forms.CharField(widget=forms.HiddenInput)
    phone = forms.CharField()
    email = forms.CharField()
    facid = forms.CharField(widget=forms.Select)
    deptcode = forms.CharField(widget=forms.Select)
    courseofstudy = forms.CharField()
    coursealias = forms.CharField()
    certificateno = forms.CharField()
    fullyear = forms.CharField()


class SearchStudentForm(forms.Form):
    orgemail = forms.CharField(max_length=50)
    nucid = forms.CharField(widget=forms.Select)