*** Settings ***
Library    SeleniumLibrary
Variables    ../python-object-models/variables.py   

*** Keywords ***
Enter Username in register field
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Enter Password in register field
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Click Submit Button
    Click Element    ${SUBMIT_REGISTER}

Log Out If Logged In    ## this is most likely redundant for us since we should never in theory accidentally be logged in. --TT
    ${is_logged_in}=    Run Keyword And Return Status    Element Should Be Visible   ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Click Element    ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Handle Alert