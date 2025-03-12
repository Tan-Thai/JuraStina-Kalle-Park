*** Settings ***
Resource    ${EXECDIR}/pages_object_model/ticket_page.resource
Resource    ${EXECDIR}/keywords/common-keywords.resource

*** Keywords ***
They add a '${ticket_type}' ticket to the cart
    [Tags]    When    Given
    Navigate To Ticket Page
    Wait For Ticket Category Dropdown
    Select Ticket Type    ${ticket_type}
    Verify Selected Ticket Type    ${ticket_type}
    Add Ticket To Cart
    Verify Ticket Added To Cart Message

They should be able to see the ticket in the cart
    [Tags]    Then
    Navigate To Cart Page
    Wait For Cart Section
    Verify Cart Contains Ticket

They are on the ticket page
    Navigate To Ticket Page
    Wait For Ticket Section

They add two 'VIP' adult tickets to the cart
    [Tags]    Andreas
    [Documentation]    Assures that the user is able to purchase two VIP adult tickets.
    Add VIP Adult Tickets    2
    
Two 'VIP' child tickets to the cart
    [Tags]    Andreas 
    [Documentation]    Assures that the user is able to purchase two VIP child tickets.
    Add VIP Child Tickets    2

They add a family package of VIP tickets to the cart
    [Tags]    Given
    [Documentation]    Assures that the user has added four VIP tickets to the cart.
    Add VIP Adult Tickets    2
    Add VIP Child Tickets    2
    They should be able to see the ticket in the cart
    Log To Console    Tickets purchased