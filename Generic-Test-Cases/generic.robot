*** Settings ***
Library  SeleniumLibrary
Resource    generic-keywords.robot
Variables  variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
# not sure about the syntax, but I think its common to write keywords as a normal sentence. -TT
User registers a new account successfully-refactor
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to register an account.
    Given The user is not logged in, and is on the homepage
    When They attempt to register with valid credentials
    Then They should be redirected to the login page

User logs in successfully-refactor
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to login with a registered account.
    Given The user has a registered account
    When They log in with 'valid' credentials
    Then They should be logged in and be redirected to the homepage

User tries to log in with wrong credentials-refactor
    [Tags]    Andreas    Tan_refactor
    [Documentation]    Assures that the user is unable to login with invalid credentials.
    Given The user has a registered account
    When They Log In With 'invalid' Credentials
    Then They should see an error message indicating login failure

User logs out successfully-refactor
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to logout when they are currently logged in.
    Given The User Is Logged In refactor
    When They Log Out
    Then They should be redirected to the homepage and see the login button

User purchases a ticket-refactor (This should in theory be "add ticket to the cart")
    # TODO: Check if this test needs to be reworked.
    # The previous iteration of this only added items to the cart, it never purchased it. Should we add that?
    [Tags]    Daniel    Tan_Refactor
    [Documentation]    Assures that the user is able to purchase a ticket when they are logged in.
    Given The User Is Logged In Refactor
    When They add a ticket to the cart
    Then They should be able to see a confirmation message that the ticket was added

User completes a purchase
    [Tags]    Tan
    [Documentation]    Asserts that the user is capable of going through with a purchase at checkout.
    Given The User Is Logged In Refactor
    When They Add A Ticket To The Cart refactor
    And Proceed with the purchase at checkout
    Then They should be able to see a checkout summary with their purchased items


User purchases a tour-refactor
    [Tags]    Andreas    Tan_refactor
    [Documentation]    Assures that the user is able to purchase a tour when they are logged in.
    Given The User Is Logged In Refactor
    And The user has bought a ticket - refactor
    #To make this dynamic we have to buy a VIP ticket.
    When They select a tour and a date
    And They add the selected tour to the cart
    Then The page says item added to cart
    

# Refactored this but keeping these 2 since they might be needed when i continue the refactor.
# TODO: Make dynamic date selection & fix cart variables
User purchases a tour
    [Tags]    Andreas
    [Documentation]    Assures that the user is able to purchase a tour when they are logged in.
    Given The user has an account
    And The user has bought a ticket
    And The user is on the buy safari page
    When The user selects a specific tour and a date
    Sleep    2s
    And Add the tour ticket to cart
    Then The page says item added to cart

User puts item in cart
    [Tags]    Andreas
    [Documentation]    Assures that the user is able to put an item in the cart.
    Given The user has an account
    And The user is logged in
    And The user has an item in the cart
    When The user is on the cart page
    Then The user should be able to see the item in the cart
    Sleep    3s