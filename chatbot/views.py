from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .nlp import parse_user_input
from expenses.models import *
from datetime import date
from django.db.models import Sum
from django.shortcuts import render
# from twilio.twiml.messaging_response import MessagingResponse  # For WhatsApp bot

@csrf_exempt
def chatbot_response(request):
    if request.method == "POST":
        data = json.loads(request.body)
        user_input = data.get("message", "")

        intent, entities = parse_user_input(user_input)

        # Handle intents
        if intent == "greetings":
            response = "Hello, I am your assistant. How are you? How can I help you today?"

        elif intent == "get_expenses_today":
            today = date.today()
            total_expenses = ExpenseRequest.objects.filter(date=today).aggregate(Sum('total_amount'))['total_amount__sum'] or 0
            response = f"Today's total expenses are ${total_expenses:.2f}."

        elif intent == "get_expenses_above":
            amount = entities.get("amount")
            expenses_qs = ExpenseRequest.objects.filter(total_amount__gt=amount)

            if request.user.role in ['Head', 'Staff']:
                expenses_qs = expenses_qs.filter(department=request.user.department)

            expenses_qs = expenses_qs.order_by('-date')
            if expenses_qs.exists():
                expense_lines = [
                    f"{e.category.name if e.category else 'Uncategorized'}: ${e.total_amount} on {e.date.strftime('%Y-%m-%d')} (Department: {e.department.name})"
                    for e in expenses_qs
                ]
                response = f"Expenses above ${amount}:\n" + "\n".join(expense_lines)
            else:
                response = f"No expenses found above ${amount}."

        elif intent == "get_budget_summary":
            month_number = entities.get("month_number")
            month_name = entities.get("month_name")
            budget_qs = DepartmentBudget.objects.all()

            if month_number:
                budget_qs = budget_qs.filter(start_date__month=month_number)

            if request.user.role in ['Head', 'Staff']:
                budget_qs = budget_qs.filter(department=request.user.department)

            budget_obj = budget_qs.first()
            if budget_obj:
                used = budget_obj.total_expenses()
                remaining = budget_obj.remaining()
                percent = budget_obj.usage_percentage()
                response = (f"Budget for {budget_obj.department.name} in {month_name} is ${budget_obj.budget_amount:.2f}.\n"
                            f"Used: ${used:.2f}, Remaining: ${remaining:.2f}, Usage: {percent}%.")
            else:
                response = f"No budget found for {month_name}."

        elif intent == "get_expense_requests":
            department_name = entities.get("department")
            if department_name:
                department = Department.objects.filter(name__icontains=department_name).first()
                if not department:
                    response = f"Department '{department_name}' not found."
                else:
                    requests_qs = ExpenseRequest.objects.filter(department=department).order_by('-date')
                    if requests_qs.exists():
                        request_details = [
                            f"{req.name}: ${req.total_amount} on {req.date.strftime('%Y-%m-%d')} - Status: {req.status}"
                            for req in requests_qs
                        ]
                        response = f"Expense requests for {department.name}:\n" + "\n".join(request_details)
                    else:
                        response = f"No expense requests found for {department.name}."
            else:
                if not request.user.department:
                    response = "You don’t have a department assigned, so I can’t fetch requests."
                else:
                    department = request.user.department
                    requests_qs = ExpenseRequest.objects.filter(department=department).order_by('-date')
                    if requests_qs.exists():
                        request_details = [
                            f"{req.name}: ${req.total_amount} on {req.date.strftime('%Y-%m-%d')} - Status: {req.status}"
                            for req in requests_qs
                        ]
                        response = f"Expense requests for {department.name}:\n" + "\n".join(request_details)
                    else:
                        response = f"No expense requests found for {department.name}."


        else:
            response = "Sorry, I didn’t understand that. Try asking about today's expenses, expenses above a certain amount, budget for a month, or expense requests for a department."

        return JsonResponse({"response": response})

    return JsonResponse({"response": "Invalid request method."}, status=405)


def chat_page(request):
    return render(request, "chatbot/chat.html")


@csrf_exempt
def whatsapp_bot(request):
    if request.method == "POST":
        user_input = request.POST.get("Body", "")
        sender = request.POST.get("From", "")

        intent, entities = parse_user_input(user_input)
        # Simple handler for WhatsApp bot
        if intent == "greetings":
            response_text = "Hello! How can I assist you with expenses today?"
        else:
            response_text = f"You asked: {user_input}. (Intent: {intent})"

        # twilio_resp = MessagingResponse()
        twilio_resp.message(response_text)
        return HttpResponse(str(twilio_resp))

    return HttpResponse("Invalid request", status=405)
