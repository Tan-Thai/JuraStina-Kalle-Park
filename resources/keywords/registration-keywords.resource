*** Settings ***
Library    SeleniumLibrary
Resource    ${EXECDIR}/resources/pages_object_model/registration_page.resource
Resource    ${EXECDIR}/resources/keywords/common-keywords.resource

Variables    ${EXECDIR}/resources/python_objects/variables.py
*** Keywords ***
The user is not logged in, and is on the homepage
    [Tags]    Given
    [Documentation]    Adjusted slightly due to to old redundant code.
    Wait For Login Nav-Button
    Wait For Home Section

They attempt to register with valid credentials
    [Tags]    When
    Navigate To Registration Page
    Enter Username in register field    ${valid_username}
    Enter Password in register field    ${valid_password}
    Click Submit Button

They should be redirected to the login page
    [Tags]    Then
    Wait For Login Section
    
Register with these credentials
    [Arguments]    ${username}    ${password}
    Enter Username in register field    ${username}
    Enter Password in register field    ${password}
    Click Submit Button