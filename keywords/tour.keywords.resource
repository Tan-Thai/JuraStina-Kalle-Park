*** Settings ***
Resource    ../pages/tour_page.resource
Resource    common-keywords.resource

*** Keywords ***
They add a tour booked for next ${chosen_day} by navigating the calendar dropdown using the keyboard to the cart
    [Tags]    When
    Navigate To Tour Page
    Wait For Safari Section
    Set Test Variable    ${selected_day}    ${chosen_day}
    ${input_count}    get_weekday_delta_offset    ${chosen_day}
    Open Calendar Dropdown
    Navigate Calendar Steps    ${input_count}
    Confirm Calendar Selection
    Add Tour To Cart
    Verify Tour Added To Cart Message

They should be able to see the tour in the cart
    [Tags]    Then
    Navigate To Cart Page
    Wait For Cart Section
    ${expected_date} =    get_upcoming_target_weekday_date    ${selected_day}
    Verify Cart Contains Tour    ${expected_date}