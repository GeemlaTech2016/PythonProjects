from django.urls import path, re_path
from . import views

urlpatterns = [
    path('', views.index, name='login'),
    re_path(r'^dashboard/$', views.dashboard, name='dashboard'),
    re_path(r'^signin_form/$', views.signinform),
    re_path(r'^signout/$', views.signout),
    re_path(r'^approvedunis/$', views.approvedunis),
    re_path(r'^approveuni/$', views.approveuni),
    re_path(r'^removeuni/$', views.removeuni),
    re_path(r'^pendingapproval/$', views.pendingapproval),
    path('viewdetails/<str:univemail>', views.viewunivdetails),
    re_path(r'^systemlogs/$', views.signout),
    re_path(r'^faculties/$', views.showfaculties),
    re_path(r'^addfaculty/$', views.faculties),
    re_path(r'^removefac/$', views.removefac),
    re_path(r'^departments/$', views.showdepartments),
    re_path(r'^adddepartment/$', views.departments),
    re_path(r'^removedept/$', views.removedept),
    re_path(r'^newstudent/$', views.showstudentform),
    re_path(r'^postnewstudent/$', views.newstudent),
    re_path(r'^liststudents/$', views.liststudents),
    re_path(r'^viewstudentdetails/<str:nucno>', views.pendingapproval),
    re_path(r'^removestudent/$', views.removestudent),
    re_path(r'^univregistration/$', views.univregistration),
    re_path(r'^reguniv/$', views.reguniv),
    re_path(r'^searchstudent/$', views.searchstudent),
]