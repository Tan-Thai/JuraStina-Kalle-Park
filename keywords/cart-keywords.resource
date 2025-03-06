*** Settings ***
Library    SeleniumLibrary
Library    ../python-object-models/weekday_helper.py

Resource    ../pages/cart_page.resource
Resource    common-keywords.resource

Variables    ../python-object-models/variables.py
#Known Issue: Buying a ticket and then choosing a tour is not working. (blame Max) --TT
*** Keywords ***
Proceed with the purchase at checkout
    [Tags]    When
    Navigate To Cart Page
    Wait For Cart Section
    Proceed To Checkout

They should be able to see a checkout summary with their purchased items
    [Tags]    Then
    Verify Checkout Summary    #We handle + save the string attached in the alert here.

The cart should be empty
    [Tags]    And
    Navigate To Cart Page
    Wait For Cart Section
    Verify Cart Is Empty