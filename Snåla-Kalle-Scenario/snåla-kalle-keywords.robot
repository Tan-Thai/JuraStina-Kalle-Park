*** Settings ***
Library  SeleniumLibrary
Library    Collections
Resource    ../Generic-Test-Cases/generic-keywords.robot
Variables    snåla-kalle-variables.py


*** Keywords ***


## Scenario Specific ##

Snåla-Kalle has an account ${ACCOUNT_NAME} with a previous visit
    [Tags]    Given
    The user has a registered account with username ${ACCOUNT_NAME}
    ${ACCOUNT_NAME} has a previously purchased ticket and tour


User has created a new account ${USERNAME} and is logged in
    [Tags]    Given
    The user has a registered account with username ${USERNAME}
    ${USERNAME} is logged in

    

User checks the price of a ${TICKET_TYPE} ticket and a tour
    [Tags]    When
    They add a 'regular' ticket to the cart
    They add a tour booked for next wednesday by navigating the calendar dropdown using the keyboard to the cart
    They check the price of the items listed in the cart

User changes account to ${USERNAME}
    [Tags]    When
    The user is not logged in, and is on the homepage
    ${USERNAME} logs in
    They should be logged in and be redirected to the homepage



The price of both purchases should match each other
    [Tags]    Then
    [Documentation]    Assures that two remembered values are the same    ### Currently comparing whole checkout strings, not cost -DK
    Should Be Equal As Strings    ${prices}[0]    ${prices}[1]
    
## Dependencies for Snåla-Kalle ##


${ACCOUNT_NAME} has a previously purchased ticket and tour
    ${ACCOUNT_NAME} is logged in
    They add a 'REGULAR' ticket to the cart
    They add a tour booked for next monday by navigating the calendar dropdown using the keyboard to the cart
    Proceed with the purchase at checkout
    Handle Alert
    The cart should be empty
    The user is not logged in, and is on the homepage


${USERNAME} logs in
    
    Wait Until Element Is Visible    ${nav_menu_login}    10s
    Click Element    ${nav_menu_login}
    Wait Until Element Is Visible    ${login_username_field}    10s
    Input Text    ${LOGIN_USERNAME_FIELD}    ${USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${snålakalle_password}
    Click Element    ${submit_login}


${ACCOUNT_NAME} is logged in
    They enter valid login credentials for ${ACCOUNT_NAME}
    They should be logged in and be redirected to the homepage
    
## Borrowed & refactored ##

The user has a registered account with username ${USERNAME}
    [Tags]    Given
    They attempt to register with username ${USERNAME}
    They should be redirected to the login page


They attempt to register with username ${USERNAME}
    [Tags]    When
    Click Element    ${nav_menu_register}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${snålakalle_password}
    Click Element    ${SUBMIT_REGISTER}


They enter valid login credentials for ${USERNAME}
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${snålakalle_password}
    Click Element    ${submit_login}


They check the price of the items listed in the cart
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${checkout_button}    10s
    Click Element    ${checkout_button}
    ${total_price}    Handle Alert
    Append To List    ${prices}    ${total_price}

    


Snåla-Kalle Log Out
    [Tags]    When
    Wait Until Page Contains Element    ${nav_menu_logout}    timeout=10s
    Click Element    ${nav_menu_logout}
    Handle Alert