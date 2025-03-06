*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/registration_page.resource
Resource    common-keywords.resource

Variables    ../python-object-models/variables.py
*** Keywords ***
The user is not logged in, and is on the homepage
    [Tags]    Given
    Log Out If Logged In
    Wait For Login Nav-Button

They attempt to register with valid credentials
    [Tags]    When
    Navigate To Registration Page
    Enter Username in register field    ${valid_username}
    Enter Password in register field    ${valid_password}
    Click Submit Button

They should be redirected to the login page
    [Tags]    Then
    Wait For Login Section