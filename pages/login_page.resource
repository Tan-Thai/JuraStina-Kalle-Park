*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/python-object-models/variables.py

*** Keywords ***
Enter Username in login field
    [Arguments]    ${username}
    Input Text    ${LOGIN_USERNAME_FIELD}    ${username}

Enter Password in login field
    [Arguments]    ${password}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${password}

Click Login Button
    Click Element    ${submit_login}

Wait For Login Error Message
    Wait Until Element Contains    ${login_message}    Invalid username or password.