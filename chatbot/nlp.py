import re
import calendar

def parse_user_input(user_input):
    user_input = user_input.lower().strip()

    # Greeting Intent
    if any(greet in user_input for greet in ["hi", "hey", "hello"]):
        return ("greetings", {})

    # Intent for getting total expenses today
    if "expenses" in user_input and "today" in user_input:
        return ("get_expenses_today", {})

    # Intent for getting expenses above a certain amount
    if "expenses" in user_input and "above" in user_input:
        match = re.search(r"above\s+(\d+)", user_input)
        if match:
            amount = float(match.group(1))
            return ("get_expenses_above", {"amount": amount})

    # Intent for getting budget summary for a specific month
    if "budget" in user_input:
        match = re.search(r"budget\s+(?:for\s+)?(\w+)", user_input, re.IGNORECASE)
        if match:
            month_name = match.group(1).capitalize()
            try:
                month_number = list(calendar.month_name).index(month_name)
            except ValueError:
                month_number = None

            return ("get_budget_summary", {"month_number": month_number, "month_name": month_name})

    # Intent for getting expense requests in a department
    if "expense request" in user_input or "my requests" in user_input or "requests":
        match = re.search(r"request\s+(?:for\s+)?(.+)", user_input, re.IGNORECASE)
        if match:
            department_name = match.group(1).strip()
            return ("get_expense_requests", {"department": department_name})
        else:
            return ("get_expense_requests", {"department": None})

    # Intent for getting total expenses for a department
    if "total expenses" in user_input and "department" in user_input:
        match = re.search(r"department\s+(\w+)", user_input)
        if match:
            return ("get_department_expenses", {"department": match.group(1).capitalize()})

    # Intent for getting status of expense requests
    if "expense request status" in user_input:
        match = re.search(r"status\s+(?:of\s+)?(\w+)", user_input)
        if match:
            return ("get_expense_request_status", {"status": match.group(1).capitalize()})

    # Fallback
    return ("unknown", {})
