import os

# region OS
current_directory = os.getcwd().replace('\\', '/')
browser = "chrome"
url = f"file:///{current_directory}/resources/website/jurap.html"
# endregion

# region Generic
standard_timeout = "10s"
successful_message = "message success"
failing_message = "message error"
# endregion

# region Menu bar/navigation bar variables
nav_menu_register = "id:register-nav"
nav_menu_login = "id:login-nav"
nav_menu_logout = "id:logout-nav"
nav_menu_home = "//a[text()='Home']"
# endregion

# region Landing page/ Homepage
landing_page_section = '//*[@id="home-section"]'
card_container = '//*[@id="home-section"]/div'
card_list = '//*[@class="card"]'
# endregion

# region Credentials variables
valid_username = "test123"
valid_password = "test12345"

invalid_username = "123test"
invalid_password = "12345test"
# endregion

# region Register variables
register_section = '//*[@id="register-section"]'

username_field = "id:reg-username"
password_field = "id:reg-password"

register_message_box = '//*[@id="register-message"]'
submit_register = "css:#register-form button[type='submit']"
# endregion

# region Login variables
login_section = '//*[@id="login-section"]'

login_username_field = "id:login-username"
login_password_field = "id:login-password"

submit_login = "css:#login-form > button[type='submit']"
login_message = "id:login-message"
# endregion