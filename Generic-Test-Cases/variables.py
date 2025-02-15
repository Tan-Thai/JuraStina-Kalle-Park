import os

# region OS related variables
current_directory = os.getcwd().replace('\\', '/')
browser = "chrome"
url = f"file:///{current_directory}/resources/website/jurap.html"
# endregion

# these sections should probably be renamed to 'page'
# random shit by Tan - will move when all tests are done. refactor my refactor yeyeyeyeye.
login_section = '//*[@id="login-section"]'
home_section = '//*[@id="home-section"]'
cart_section = '//*[@id="cart-section"]'
safari_section = '//*[@id="safari-section"]'

checkout_button = '//*[@id="checkout-button"]'

# region Credentials related variables

username = "test123"
password = "test12345"
invalid_username = "123test"
invalid_password = "12345test"
ticket_added_to_cart_message_text = "Item added to cart!"

username_field = "id:reg-username"
password_field = "id:reg-password"
login_username_field = "id:login-username"
login_password_field = "id:login-password"

submit_register = "css:#register-form button[type='submit']"
submit_login = "css:#login-form > button[type='submit']"
submit_add_to_cart = "css:#ticket-form > button[type='submit']"
submit_safari_to_cart = "css:#safari-form > button[type='submit']"

login_message = "id:login-message"
# endregion

# region Menu-bar variables
register_button = "id:register-nav"
login_button = "id:login-nav"
logout_button = "id:logout-nav"
buy_tickets_button = "id:tickets-nav"
book_safaris_button = "id:safari-nav"
cart_button = "id:cart-nav"
safari_button = "id:safari-nav"

# endregion

# region Cart related variables
cart_details = "id:cart-details"
cart_item = "xpath://div[@id='cart-details']/*[1]"

# endregion

# region Safari related variables
tour_dropdown = "id:safari-type"
safari_date_input = "xpath://input[@id='safari-date']"
safari_date = "02-28-2025"