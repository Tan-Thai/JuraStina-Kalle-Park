*** Settings ***
Library  SeleniumLibrary
Resource    generic-keywords.robot
Variables  variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser

*** Test Cases ***
# not sure about the syntax, but I think its common to write keywords as a normal sentence. -TT
# Intellisense in pycharm says otherwise tho, that it should be written as a title.
User registers a new account successfully
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to register an account.
    Given The user is not logged in, and is on the homepage
    When They attempt to register with valid credentials
    Then They should be redirected to the login page

User logs in successfully
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to login with a registered account.
    Given The user has a registered account
    When They log in with 'valid' credentials
    Then They should be logged in and be redirected to the homepage

User tries to log in with wrong credentials
    [Tags]    Andreas    Tan_refactor
    [Documentation]    Assures that the user is unable to login with invalid credentials.
    Given The user has a registered account
    When They Log In With 'invalid' Credentials
    Then They should see an error message indicating login failure

User logs out successfully
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to logout when they are currently logged in.
    Given The User Is Logged In
    When They Log Out
    Then They should be redirected to the homepage and see the login button

# Adding a tour/ticket to the cart both tests the carts functions so a dedicated test might not be needed
User adds a ticket to the cart
    # TODO: Check if this test needs to be reworked.
    # The previous iteration of this only added items to the cart, it never purchased it. Should we add that?
    [Tags]    Daniel    Tan_Refactor
    [Documentation]    Assures that the user is able to purchase a ticket when they are logged in.
    Given The User Is Logged In
    When They add a ticket to the cart
    Then They should be able to see the ticket in the cart

User adds a tour to the cart
    [Tags]    Andreas    Tan_refactor
    [Documentation]    Assures that the user is able to purchase a tour when they are logged in.
    Given The User Is Logged In
    And They Add A Ticket To The Cart
    #To make this dynamic we have to buy a VIP ticket.
    When They add a viable tour with a chosen date to the cart
    Then They should be able to see the tour in the cart

User completes a purchase
    [Tags]    Tan
    [Documentation]    Asserts that the user is capable of going through with a purchase at checkout.
    Given The User Is Logged In
    And They Add A Ticket To The Cart
    When Proceed with the purchase at checkout
    Then They should be able to see a checkout summary with their purchased items
    # Potential 'And' here for ensuring that the cart is now empty.
