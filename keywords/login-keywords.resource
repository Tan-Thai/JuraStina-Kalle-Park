*** Settings ***
Library    SeleniumLibrary
Resource    registration-keywords.resource
Variables    ../python-object-models/variables.py

*** Keywords ***
### Login ###
The user has a registered account
    [Tags]    Given
    # send in as arguments
    They Attempt To Register With Valid Credentials

They log in with '${credential_type}' credentials
    [Tags]    When
    # Using embedded variables that allows the input to be changed from "valid" to "invalid"
    # https://forum.robotframework.org/t/differences-between-if-elseif-and-run-keyword-if/5746/4
    # Seems like "run keyword if" is old compared to "if/else". -TT
    # Can hardcode the functions of input here if we wanted, but I think this looks cleaner. -TT
    Wait Until Element Is Visible    ${login_section}    10s

    IF  "${credential_type.lower()}" == "valid"
        They Enter Valid Login Credentials
    ELSE IF  "${credential_type.lower()}" == "invalid"
        They Enter Invalid Login Credentials
    ELSE
        Fail    Invalid credential type: ${credential_type}
    END

They should be logged in and be redirected to the homepage
    [Tags]    Then
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${nav_menu_logout}    10s

They should see an error message indicating login failure
    [Tags]    Then
    Wait Until Element Contains    ${login_message}    Invalid username or password.

### Logout ###
The User Is Logged In
    [Tags]    Given
    The User Has A Registered Account
    They Log In With 'valid' Credentials
    They should be logged in and be redirected to the homepage

They Log Out
    [Tags]    When
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Page Contains Element    ${nav_menu_logout}    timeout=10s
    Click Element    ${nav_menu_logout}
    Handle Alert

They should be redirected to the homepage and see the login button
    [Tags]    Then
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${nav_menu_login}    10s

### Internal ###
They enter invalid login credentials
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${INVALID_USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Element    ${submit_login}

They enter valid login credentials
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${valid_username}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${valid_password}
    Click Element    ${submit_login}