*** Settings ***
Library  SeleniumLibrary
Resource    generic-keywords.robot
Variables  variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
User registers successfully
#Add proper tags + documentation
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to register an account.
    Given User is on the register page
    When They enter a valid username and password
    And Click the register button
    Then They should be redirected to the login page
    Sleep    3s

User logs in successfully
    [Tags]    Andreas    Tan_Refactor
    [Documentation]    Assures that the user is able to login with a registered account.
    Given The user has an account
    When They enter valid login credentials
    And Click the login button
    Then They should be able to login
    Sleep    3s

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

User puts item in cart
    [Tags]    Andreas
    [Documentation]    Assures that the user is able to put an item in the cart.
    Given The user has an account
    And The user is logged in
    And The user has an item in the cart
    When The user is on the cart page
    Then The user should be able to see the item in the cart
    Sleep    3s