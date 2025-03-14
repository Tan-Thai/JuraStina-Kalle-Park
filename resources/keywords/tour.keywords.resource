*** Settings ***
Library   ${EXECDIR}/resources/python_objects/weekday_helper.py
Resource    ${EXECDIR}/resources/pages_object_model/tour_page.resource
Resource    ${EXECDIR}/resources/keywords/common-keywords.resource

*** Keywords ***
They add a tour booked for next ${chosen_day} with the calendar dropdown to the cart
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

