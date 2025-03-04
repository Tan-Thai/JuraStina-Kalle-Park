*** Settings ***
Library    SeleniumLibrary
Variables    ../python-object-models/variables.py

*** Keywords ***
The user is not logged in, and is on the homepage
    # Confirms by checking if the logout button is present
    # https://forum.robotframework.org/t/differences-between-if-elseif-and-run-keyword-if/5746/4
    # Seems like "run keyword if" is old compared to "if/else". -TT
    [Tags]    Given
    ${is_logged_in}=    Run Keyword And Return Status    Element Should Be Visible   ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Click Element    ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Handle Alert
    Wait Until Page Contains Element    ${nav_menu_login}    timeout=10s

They attempt to register with valid credentials
    [Tags]    When
    Click Element    ${nav_menu_register}
    Input Text    ${USERNAME_FIELD}    ${valid_username}
    Input Text    ${PASSWORD_FIELD}    ${valid_password}
    Click Element    ${SUBMIT_REGISTER}

They should be redirected to the login page
    [Tags]    Then
    Wait Until Element Is Visible    ${login_section}    10s