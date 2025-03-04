*** Settings ***
Library    SeleniumLibrary
Variables    ../python-object-models/variables.py

*** Keywords ***
They add a '${ticket_type}' ticket to the cart
    [Tags]    When    Given
    Click Element    ${nav_menu_ticket}
    Wait Until Element Is Visible    ${ticket_category_dropdown}    10s

    # unsure if this works but this will make it all lowercase from my understanding
    # as shown in valid/invalid, you can skip setting variables and just use `.lower()` right away
    # instead of creating multiple steps. But i think its good to showcase both for learning purposes. -TT
    ${ticket_type_lower}    Set Variable    ${ticket_type.lower()}

    IF  "${ticket_type_lower}" == "regular"
        Select From List By Index    ${ticket_category_dropdown}    0
    ELSE IF  "${ticket_type_lower}" == "vip"
        Select From List By Index    ${ticket_category_dropdown}    1
    ELSE
        Fail    Invalid ticket type: ${ticket_type}
    END

    ${selected}=    Get Selected List Value    ${ticket_category_dropdown}
    ${selected_lower}    Set Variable   ${selected.lower()}
    Should Contain    ${selected_lower}    ${ticket_type_lower}
    Click Element    ${add_ticket_to_cart_button}

    ${message} =    Handle Alert
    Should Contain    ${message}    ${item_added_to_cart_message_text}

They should be able to see the ticket in the cart
    [Tags]    Then
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    10s
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    Ticket    #Currently hardcoded to test, not sure if its needed as variable.-TT
