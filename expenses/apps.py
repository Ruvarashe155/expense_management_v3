from django.apps import AppConfig
from django.db.models.signals import post_migrate


# myapp/apps.py
from django.apps import AppConfig

class MyAppConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'expenses'

    def ready(self):
        import expenses.signals

class ExpensesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'expenses'

    def ready(self):
        # Import inside ready() to avoid "Apps aren't loaded yet"
        from django.contrib.auth.models import Group, Permission
        from django.contrib.contenttypes.models import ContentType
        from .models import ExpenseRequest, ExpenseDisbursement, DepartmentExpenseRequestHistory

        def create_default_groups(sender, **kwargs):
            roles = ["Staff", "DepartmentHead", "FinanceOffice", "AuditOffice"]
            for role in roles:
                group, created = Group.objects.get_or_create(name=role)
                if created:
                    print(f"Created group: {role}")

            # Attach permissions safely using ContentType
            expense_ct = ContentType.objects.get_for_model(ExpenseRequest)
            disbursement_ct = ContentType.objects.get_for_model(ExpenseDisbursement)
            history_ct = ContentType.objects.get_for_model(DepartmentExpenseRequestHistory)

            # Staff: can add ExpenseRequest
            staff_group = Group.objects.get(name="Staff")
            staff_group.permissions.add(
                Permission.objects.get(codename="add_expenserequest", content_type=expense_ct)
            )

            # DepartmentHead: can change ExpenseRequest
            dept_head_group = Group.objects.get(name="DepartmentHead")
            dept_head_group.permissions.add(
                Permission.objects.get(codename="change_expenserequest", content_type=expense_ct)
            )

            # FinanceOffice: can add ExpenseDisbursement
            finance_group = Group.objects.get(name="FinanceOffice")
            finance_group.permissions.add(
                Permission.objects.get(codename="add_expensedisbursement", content_type=disbursement_ct)
            )

            # AuditOffice: can view DepartmentExpenseRequestHistory
            audit_group = Group.objects.get(name="AuditOffice")
            audit_group.permissions.add(
                Permission.objects.get(codename="view_departmentexpenserequesthistory", content_type=history_ct)
            )

        post_migrate.connect(create_default_groups, sender=self)


