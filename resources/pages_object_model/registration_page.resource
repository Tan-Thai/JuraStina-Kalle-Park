*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/resources/python_objects/variables.py

*** Keywords ***
Enter Username in register field
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Enter Password in register field
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Click Submit Button
    Click Element    ${SUBMIT_REGISTER}

Log Out If Logged In
    Element Should Be Visible    ${nav_menu_login}