*** Settings ***
Library    SeleniumLibrary
Library    ${EXECDIR}/resources/python_objects/weekday_helper.py
Library    Collections

Resource    ${EXECDIR}/resources/pages_object_model/cart_page.resource
Resource    ${EXECDIR}/resources/keywords/common-keywords.resource

Variables    ${EXECDIR}/resources/python_objects/variables.py
#Known Issue: Buying a ticket and then choosing a tour is not working. --TT
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

They check the price of the items listed in the cart
    [Tags]    
    Navigate To Cart Page
    Wait For Checkout Button
    Click Checkout Button
    ${total_price}    Handle Alert
    Append To List    ${prices}    ${total_price}