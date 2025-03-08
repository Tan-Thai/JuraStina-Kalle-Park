*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/python-object-models/variables.py

*** Keywords ***
Proceed To Checkout
    Click Button    ${checkout_button}

Verify Checkout Summary
    ${message} =    Handle Alert
    Should Contain    ${message}    Checkout Summary:

Verify Cart Is Empty
    Element Should Contain    ${cart_details}    Your cart is empty

Wait for checkout button
    Wait Until Element Is Visible    ${checkout_button}    10s

Click checkout button
    Click Element    ${checkout_button}