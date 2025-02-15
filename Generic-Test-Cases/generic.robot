*** Settings ***
Library  SeleniumLibrary
Resource    generic-keywords.robot
Variables  variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
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

User tries to log in with wrong credentials
    [Tags]    Andreas
    [Documentation]    Assures that the user is unable to login with invalid credentials.
    Given The user has an account
    When They enter invalid login credentials
    And Click the login button
    Then They should not be able to login
    Sleep    3s

User logs out successfully
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to logout when they are currently logged in.
    Given The user has an account
    When The user is logged in
    Then They should be able to logout
    Sleep    3s

User purchases a ticket
    [Tags]    Daniel
    [Documentation]    Assures that the user is able to purchase a ticket when they are logged in.
    Given The user has an account
    And The user is logged in
    And The user is on the buy tickets page
    When Click the add to cart button
    Then The page says item added to cart
    Sleep    2s

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