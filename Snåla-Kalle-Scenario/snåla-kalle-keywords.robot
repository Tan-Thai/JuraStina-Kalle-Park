*** Settings ***
Library  SeleniumLibrary
Resource    ../Generic-Test-Cases/generic-keywords.robot
Variables    snåla-kalle-variables.py

*** Keywords ***

Snåla-Kalle has an account ${ACCOUNT_NAME} with a previous visit
    [Tags]    Given
    The user has a registered account with username ACCOUNT_NAME
    ACCOUNT_NAME has a previously purchased ticket and tour


Snåla-Kalle has created a new account ${ACCOUNT_NAME} and is logged in
    [Tags]    Given
    The user has a registered account with username ACCOUNT_NAME
    ACCOUNT_NAME is logged in
    

Snåla-Kalle looks at the cart price of a ${TICKET_TYPE} ticket and a Herbivore tour
    [Tags]    When
    They add a 'TICKET_TYPE' ticket to the cart
    They add a tour booked for next wednesday by navigating the calendar dropdown using the keyboard to the cart
    They check the price of the items listen in the cart  ## suite variable? Stopping for now -DK




# Snåla-Kalle changes account to 'Snåla-Kalle'



# The 'first price' and 'second price' should match


${ACCOUNT_NAME} has a previously purchased ticket and tour
    ACCOUNT_NAME is logged in
    They add a 'REGULAR' ticket to the cart
    They add a tour booked for next monday by navigating the calendar dropdown using the keyboard to the cart
    Proceed with the purchase at checkout
    Handle Alert
    They Log Out
    The user is not logged in, and is on the homepage


${ACCOUNT_NAME} is logged in
    They enter valid login credentials for ACCOUNT_NAME
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


They should be able to see a checkout summary with their purchased items
    [Tags]    Then
    ${message} =    Handle Alert    #We handle + save the string attached in the alert here.
    Should Contain    ${message}    Checkout Summary: