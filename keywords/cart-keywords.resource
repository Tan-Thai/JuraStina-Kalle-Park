*** Settings ***
Library    SeleniumLibrary
Library    ../python-object-models/weekday_helper.py
Variables    ../python-object-models/variables.py

*** Keywords ***
Proceed with the purchase at checkout
    [Tags]    When
    #Known Issue: Buying a ticket and then choosing a tour is not working. (blame Max) --TT
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    10s
    Click Button    ${checkout_button}

They should be able to see a checkout summary with their purchased items
    [Tags]    Then
    ${message} =    Handle Alert    #We handle + save the string attached in the alert here.
    Should Contain    ${message}    Checkout Summary:

The cart should be empty
    [Tags]    And
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    timeout=10s
    Element Should Contain    ${cart_details}    Your cart is empty