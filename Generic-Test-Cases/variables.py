import os

current_directory = os.getcwd().replace('\\', '/')
browser = "chrome"
url = f"file:///{current_directory}/resources/website/jurap.html"
register_button = "id:register-nav"
username_field = "id:reg-username"
password_field = "id:reg-password"
username = "test123"
password = "test12345"
submit_register = "css:#register-form button[type='submit']"
login_button = "css:#login-form > button[type='submit']"