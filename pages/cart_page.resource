*** Settings ***
Library    SeleniumLibrary
Variables    ../python-object-models/variables.py

*** Keywords ***
Proceed To Checkout
    Click Button    ${checkout_button}

Verify Checkout Summary
    ${message} =    Handle Alert
    Should Contain    ${message}    Checkout Summary:

Verify Cart Is Empty
    Element Should Contain    ${cart_details}    Your cart is empty