# myapp/signals.py
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import *  # import the models you want to track

@receiver(post_save, sender=ExpenseRequest)
def log_expense_save(sender, instance, created, **kwargs):
    action = "Created" if created else "Updated"
    AuditLog.objects.create(
        user=getattr(instance, "user", None),
        action=action,
        model_name=sender.__name__,
        record_id=instance.pk,
        details=f"Expense {action.lower()} with amount {instance.amount}"
    )

@receiver(post_delete, sender=ExpenseRequest)
def log_expense_delete(sender, instance, **kwargs):
    AuditLog.objects.create(
        user=getattr(instance, "user", None),
        action="Deleted",
        model_name=sender.__name__,
        record_id=instance.pk,
        details=f"Expense deleted with amount {instance.amount}"
    )
