from django.db import models

# Create your models here.
from django.db import models

from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models import Sum

# Department Model: Represents university departments
class Department(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    head_of_department = models.CharField(max_length=255, blank=True, null=True)  # Optional field for the department head's name
    code = models.CharField(max_length=10, unique=True)  # Unique code for each department (e.g., "CS", "ENG", etc.)
    
    def __str__(self):
        return self.name


# Custom User Model: Extending Django's User model to add department info
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
from django.db import models

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("The Email must be set")
        extra_fields.setdefault("username", email)
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("username", email)
        return self.create_user(email, password, **extra_fields)


class CustomUser(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(max_length=150, unique=True)
    fullname = models.CharField(max_length=50)
    department = models.ForeignKey('Department', on_delete=models.SET_NULL, null=True, blank=True)
    email = models.EmailField(unique=True)

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    role = models.CharField(max_length=255)
    objects = CustomUserManager()

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["fullname"]

    def __str__(self):
        return self.fullname



# Expense Category Model: Categories for classifying expenses (e.g., "Transport", "Food", etc.)
class ExpenseCategory(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name


# Expense Model: Represents an individual expense
# class expense(models.Model):
#     name = models.CharField(max_length=255)
#     category = models.ForeignKey('ExpenseCategory', on_delete=models.SET_NULL, null=True, blank=True)  # Expense category
   


# Payment Method Model: Represents methods of payment (e.g., "Cash", "Card", etc.)
class PaymentMethod(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name


# Recurring Expense Model: Used to manage recurring expenses
class RecurringExpense(models.Model):
    expense = models.ForeignKey('ExpenseRequest', on_delete=models.CASCADE)
    recurrence_interval = models.CharField(max_length=100)  # E.g., 'Monthly', 'Yearly'
    next_due_date = models.DateField()

    def __str__(self):
        return f"{self.expense.name} every {self.recurrence_interval}"


# Department Budget Model: Tracks budget allocations for departments
class DepartmentBudget(models.Model):
    department = models.ForeignKey('Department', on_delete=models.CASCADE)
    budget_amount = models.DecimalField(max_digits=10, decimal_places=2)
    start_date = models.DateField()
    end_date = models.DateField()

    def __str__(self):
        return f"Budget for {self.department.name} from {self.start_date} to {self.end_date}"
    

    def total_expenses(self):
        total = ExpenseRequest.objects.filter(
            department=self.department,
            date__gte=self.start_date,
            date__lte=self.end_date
        ).aggregate(Sum('total_amount'))['total_amount__sum']
        return total or 0

    # Remaining budget
    def remaining(self):
        return self.budget_amount - self.total_expenses()

    # Percentage of budget used
    def usage_percentage(self):
        if self.budget_amount == 0:
            return 0
        return round((self.total_expenses() / self.budget_amount) * 100, 2)


# Expense Report Model: Generates reports based on expenses
class ExpenseReport(models.Model):
    user = models.ForeignKey('CustomUser', on_delete=models.CASCADE)
    start_date = models.DateField()
    end_date = models.DateField()
    total_expense = models.DecimalField(max_digits=12, decimal_places=2)
    category_summary = models.JSONField()  # Store category-wise breakdown in a JSON format (e.g., { "transport": 200, "food": 150 })

    def __str__(self):
        return f"Report from {self.start_date} to {self.end_date}"

from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey

class AuditLog(models.Model):
    user = models.ForeignKey('CustomUser', on_delete=models.SET_NULL, null=True)
    action = models.CharField(max_length=255)
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    record = GenericForeignKey('content_type', 'object_id')
    timestamp = models.DateTimeField(auto_now_add=True)
    details = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.action} - {self.content_type} - {self.object_id} by {self.user} on {self.timestamp}"


# Notification Model: Used for sending notifications to users (e.g., for budget alerts, new expenses, etc.)
class Notification(models.Model):
    user = models.ForeignKey('CustomUser', on_delete=models.CASCADE)
    message = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    read = models.BooleanField(default=False)
   


    def mark_as_read(self):
        self.is_read = True
        self.save()


    def mark_as_unread(self):
        self.is_read = True
        self.save()

    def __str__(self):
        return f"Notification for {self.user.username} at {self.timestamp}"


 
class ExpenseRequest(models.Model):
    # Expense details
    department = models.ForeignKey(Department, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    date = models.DateField()
    description = models.TextField()
    category = models.ForeignKey('ExpenseCategory', on_delete=models.SET_NULL, null=True)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    

    # Approval Workflow
    status_choices = [
        ('Pending', 'Pending'),
        ('Approved', 'Approved'),
        ('Rejected', 'Rejected'),
        ('Disbursed', 'Disbursed'),  
        ('Cancelled', 'Cancelled'),
    ]
    status = models.CharField(max_length=10, choices=status_choices, default='Pending')

    # User who created the request (Department Head or staff)
    

    # Users who approve or reject the request (could be a finance manager, department head, etc.)
    approved_by = models.ForeignKey('CustomUser', on_delete=models.SET_NULL, null=True, blank=True, related_name='approved_requests')
    rejected_by = models.ForeignKey('CustomUser', on_delete=models.SET_NULL, null=True, blank=True, related_name='rejected_requests')

    # Date and timestamp for approval/rejection
    approved_at = models.DateTimeField(null=True, blank=True)
    rejected_at = models.DateTimeField(null=True, blank=True)


    def recalculate_total(self): 
        total = sum(item.amount for item in self.expenseitem_set.all()) 
        self.total_amount = total 
        self.save()
    

    
class ExpenseItem(models.Model):
    request= models.ForeignKey(ExpenseRequest, on_delete=models .CASCADE) 
    description = models.TextField()   
    amount = models.DecimalField(max_digits=10, decimal_places=2)

class ExpenseDisbursement(models.Model):
    expense_request = models.OneToOneField(ExpenseRequest, on_delete=models.CASCADE, related_name="disbursement")
    
    disbursed_by = models.ForeignKey('CustomUser', on_delete=models.SET_NULL, null=True, related_name='disbursed_expenses')
    disbursed_at = models.DateTimeField(auto_now_add=True)

    payment_method_choices = [
        ('Cash', 'Cash'),
        ('Bank Transfer', 'Bank Transfer'),
        ('Mobile Money', 'Mobile Money'),
        ('Cheque', 'Cheque'),
    ]
    payment_method = models.CharField(max_length=50, choices=payment_method_choices)

    reference_number = models.CharField(max_length=255, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Disbursement for {self.expense_request.name}"

class ExpenseReceipt(models.Model):
    disbursement = models.ForeignKey(ExpenseDisbursement, on_delete=models.CASCADE, related_name="receipts")
    file = models.FileField(upload_to="expense_receipts/")
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Receipt for {self.disbursement.expense_request.name}"



class DepartmentExpenseRequestHistory(models.Model):
    expense_request = models.ForeignKey('ExpenseRequest', on_delete=models.CASCADE)
    department = models.ForeignKey('Department', on_delete=models.CASCADE)
    status = models.CharField(max_length=10, choices=ExpenseRequest.status_choices)
    action_taken_by = models.ForeignKey('CustomUser', on_delete=models.SET_NULL, null=True)
    action_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.expense_request.name} - {self.status} by {self.action_taken_by.username}"



