*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/resources/python_objects/variables.py

*** Keywords ***
### section ###
Wait For Home Section
    Wait Until Element Is Visible    ${home_section}    10s

Wait For Login Section
    Wait Until Element Is Visible    ${login_section}    10s

Wait For Cart Section
    Wait Until Element Is Visible    ${cart_section}    10s

Wait For Safari Section
    Wait Until Element Is Visible    ${safari_section}    10s
   
Wait For Ticket Section
    Wait Until Element Is Visible    ${ticket_section}    10s

### nav-buttons ###
Wait For Logout Nav-Button
    Wait Until Element Is Visible    ${nav_menu_logout}    10s

Wait For Login Nav-Button
    Wait Until Element Is Visible    ${nav_menu_login}    10s

Navigate To Cart Page
    Click Element    ${nav_menu_cart}

Navigate To Tour Page
    Click Element    ${nav_menu_safari}

Navigate To Registration Page
    Click Element    ${nav_menu_register}

Navigate to Login Page
    Click Element    ${nav_menu_login}

Navigate To Ticket Page
    Click Element    ${nav_menu_ticket}