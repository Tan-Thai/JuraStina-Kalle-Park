import datetime
import os

# region OS related variables
current_directory = os.getcwd().replace('\\', '/')
browser = "chrome"
url = f"file:///{current_directory}/resources/website/jurap.html"
# endregion

# region Functions
def get_next_upcoming_weekday(target_weekday, date_format="YYYY-MM-DD"):
    #https://www.geeksforgeeks.org/python-program-to-get-the-nth-weekday-after-a-given-date/
    #0-6 for the days of the week, 0=monday -> 6=sunday
    current_date = datetime.date.today()
    days_delta = target_weekday - current_date.weekday()
    if days_delta <= 0:
        days_delta += 7

    date_of_next_weekday = current_date + datetime.timedelta(days_delta)

    # reasoning behind MM-DD-YY is due to the websites interpretation of input. it being en-us
    # reformating the date from YY-MM-DD --> to MM-DD-YY
    # https://docs.python.org/3.13/library/datetime.html#format-codes
    if date_format == "MM-DD-YYYY":
        return date_of_next_weekday.strftime("%m-%d-%Y")
    elif date_format == "YYYY-MM-DD":
        return date_of_next_weekday.strftime("%Y-%m-%d")
    else:
        raise ValueError("Invalid date_format. Use 'DD-MM-YYYY' or 'YYYY-MM-DD'.")
# endregion

# these sections should probably be renamed to 'page'
# random shit by Tan - will move when all tests are done. refactor my refactor yeyeyeyeye.
home_section = '//*[@id="home-section"]'

# region Credentials variables
username = "test123"
password = "test12345"

invalid_username = "123test"
invalid_password = "12345test"
# endregion

# region Register variables
username_field = "id:reg-username"
password_field = "id:reg-password"

submit_register = "css:#register-form button[type='submit']"
# endregion

# region Login variables
login_section = '//*[@id="login-section"]'

login_username_field = "id:login-username"
login_password_field = "id:login-password"

submit_login = "css:#login-form > button[type='submit']"
login_message = "id:login-message"
# endregion

# region Menu bar/navigation bar variables
nav_menu_register = "id:register-nav"
nav_menu_login = "id:login-nav"
nav_menu_logout = "id:logout-nav"
nav_menu_ticket = "id:tickets-nav"
nav_menu_safari = "id:safari-nav"
nav_menu_cart = "id:cart-nav"

# endregion

# region Ticket variables
add_ticket_to_cart_button = "css:#ticket-form > button[type='submit']"
# endregion

# region Safari variables
safari_section = '//*[@id="safari-section"]'

safari_type_dropdown = "id:safari-type"
safari_date_input_field = "xpath://input[@id='safari-date']"
next_monday_date = get_next_upcoming_weekday(0,"MM-DD-YYYY" ) # argument is 0-6

add_safari_to_cart_button = "css:#safari-form > button[type='submit']"
# endregion

# region Cart variables
cart_section = '//*[@id="cart-section"]'
cart_details = "id:cart-details"

item_added_to_cart_message_text = "Item added to cart!"

next_monday_date_TEST = "02-28-2025" ## I DON'T GET THIS ONE, WHY IS AMERICAN INPUT FUNCTIONING HERE??? -TT
expected_monday_date_in_cart = get_next_upcoming_weekday(0, "YYYY-MM-DD")
# endregion

# region Checkout variables
checkout_button = '//*[@id="checkout-button"]'
# endregion
