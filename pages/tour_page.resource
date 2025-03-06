*** Settings ***
Library    SeleniumLibrary
Library    ../python-object-models/weekday_helper.py

Variables    ../python-object-models/variables.py
*** Keywords ***
Open Calendar Dropdown
    Press Keys    ${safari_date_input_field}    SPACE

Navigate Calendar Steps
    [Arguments]    ${amount_of_steps}
    FOR    ${key_press}    IN RANGE    ${amount_of_steps}
        Press Keys    None    ARROW_RIGHT
    END

Confirm Calendar Selection
    Press Keys    None    ENTER

Add Tour To Cart
    Click Element    ${add_safari_to_cart_button}

Verify Tour Added To Cart Message
    Handle Alert

Verify Cart Contains Tour
    [Arguments]    ${expected_date}
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    ${expected_date}