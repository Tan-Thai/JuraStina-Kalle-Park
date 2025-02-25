*** Settings ***
Library  SeleniumLibrary
Library    ../resources/global_files/weekday_helper.py
Variables  VG_Variables.py

Documentation    
...    Tags refer to when the keyword is used during a test-case. 
...    Low/High level refers to the complexity of the keyword, if it performs a simple check or calls for other keywords.
...    refers to when the keyword is called upon within this file
...    Sorry ahead of time with the messy structure. Most of the keywords follow the same order as the testcases.

*** Keywords ***
The user is on the landing page
    [Tags]    Given    Low-Level
    [Documentation]    Ensures that the user has landed on the homepage
     Title Should Be    Jura-Stina-Kalle Park

The User Views The Landing Page
    [Tags]    When    Internal    Low-Level
    [Documentation]    Ensures that the page is fully loaded in and confirms the section that constitutes as "homepage"
    Wait Until Element Is Visible    ${landing_page_section}    ${standard_timeout}

The user should see news articles displayed on the homepage
    [Tags]    Then    Internal    Low-Level
    [Documentation]    Ensures that the homepage actually contains the news we expect
    #https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Get%20WebElements
    # quick yolo
    Wait Until Element Is Visible    ${card_container}    ${standard_timeout}
    ${cards}=     Get Webelements    ${card_list}
    Should Not Be Empty    ${cards}    The container is empty, which indicates that no news are present

The user is on the homepage
    [Tags]    Given    Internal    High-Level
    [Documentation]    Confirms that the user is on the homepage with other test steps
    The User Is On The Landing Page
    The User Views The Landing Page
    
Can see the news
    [Tags]    Given    Internal    High-Level
    The User Should See News Articles Displayed On The Homepage

The user registers and logs in
    [Tags]    When    High-Level
    [Documentation]    Performs a registration and logs in on the new account from the homepage
    Navigate And Register With Valid Credentials
    Navigate To Login Page
    Login With Valid Credentials

The user should be able to see the homepage filled with news
    [Tags]    Then    High-Level
    [Documentation]
    The User Is On The Homepage
    Can See The News

The user is not logged in on any account
    [Tags]    Given    Low-Level
    [Documentation]    Ensures that the user is not logged in to any account by checking for a logout button
    ...                Logs out if there is an account logged in.
    ...    Personal Note: This most likely should not exist since everything should be "set" and "expected"
    ${is_logged_in}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${nav_menu_logout}    1s
    Run Keyword If    ${is_logged_in}    Click Element    ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Handle Alert
    Wait Until Page Contains Element    ${nav_menu_login}    ${standard_timeout}

The user enters the registration page and registers an account
    [Tags]    When    High-Level
    [Documentation]    Navigates and registers without ensuring that they have been redirected to the login-page
    Navigate And Register With Valid Credentials

The user should get a prompt that they have successfully created an account
    [Tags]    Then    Low-Level
    [Documentation]    Ensure that the user gets a visual prompt that the registration was successful
    Check Class In Message Section    ${register_message_box}    ${successful_message}

The user has an existing account and is on the homepage
    [Tags]    Given    High_Level
    [Documentation]    Creates an account and redirects to the main page to streamline starting position
    Navigate And Register With Valid Credentials
    Navigate to homepage

The user attempts to log in with '${login_type}' credentials
    [Tags]    When    High_Level
    [Documentation]    Performs a valid/invalid login based on the embedded argument.
    ...    The wait is to allow the verify message to pass.

    IF    "${login_type.lower()}" == "valid"
        Login With Valid Credentials
        Sleep    1.5s
    ELSE IF    "${login_type.lower()}" == "invalid"
        Login With Invalid Credentials
        Sleep    2s
    ELSE
        Fail    Invalid argument sent: ${login_type}. Should be either "invalid" or "valid".
    END

The user should get a success message and be redirected to the homepage
    [Tags]    Then    High-Level
    [Documentation]    Checks the message box during login and ensures that the logout button exists after it succeeds
    Check Class In Message Section    ${login_message}    ${successful_message}
    Wait Until Element Is Visible    ${nav_menu_logout}

The user should get an error message that tells them about invalid credentials
    [Tags]    Then    High-Level
    [Documentation]    Checks the message box during login to ensure that an error gets printed
    Check Class In Message Section    ${login_message}    ${failing_message}
    
The user attempts to register with the same name as the existing account
    [Tags]    When    High-Level
    [Documentation]    Performs identical functions as the registration, eg using the exact same username and password
    Navigate And Register With Valid Credentials
    
The user should get an error message that tells them that the username is taken
    [Tags]    Then    High-Level
    [Documentation]    Ensures that an error message gets printed with a message telling us that the username is taken
    Check Class In Message Section    ${register_message_box}    ${failing_message}
    Check Text In Message Section    ${register_message_box}    ${register_message_failed}
    
    
#### Strictly Internal Keywords ####
Navigate and register with valid credentials
    [Tags]    Internal    Low-Level
    [Documentation]    Combining both navigation and registration to demonstrate another keyword-structure
    Click Element    ${nav_menu_register}
    Wait Until Element Is Visible    ${register_section}    ${standard_timeout}
    Input Text    ${USERNAME_FIELD}    ${valid_username}
    Input Text    ${PASSWORD_FIELD}    ${valid_password}
    Click Element    ${SUBMIT_REGISTER}

Login with valid credentials
    [Tags]    Internal    Low-Level
    Wait Until Element Is Visible    ${login_section}    ${standard_timeout}
    Input Text    ${LOGIN_USERNAME_FIELD}    ${valid_username}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${valid_password}
    Click Element    ${submit_login}
    
Login with invalid credentials
    [Tags]    Internal    Low-Level
    Wait Until Element Is Visible    ${login_section}    ${standard_timeout}
    Input Text    ${LOGIN_USERNAME_FIELD}    ${invalid_username}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${invalid_password}
    Click Element    ${submit_login}
    
Navigate to login page
    [Tags]    Internal    Low-Level
    Click Element    ${nav_menu_login}
    Wait Until Element Is Visible    ${login_section}    ${standard_timeout}
    
Navigate to homepage
    [Tags]    Internal    Low-Level
    [Documentation]    Landing-page and homepage are currently interchangeable with each other
    Click Element    ${nav_menu_home}
    Wait Until Element Is Visible    ${landing_page_section}    ${standard_timeout}

# this check is a bit awkward due to the "verifying"-
# timing of the login and the fact that verifying is considered a "success message".
# Also the fact that login itself doesnt have a message after verifying, it just passes you to homepage right away
Check class in message section
    [Tags]    Internal    Low-Level
    [Documentation]    Keyword to check if the message section contains a class with matching name from arguments
    [Arguments]    ${message_locator}    ${expected_class_name}
    Wait Until Element Is Visible    ${message_locator}    ${standard_timeout}
    ${class_attribute}=     Get Element Attribute    ${message_locator}    class
    Should Contain    ${class_attribute}    ${expected_class_name}    The class attribute was NOT correct.
    
Check Text In Message Section
    [Tags]    Internal    Low-Level
    [Documentation]    Takes in a locator and string, checks if locator contains the string within itself
    [Arguments]    ${message_locator}    ${expected_string}
    Wait Until Element Is Visible    ${message_locator}    ${standard_timeout}
    ${actual_string}=    Get Text    ${message_locator}
    # lower here makes it case insensitive. But it might be better to be exact for tests like these?
    Should Contain    ${actual_string.lower()}    ${expected_string.lower()}
##############################
