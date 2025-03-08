*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/python-object-models/variables.py

*** Keywords ***
Navigate To Ticket Page
    Click Element    ${nav_menu_ticket}

Wait For Ticket Category Dropdown
    Wait Until Element Is Visible    ${ticket_category_dropdown}    10s

Select Ticket Type
    [Arguments]    ${ticket_type}
    ${ticket_type_lower}    Set Variable    ${ticket_type.lower()}

    IF  "${ticket_type_lower}" == "regular"
        Select From List By Index    ${ticket_category_dropdown}    0
    ELSE IF  "${ticket_type_lower}" == "vip"
        Select From List By Index    ${ticket_category_dropdown}    1
    ELSE
        Fail    Invalid ticket type: ${ticket_type}
    END

Verify Selected Ticket Type
    [Arguments]    ${ticket_type}
    ${selected}=    Get Selected List Value    ${ticket_category_dropdown}
    ${selected_lower}    Set Variable   ${selected.lower()}
    Should Contain    ${selected_lower}    ${ticket_type.lower()}

Add Ticket To Cart
    Click Element    ${add_ticket_to_cart_button}

Verify Ticket Added To Cart Message
    ${message} =    Handle Alert
    Should Contain    ${message}    ${item_added_to_cart_message_text}

Verify Cart Contains Ticket
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    Ticket

Add VIP Adult Tickets
    [Arguments]    ${quantity}
    Click Element    ${nav_menu_ticket}
    Wait Until Element Is Visible    ${ticket_category_dropdown}    10s
    Select From List By Value    ${ticket_category_dropdown}    VIP
    Select From List By Index    ${ticket_type_dropdown}    0
    Input Text    ${ticket_quantity}    ${quantity}
    Click Element    ${add_ticket_to_cart_button}
    Handle Alert

Add VIP Child Tickets
    [Arguments]    ${quantity}
    Click Element    ${nav_menu_ticket}
    Wait Until Element Is Visible    ${ticket_category_dropdown}    10s
    Select From List By Value    ${ticket_category_dropdown}    VIP
    Select From List By Index    ${ticket_type_dropdown}    1
    Input Text    ${ticket_quantity}    ${quantity}
    Click Element    ${add_ticket_to_cart_button}
    Handle Alert