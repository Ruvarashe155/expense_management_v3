from django.urls import path
from . import views
from django.contrib.auth import views as auth_views

app_name="expenses"


urlpatterns = [
    path('', auth_views.LoginView.as_view(template_name='login.html'), name='login'),
    path('logout', auth_views.LogoutView.as_view(template_name='login.html'), name='logout'),
    path('home', views.home, name='home'),



    path('password_reset/', auth_views.PasswordResetView.as_view(), name='password_reset'),
    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('reset/done/', auth_views.PasswordResetCompleteView.as_view(), name='password_reset_complete'),


    

    path('cancel/<int:request_id>/', views.cancel_expense_request, name='cancel_request'),
    # path('save/', views.save_expense_request, name='save_expense'),
    path("save_department", views.save_department, name='save_department'),
    path("save_category", views.save_category, name="save_category"),
    path("save_user", views.save_user, name='save_user'),
    path('save_budget' ,views.save_budget, name='save_budget'),
    path("create/", views.create_expense_request, name="create_expense"),
    path('expense/<int:pk>/approve/', views.approve_expense_request, name='approve_expense'),
    path('expense/<int:pk>/reject/', views.reject_expense_request, name='reject_expense'),
    path("expense/<int:pk>/disburse/", views.disburse_expense, name="disburse_expense"),
    path("expense/<int:expense_id>/", views.expense_detail, name="expense_detail"),
    path("expense/<int:expense_id>/add_item/", views.add_item, name="add_item"),
    
    path("item/<int:item_id>/delete/", views.delete_item, name="delete_item"),
    path("receipt/<int:pk>/upload/", views.upload_receipt, name="upload_receipt"),
    path("budget_report", views.department_budget_report, name="budget_report"),
    path("notifications/read/<int:pk>/", views.mark_notification_read, name="mark_notification_read"),

    path("notifications", views.note, name="notifications"),

    path('index', views.index, name='index'),
    path('backup/', views.backup_database, name='backup'),
    path('restore/', views.restore_database, name='restore'),
    path('expense_report/', views.expense_report_view, name="expense_report"),
    path('reports_dashboard/', views.reports_dashboard, name='reports_dashboard')





]
