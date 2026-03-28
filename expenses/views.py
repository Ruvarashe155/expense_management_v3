from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, HttpResponse, redirect, get_object_or_404
from .models import *
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
from django.db.models import Sum, Value, DecimalField 
from django.db.models.functions import Coalesce



def login_user(request):
    if request.method == 'POST':
        try:
            username = request.POST.get('username')
            password = request.POST.get('password')

            if not username or not password:
                raise ValueError("Username and password are required.")

            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                return JsonResponse({'success': True, 'message': 'Login successful'})
            else:
                return JsonResponse({'success': False, 'message': 'Incorrect username or password'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': 'An error occurred during login.', 'error': str(e)})
        
    return render(request, 'login.html')



def logoutuser(request):
    return render(request, 'login.html')


def home(request):
    expenses = ExpenseRequest.objects.all()
    notifications = Notification.objects.filter(user=request.user).order_by('-timestamp')
    return render(request, 'home.html', {'expenses': expenses, "notifications":notifications})

from django.shortcuts import redirect, get_object_or_404
from .models import Notification

def mark_notification_read(request, pk):
    note = get_object_or_404(Notification, pk=pk, user=request.user)
    note.mark_as_read()
    return redirect("expenses:home")  # or wherever you want to send the user back


@login_required
def save_department(request):
    if request.method=="POST":

        code=request.POST.get('code')
        name=request.POST.get('name')
        description=request.POST.get('description')
        hod=request.POST.get('hod')
        id=request.POST.get('id')


        if id:
            existing_dep =Department.objects.get(id=id)
            existing_dep.name=name
            existing_dep.description=description
            existing_dep.code=code
            existing_dep.head_of_department=hod
            existing_dep.save()

        else:
            department=Department(name=name, code=code, description=description, head_of_department=hod)
            department.save()

    context={
        'department_list': Department.objects.all()
    }    
    return render(request, 'department.html', context)


@login_required
def save_category(request):
    if request.method=="POST":
        name=request.POST.get('name')
        description=request.POST.get('description')
        id=request.POST.get('id')
        
        if id:
            existing_cat =ExpenseCategory.objects.get(id=id)
            existing_cat.name=name
            existing_cat.description=description
            existing_cat.save()
        else:    
            category=ExpenseCategory(name=name,  description=description,)
            category.save()

    context={
        'category_list': ExpenseCategory.objects.all()
    }    
    return render(request, 'category.html', context)


@login_required
def save_user(request):

    user = request.user 
    if user.role == "Head": 
        users = CustomUser.objects.filter(department=user.department) 
    else: 
        users = CustomUser.objects.none()     
    
    
    if request.method == "POST":


        fullname = request.POST.get('fullname')
        department_id = request.POST.get('department')
        role = request.POST.get('role')
        email = request.POST.get('email')
        password = request.POST.get('password')
        id=request.POST.get('id')
        is_active=request.POST.get('active')

        # Get department by ID
        department = Department.objects.get(id=department_id)

        if id:
            existing_user_entry=CustomUser.objects.get(id=id)
            existing_user_entry.fullname=fullname
            existing_user_entry.department=department
            existing_user_entry.role=role
            existing_user_entry.password=password
            existing_user_entry.email=email
            existing_user_entry.is_active = is_active
            existing_user_entry.save()

        # Create user (using fullname as username for simplicity)
        else:
            user = CustomUser.objects.create_user(
                username=email.replace(" ", ""),  # simple username
                password=password,  # you can later add a password field in the form
                fullname=fullname,
                department=department,
                role=role,
                email=email,
                is_active= is_active
            )

        return redirect('expenses:save_user')  # redirect after saving

    context = {
        'department_list': Department.objects.all(),
        'user_list': CustomUser.objects.all(),
        # "user_list":users
    }
    return render(request, 'users.html', context)


from django.utils import timezone
from decimal import Decimal
from django.db.models import Q

@login_required
def create_expense_request(request):
    user = request.user 
    if user.role == "Staff": 
        expenses = ExpenseRequest.objects.filter(user=user) 
    elif user.role in ["Head", "Dean"]: 
        expenses = ExpenseRequest.objects.filter(department=user.department) 
    elif user.role == "Finance": 
        expenses = ExpenseRequest.objects.filter(Q(status="Approved",) |Q(status="Disbursed")) 

    elif user.role == "Admin":  # Admin can see all expenses
        expenses = ExpenseRequest.objects.all() 

    elif user.role == "Dean":  # Admin can see all expenses
        expenses = ExpenseRequest.objects.all() 
    

    else: 
        expenses = ExpenseRequest.objects.none()
        
    if request.method == "POST":

        try:
            # ---- Main Request Fields ----
            name = request.POST.get("name")
            date = request.POST.get("date")
            description = request.POST.get("description")
            total_amount = request.POST.get("total_amount")
            category = ExpenseCategory.objects.get(id=request.POST.get("category"))
            # user = CustomUser.objects.get(id=request.POST.get("user"))
            user= request.user
            
            # department = Department.objects.get(code=request.POST.get("department"))
            department = request.user.department
           




            today = timezone.now().date()
            budget = DepartmentBudget.objects.filter(
                department=department,
                start_date__lte=today,
                end_date__gte=today
            ).first()

            if not budget: 
                messages.error(request, "No active budget found for this department.") 
                return redirect("expenses:create_expense")

            spent_amount = ExpenseRequest.objects.filter(
            department=department,
            date__gte=budget.start_date,
            date__lte=budget.end_date
            ).aggregate(total=models.Sum('total_amount'))['total'] or Decimal('0.00')

            if spent_amount + Decimal(total_amount) > budget.budget_amount: 
                messages.error(request, "Request exceeds department budget!") 
                return redirect("expenses:create_expense")



            # ---- Create Expense Request ----
            expense_request = ExpenseRequest.objects.create(
                name=name,
                date=date,
                description=description,
                total_amount=total_amount,
                category=category,
                department=department,
                user=user
            )

            # ---- Create Expense Items ----
            index = 0
            while True:
                desc_key = f"items[{index}][description]"
                amount_key = f"items[{index}][amount]"

                item_desc = request.POST.get(desc_key)
                item_amount = request.POST.get(amount_key)

                if item_desc and item_amount:
                    ExpenseItem.objects.create(
                        request=expense_request,
                        description=item_desc,
                        amount=item_amount
                    )
                else:
                    break  # No more items

                index += 1

            messages.success(request, "Expense Request created successfully!")
            # return redirect("expenses:list")  # Change to your correct list view

        except Exception as e:
            messages.error(request, f"Error saving expense: {e}")
            return redirect("expenses:create_expense")  # Return to the form page


   

    context= {
        "categories": ExpenseCategory.objects.all(),
        "department": Department.objects.all(),
        "users": CustomUser.objects.all(),
        "expenses":ExpenseRequest.objects.all(),
        "approver":CustomUser.objects.filter(role="dean"),
        "expenses": expenses
    }

    return render(request, "expenses.html", context)


@login_required
def expense_detail(request, expense_id):
    user = request.user 
    if user.role == "Staff": 
        expenses = ExpenseRequest.objects.filter(user=user) 
    elif user.role in ["Head", "Dean"]: 
        expenses = ExpenseRequest.objects.filter(department=user.department) 
    elif user.role == "Finance": 
        expenses = ExpenseRequest.objects.filter(status="Approved") 
    else: 
        expenses = ExpenseRequest.objects.none()


    expense_request = get_object_or_404(ExpenseRequest, id=expense_id)
    items = ExpenseItem.objects.filter(request=expense_request)

    context = {
        "expense_request": expense_request,
        "items": items,
    }
    return render(request, "requestdetails.html", context)




def add_item(request, expense_id):
    expense_request = get_object_or_404(ExpenseRequest, id=expense_id)

    # Only Dean or Head can add items
    if request.method == "POST" and request.user.role in ["Dean", "Head"]:
        description = request.POST.get("description")
        amount = request.POST.get("amount")

        if description and amount:
            ExpenseItem.objects.create(
                request=expense_request,
                description=description,
                amount=amount
            )
            expense_request.recalculate_total()

        # After adding, redirect back to the detail page
        return redirect("expenses:expense_detail", expense_id=expense_id)

    # If not POST or not authorized, just show the detail page
    return redirect("expenses:expense_detail", expense_id=expense_id)


def delete_item(request, item_id):
    item = get_object_or_404(ExpenseItem, id=item_id)
    expense_id = item.request.id
    expense_request = item.request

    if request.user.role in ["Dean", "Head"]:
        item.delete()
        expense_request.recalculate_total()

    return redirect("expenses:expense_detail", expense_id=expense_id)




@login_required
def cancel_expense_request(request, request_id):
    expense_request = get_object_or_404(ExpenseRequest, id=request_id)

    if expense_request.status != 'Pending':
        messages.error(request, 'This request has already been processed.')
        return redirect('expense_list')

  
    expense_request.cancel()

    # Save history of the cancellation action
    DepartmentExpenseRequestHistory.objects.create(
        expense_request=expense_request,
        department=expense_request.department,
        status='Cancelled',
        action_taken_by=request.user
    )

    messages.success(request, 'Expense request cancelled successfully!')
    return redirect('expense_list')



from django.utils import timezone
from .utils import notify


@login_required
def approve_expense_request(request, pk):
    expense = get_object_or_404(ExpenseRequest, id=pk)

    # Only Dean or Head can approve
    if request.user.role not in ["Dean", "Head"]:
        messages.error(request, "You are not authorized to approve this request.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.status != "Pending":
        messages.error(request, "This request has already been processed.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.user == request.user:
        messages.error(request, "You cannot approve your own expense request.")
        return redirect("expenses:expense_detail", expense_id=pk)

    # Update status
    expense.status = "Approved"
    expense.approved_by = request.user
    expense.approved_at = timezone.now()
    

    expense.recalculate_total()
    expense.save()

    # Log history
    DepartmentExpenseRequestHistory.objects.create(
        expense_request=expense,
        department=expense.department,
        status="Approved",
        action_taken_by=request.user
    )

    # Notification.objects.create(user=expense.user, message= f"Your expense request has been approved!")
    notify(expense.user, f"Your expense request '{expense.name}' has been approved.")

    messages.success(request, "Expense request approved.")
    return redirect("expenses:expense_detail", expense_id=pk)


@login_required
def reject_expense_request(request, pk):
    expense = get_object_or_404(ExpenseRequest, id=pk)

    if request.user.role not in ["Dean", "Head"]:
        messages.error(request, "You are not authorized to reject this request.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.status != "Pending":
        messages.error(request, "This request has already been processed.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.user == request.user:
        messages.error(request, "You cannot reject your own expense request.")
        return redirect("expenses:expense_detail", expense_id=pk)

    # Update status
    expense.status = "Rejected"
    expense.rejected_by = request.user
    expense.rejected_at = timezone.now()
    expense.save()

    DepartmentExpenseRequestHistory.objects.create(
        expense_request=expense,
        department=expense.department,
        status="Rejected",
        action_taken_by=request.user
    )

    # Notification.objects.create(user=expense.user, message= f"Your expense request has been rejected!")
    notify(expense.user, f"Your expense request '{expense.name}' has been rejected.")


    messages.success(request, "Expense request rejected.")
    return redirect("expenses:expense_detail", expense_id=pk)

@login_required
def disburse_expense(request, pk):
    expense = get_object_or_404(ExpenseRequest, id=pk)

    if expense.status != "Approved":
        messages.error(request, "Only approved expenses can be disbursed.")
        return redirect("create_expense")

    if request.method == "POST":
        method = request.POST.get("payment_method")
        ref = request.POST.get("reference_number")
        notes = request.POST.get("notes")

        # Create the disbursement record
        disbursement=ExpenseDisbursement.objects.create(
            expense_request=expense,
            disbursed_by=request.user,
            payment_method=method,
            reference_number=ref,
            notes=notes
        )

        notify(expense.user, f"Your expense request '{expense.name}' has been disbursed.")

        # Update expense status
        expense.status = "Disbursed"
        expense.save()

        files = request.FILES.getlist("receipts")
        for file in files:
            ExpenseReceipt.objects.create(disbursement=disbursement, file=file)

        # Update expense status
        expense.status = "Disbursed"
        expense.save()

        messages.success(request, "Expense successfully disbursed.")
        return redirect("expenses:create_expense")

    return render(request, "disburse_expense.html", {"expense": expense})


@login_required
def upload_receipt(request, pk):
    disbursement = get_object_or_404(ExpenseDisbursement, id=pk)

    if request.method == "POST" and request.user.role == "Finance" or request.user.role == "Staff":
        file = request.FILES.get("file")
        if file:
            ExpenseReceipt.objects.create(disbursement=disbursement, file=file)
            messages.success(request, "Receipt uploaded.")
    return redirect("expenses:expense_detail", expense_id=disbursement.expense_request.id)


from django.shortcuts import render
from .models import Notification

def note(request):
    notifications = Notification.objects.filter(user=request.user).order_by('-timestamp')
    return render(request, "notifications.html", {"notifications": notifications})


@login_required
def save_budget(request):
    if request.method == 'POST':
        # Retrieve form data name = request.POST.get('name')
        amount = request.POST.get('amount')
        start_date = request.POST.get('sdate')
        end_date = request.POST.get('edate')
        department=request.POST.get('department')
        id=request.POST.get('id')
        
       
       
        department=Department.objects.get(code=department)

        # Create the ExpenseRequest object

    
        if id:
            existing_budget =DepartmentBudget.objects.get(id=id)
            existing_budget.budget_amount=amount
            existing_budget.start_date=start_date
            existing_budget.end_date=end_date
            existing_budget.department=department
            existing_budget.save()

        else:
            budget = DepartmentBudget(
            
                budget_amount=amount,
                start_date=start_date,
                end_date=end_date,
                department=department,
            )
            
            # Save the expense request to the database
            budget.save()
            
            messages.success(request, 'Budget has been saved successfully and is awaiting approval.')
            # return redirect('expense_list')  # Redirect to the list of expense requests or another appropriate page

   
   
    context= {
       
        "department":Department.objects.all(),
        "budgets":DepartmentBudget.objects.all(),

    }
    
    return render(request, 'budget.html', context)

from django.db.models import Sum, F, Value
from django.db.models.functions import Coalesce
from django.utils import timezone

def department_budget_report(request):
    today = timezone.now().date()
    budgets = DepartmentBudget.objects.filter(
        start_date__lte=today,
        end_date__gte=today
    ).select_related('department')

    report = []
    for budget in budgets:
        spent = ExpenseRequest.objects.filter(
            department=budget.department,
            status='Approved',   # only approved requests count
            date__gte=budget.start_date,
            date__lte=budget.end_date
        ).aggregate(total=Coalesce(Sum('total_amount',output_field=DecimalField()), Value(0, output_field=DecimalField())))['total']

        remaining = budget.budget_amount - spent

        report.append({
            "department": budget.department.name,
            "budget": budget.budget_amount,
            "spent": spent,
            "remaining": remaining,
            "period": f"{budget.start_date} → {budget.end_date}"
        })

    return render(request, "budget_report.html", {"report":report})




def create_notification(user, message):
    Notification.objects.create(user=user, message=message)



from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver


from .models import *  # replace Expense with any model you want to track
from django.contrib.contenttypes.models import ContentType

@receiver(post_save, sender=ExpenseRequest)
def log_expense_save(sender, instance, created, **kwargs):
    action = "Created" if created else "Updated"
    AuditLog.objects.create(
        user=getattr(instance, "user", None),  # adjust if your model has a user field
        action=action,
        model_name=sender.__name__,
        record_id=instance.pk,
        details=f"Expense {action.lower()} with amount {instance.total_amount}"
    )

@receiver(post_delete, sender=ExpenseRequest)
def log_expense_delete(sender, instance, **kwargs):
    AuditLog.objects.create(
        user=getattr(instance, "user", None),
        action="Deleted",
        model_name=sender.__name__,
        record_id=instance.pk,
        details=f"Expense deleted with amount {instance.total_amount}"
    )

def expensee(request):
        if request.method == 'POST':
        # Retrieve form data name = request.POST.get('name')
            name = request.POST.get('name')
            category=request.POST.get('category')
            
       
       
            category=ExpenseCategory.objects.get(id=category)

        # Create the ExpenseRequest object
            expenses = ExpenseRequest(
            
                name=name,
                category=category,
               
            )
            
            # Save the expense request to the database
            expenses.save()
            
            messages.success(request, 'Expense has been saved successfully .')
            # return redirect('expense_list')  # Redirect to the list of expense requests or another appropriate page

   
   
        context= {
        
            "department":Department.objects.all(),
            "budgets":DepartmentBudget.objects.all(),

        }
        
        return render(request, 'expense.html', context)







def index(request):
    return render(request, "index.html")


import subprocess
import os
from datetime import datetime
from django.conf import settings

DB_NAME = settings.DATABASES['default']['NAME']
DB_USER = settings.DATABASES['default']['USER']
BACKUP_FOLDER = "backups"
# SOCKET_PATH = settings.DATABASES['default']['OPTIONS']['unix_socket']  # Use the custom socket path

os.makedirs(BACKUP_FOLDER, exist_ok=True)

def backup_database(request):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file = os.path.join(BACKUP_FOLDER, f"backup_{timestamp}.sql")

    try:
        # Adjusted to omit the password
        result = subprocess.run(
            [
                "mysqldump",
                "-u", DB_USER,  # No password argument here
                "--socket", SOCKET_PATH, 
                DB_NAME
            ],
            stdout=open(backup_file, "w"),
            stderr=subprocess.PIPE
        )

        if result.returncode == 0:
            return JsonResponse({"message": "Backup successful", "file": backup_file})
        else:
            error_message = result.stderr.decode("utf-8")
            return JsonResponse({"message": f"Backup failed: {error_message}"}, status=500)

    except Exception as e:
        return JsonResponse({"message": f"Error: {str(e)}"}, status=500)

    # command = f"mysqldump -u {DB_USER} -p{DB_PASSWORD} {DB_NAME} > {backup_file}"
    # result = os.system(command)

    # if result == 0:
    #     return JsonResponse({"message": "Backup successful", "file": backup_file})
    # else:
    #     return JsonResponse({"message": "Backup failed"}, status=500)



def restore_database(request):
    files = sorted(os.listdir(BACKUP_FOLDER), reverse=True)

    if not files:
        return JsonResponse({"message": "No backup found"}, status=404)

    latest_backup = os.path.join(BACKUP_FOLDER, files[0])

    command = f"mysql -u {DB_USER} -p{DB_PASSWORD} {DB_NAME} < {latest_backup}"
    result = os.system(command)

    if result == 0:
        return JsonResponse({"message": f"Restored from {files[0]}"})
    else:
        return JsonResponse({"message": "Restore failed"}, status=500)


from django.db.models import Sum
from django.shortcuts import render
from django.db.models import Q
from datetime import date

def expense_report_view(request):
    """
    Display expense requests in a table with filters: date range, department, category
    """
    # Get filter parameters from GET request
    start_date = request.GET.get("start_date")
    end_date = request.GET.get("end_date")
    department_id = request.GET.get("department")
    category_id = request.GET.get("category")

    expenses = ExpenseRequest.objects.select_related('department', 'category', 'user').all()

    # Apply date filters
    if start_date:
        expenses = expenses.filter(date__gte=start_date)
    if end_date:
        expenses = expenses.filter(date__lte=end_date)

    # Apply department filter
    if department_id and department_id != "all":
        expenses = expenses.filter(department_id=department_id)

    # Apply category filter
    if category_id and category_id != "all":
        expenses = expenses.filter(category_id=category_id)

    # Pass departments and categories for filter dropdowns
    departments = Department.objects.all()
    categories = ExpenseCategory.objects.all()

    context = {
        "expenses": expenses.order_by('-date'),
        "departments": departments,
        "categories": categories,
        "selected_department": department_id,
        "selected_category": category_id,
        "start_date": start_date,
        "end_date": end_date,
    }

    return render(request, "expense_report.html", context)


from django.shortcuts import render
from django.db.models import Sum, Count
from datetime import date

def reports_dashboard(request):
    # Filters
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    department_id = request.GET.get('department')
    category_id = request.GET.get('category')
    user_id = request.GET.get('user')

    today = date.today()
    if not start_date:
        start_date = date(today.year, 1, 1)
    else:
        start_date = date.fromisoformat(start_date)
    if not end_date:
        end_date = today
    else:
        end_date = date.fromisoformat(end_date)

    expenses = ExpenseRequest.objects.select_related('department', 'category', 'user').all()
    expenses = expenses.filter(date__gte=start_date, date__lte=end_date)

    if department_id and department_id != 'all':
        expenses = expenses.filter(department_id=department_id)
    if category_id and category_id != 'all':
        expenses = expenses.filter(category_id=category_id)
    if user_id and user_id != 'all':
        expenses = expenses.filter(user_id=user_id)

    # Department Summary
    dept_summary = expenses.values('department__name').annotate(
        total_expense=Sum('total_amount'),
        pending_requests=Count('id', filter=Q(status='Pending')),
        approved_requests=Count('id', filter=Q(status='Approved'))
    )

    # Category Summary
    category_summary = expenses.values('category__name').annotate(
        total_expense=Sum('total_amount')
    )

    # User Summary
    user_summary = expenses.values('user__fullname').annotate(
        total_expense=Sum('total_amount'),
        pending_requests=Count('id', filter=Q(status='Pending')),
        approved_requests=Count('id', filter=Q(status='Approved'))
    )

    # Departments, categories, users for dropdowns
    departments = Department.objects.all()
    categories = ExpenseCategory.objects.all()
    users = CustomUser.objects.all()

    context = {
        "expenses": expenses,
        "dept_summary": dept_summary,
        "category_summary": category_summary,
        "user_summary": user_summary,
        "departments": departments,
        "categories": categories,
        "users": users,
        "selected_department": department_id,
        "selected_category": category_id,
        "selected_user": user_id,
        "start_date": start_date,
        "end_date": end_date,
    }

    return render(request, "reports_dashboard.html", context)