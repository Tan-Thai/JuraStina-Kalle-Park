*** Settings ***
Library    SeleniumLibrary
Resource    test-keyword.robot
Variables    variables.py
Test Setup    Setup Test Env
Test Teardown    Close Browser

*** Test Cases ***
User adds a ticket to the cart
    [Tags]    Daniel    Tan_Refactor
    [Documentation]    Assures that the user is able to purchase a ticket when they are logged in.
    Given The User Is Logged In
    #TODO: make the regular check more dynamic (similar to date check in tour.)
    When They add a 'REGULAR' ticket to the cart    # REGULAR/VIP for ticket type choices
    Then They should be able to see the ticket in the cart