*** Settings ***
Resource    ../pages/tour_page.resource
Resource    common-keywords.resource

*** Keywords ***
They add a tour booked for next ${chosen_day} by navigating the calendar dropdown using the keyboard to the cart
    [Tags]    When
    Navigate To Tour Page
    Wait For Safari Section
    Set Test Variable    ${selected_day}    ${chosen_day}
    ${amount_of_steps}    get_weekday_delta_offset    ${chosen_day}
    Open Calendar Dropdown
    Navigate ${amount_of_steps} steps to the right in the calendar
    Confirm Calendar Selection
    Add Tour To Cart
    Verify Tour Added To Cart Message

They should be able to see the tour in the cart
    [Tags]    Then
    Navigate To Cart Page
    Wait For Cart Section
    ${expected_date} =    get_upcoming_target_weekday_date    ${selected_day}
    Verify Cart Contains Tour    ${expected_date}

They add a VIP tour booked for next ${chosen_day} to the cart
    [Documentation]    Books a single VIP safari tour for the specified day
    Add VIP Tour    ${chosen_day}

They book ${ticket_count} VIP safari tours on the weekend
    [Documentation]    Books the input amount of VIP safari tours for the next Sunday
    Add Multiple VIP Tours    ${ticket_count}    Sunday