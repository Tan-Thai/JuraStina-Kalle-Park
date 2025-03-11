*** Settings ***
Library   ${EXECDIR}/python_objects/weekday_helper.py
Resource    ${EXECDIR}/pages_object_model/tour_page.resource
Resource    common-keywords.resource

*** Keywords ***
They add a tour booked for next ${chosen_day} by navigating the calendar dropdown using the keyboard to the cart
    [Tags]    When
    Navigate To Tour Page
    Wait For Safari Section
    Select ${chosen_day} from dropdown calendar
    Add Tour To Cart
    Verify Tour Added To Cart Message

They should be able to see the tour in the cart
    [Tags]    Then
    Log To Console    navigate and verify tour in cart.
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

a date is selected
    [Tags]    To be removed
    Wait For Safari Section
    Open Calendar Dropdown
    Set Test Variable    ${selected_day}    friday    #Sets a "file wide" variable so it can be accessed later on.
    ${input_count}    get_weekday_delta_offset    friday
    Navigate ${input_count} steps to the right in the calendar
    Confirm Calendar Selection
    Add Tour To Cart

the user should get an alert
    Verify Tour Added To Cart Message