*** Settings ***
Library  SeleniumLibrary
Library    Collections

Resource    tour.keywords.resource
Resource    ticket-keywords.resource
Resource    login-keywords.resource
Resource    cart-keywords.resource

Variables    ../python-object-models/snåla-kalle-variables.py

*** Keywords ***
## Scenario Specific ##

'${EXISTING_ACCOUNT}' has an existing account and a new account '${NEW_ACCOUNT}' is created and logged in
    [Tags]    Given
    [Documentation]    Entrypoint. Setting test variables such as usernames for said test.
    Set Test Variable    ${EXISTING_ACCOUNT}   ${EXISTING_ACCOUNT}
    Set Test Variable    ${NEW_ACCOUNT}    ${NEW_ACCOUNT}
    
    Create an account with a previous purchase    ${EXISTING_ACCOUNT}
    User creates a new account and is logged in    ${NEW_ACCOUNT}

User checks the price on both accounts of a '${TICKET_TYPE}' ticket and a tour
    [Tags]    When
    [Documentation]    Simulates identical purchases between 2 accounts.
    User checks the price of a ticket and a tour    ${TICKET_TYPE}
    User changes account to ${EXISTING_ACCOUNT}
    User checks the price of a ticket and a tour    ${TICKET_TYPE}

The price of both purchases should match each other
    [Tags]    Then
    [Documentation]    Assures that two remembered values are the same    ### Currently comparing whole checkout strings, not cost -DK
    Should Be Equal As Strings    ${prices}[0]    ${prices}[1]
    
## Dependencies for Snåla-Kalle ##
Create an account with a previous purchase
    [Tags]    Internal
    [Arguments]    ${USERNAME}
    [Documentation]    Creates a new account and simulates a purchase.
    # Not sure if we should have an argument for password from all this way out. -TT
    The user has a registered account with username ${USERNAME}
    Simulate a previous purchase on account    ${USERNAME}

User creates a new account and is logged in
    [Tags]    Internal    
    [Arguments]    ${USERNAME}
    The user has a registered account with username ${USERNAME}
    Attempt to login and confirm that it succeeded    ${USERNAME}

User checks the price of a ticket and a tour
    [Tags]    Internal
    [Arguments]    ${TICKET_TYPE}    #Tour type can be added here as well -TT
    They add a '${TICKET_TYPE}' ticket to the cart
    They add a tour booked for next wednesday by navigating the calendar dropdown using the keyboard to the cart
    They check the price of the items listed in the cart

User changes account to ${USERNAME}
    [Tags]    Internal
    Log Out User
    Wait For Login Nav-Button
    Navigate To Login Page
    Wait For Login Section
    Login With These Credentials    ${USERNAME}    ${snålakalle_password}
    They should be logged in and be redirected to the homepage

Simulate a previous purchase on account
    [Tags]    Internal
    [Arguments]    ${USERNAME}
    [Documentation]    Will log in and go through a full purchase to simulate a "visit". Then logs out.
    Attempt to login and confirm that it succeeded    ${USERNAME}
    They add a 'REGULAR' ticket to the cart
    They add a tour booked for next monday by navigating the calendar dropdown using the keyboard to the cart
    Proceed with the purchase at checkout
    Handle Alert
    The cart should be empty
    Log Out User    ## "The user is not logged in, and is on the homepage" previously

Attempt to login and confirm that it succeeded
    [Tags]    Internal
    [Arguments]    ${USERNAME}
    Log To Console    ${USERNAME}
    Login With These Credentials    ${USERNAME}    ${snålakalle_password}
    They should be logged in and be redirected to the homepage

## Borrowed & refactored ##

# not sure if we should have this an an argument/rework it entirely -TT
The user has a registered account with username ${USERNAME}
    [Tags]    Internal
    Navigate To Registration Page
    Register with these credentials    ${USERNAME}    ${snålakalle_password}
    They should be redirected to the login page

They check the price of the items listed in the cart
    Navigate To Cart Page
    Wait For Checkout Button
    Click Checkout Button
    ${total_price}    Handle Alert
    Append To List    ${prices}    ${total_price}
