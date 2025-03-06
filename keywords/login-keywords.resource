*** Settings ***
Resource    ../pages/login_page.resource
Resource    common-keywords.resource
Resource    registration-keywords.resource

*** Keywords ***
### Login ###
The user has a registered account
    [Tags]    Given
    They Attempt To Register With Valid Credentials

They log in with '${credential_type}' credentials
    [Tags]    When
    Wait Until Element Is Visible    ${login_section}    10s

    IF  "${credential_type.lower()}" == "valid"
        Enter Username In Login Field    ${valid_username}
        Enter Password In Login Field    ${valid_password}
        Click Login Button
    ELSE IF  "${credential_type.lower()}" == "invalid"
        Enter Username In Login Field    ${INVALID_USERNAME}
        Enter Password In Login Field    ${INVALID_PASSWORD}
        Click Login Button
    ELSE
        Fail    Invalid credential type: ${credential_type}
    END

They should be logged in and be redirected to the homepage
    [Tags]    Then
    Wait For Home Section
    Wait For Logout Nav-Button

They should see an error message indicating login failure
    [Tags]    Then
    Wait For Login Error Message

### Logout ###
The User Is Logged In
    [Tags]    Given
    The User Has A Registered Account
    They log in with 'valid' credentials
    They should be logged in and be redirected to the homepage

They Log Out
    [Tags]    When
    Wait For Home Section
    Wait For Logout Nav-Button
    Click Element    ${nav_menu_logout}    #TODO: add a keyword that takes in a string for each nav button --TT
    Handle Alert

They should be redirected to the homepage and see the login button
    [Tags]    Then
    Wait For Home Section
    Wait For Login Nav-Button

Log Out User    #potentially redundant
    Click Element    ${nav_menu_logout}
    Handle Alert
    Wait For Login Nav-Button
