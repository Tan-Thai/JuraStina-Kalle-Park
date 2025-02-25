import os

# region OS
current_directory = os.getcwd().replace('\\', '/')
browser = "chrome"
url = f"file:///{current_directory}/resources/website/jurap.html"
# endregion

# region Landing page/ Homepage
landing_page_section = '//*[@id="home-section"]'
card_container = '//*[@id="home-section"]/div'
card_list = '//*[@class="card"]'
# endregion