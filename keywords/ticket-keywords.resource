*** Settings ***
Resource    ../pages/ticket_page.resource
Resource    common-keywords.resource

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