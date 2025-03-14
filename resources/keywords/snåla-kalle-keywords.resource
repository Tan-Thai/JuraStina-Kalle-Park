*** Settings ***
Resource    ${EXECDIR}/resources/keywords/tour.keywords.resource
Resource    ${EXECDIR}/resources/keywords/ticket-keywords.resource
Resource    ${EXECDIR}/resources/keywords/login-keywords.resource
Resource    ${EXECDIR}/resources/keywords/cart-keywords.resource

Variables    ${EXECDIR}/resources/python_objects/snåla-kalle-variables.py

*** Keywords ***
## Scenario Specific ##
Snåla-Kalle has an existing account and is logged in to a new account "Ståla-Nalle"
    [Tags]    Given
    [Documentation]    Entrypoint. Setting test variables such as usernames for said test.
    Create an account with a previous purchase    ${snålakalle_old_username}
    User creates a new account and is logged in    ${snålakalle_new_username}

User checks the price on both accounts of a regular ticket and a herbivore tour
    [Tags]    When
    [Documentation]    Simulates a purchase on the 2 given accounts.
    User checks the price of a ticket and a tour    regular
    User changes account to ${snålakalle_old_username}
    User checks the price of a ticket and a tour    regular

The price of both purchases should match each other
    [Tags]    Then
    [Documentation]    Assures that two remembered values are the same
    Should Be Equal As Strings    ${prices}[0]    ${prices}[1]


## Dependencies for Snåla-Kalle ##
Create an account with a previous purchase
    [Tags]    Internal
    [Arguments]    ${USERNAME}
    [Documentation]    Simulates an account with a previous purchase.
    The user has a registered account with username ${USERNAME}
    Create a purchase on account    ${USERNAME}

User creates a new account and is logged in
    [Tags]    Internal    
    [Arguments]    ${USERNAME}
        Navigate To Registration Page
    Register with these credentials    ${USERNAME}    ${snålakalle_password}
    They should be redirected to the login page
    Attempt to login and confirm that it succeeded    ${USERNAME}

User checks the price of a ticket and a tour
    [Tags]    Internal
    [Arguments]    ${TICKET_TYPE}    
    They add a '${TICKET_TYPE}' ticket to the cart
    They add a tour booked for next wednesday with the calendar dropdown to the cart
    They check the price of the items listed in the cart

User changes account to ${USERNAME}
    [Tags]    Internal
    Log Out User
    Wait For Login Nav-Button
    Navigate To Login Page
    Wait For Login Section
    Login With These Credentials    ${USERNAME}    ${snålakalle_password}
    They should be logged in and be redirected to the homepage

Create a purchase on account
    [Tags]    Internal
    [Arguments]    ${USERNAME}
    [Documentation]    Will log in and go through a full purchase to simulate a "visit". Then logs out.
    Attempt to login and confirm that it succeeded    ${USERNAME}
    They add a 'REGULAR' ticket to the cart
    They add a tour booked for next wednesday with the calendar dropdown to the cart
    Proceed with the purchase at checkout
    Handle Alert
    The cart should be empty
    Log Out User

Attempt to login and confirm that it succeeded
    [Tags]    Internal
    [Arguments]    ${USERNAME}
    Log To Console    ${USERNAME}
    Login With These Credentials    ${USERNAME}    ${snålakalle_password}
    They should be logged in and be redirected to the homepage

The user has a registered account with username ${USERNAME}
    [Tags]    Internal
    Navigate To Registration Page
    Register with these credentials    ${USERNAME}    ${snålakalle_password}
    They should be redirected to the login page


