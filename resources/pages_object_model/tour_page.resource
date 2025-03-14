*** Settings ***
Library    SeleniumLibrary
Library    ${EXECDIR}/resources/python_objects/weekday_helper.py

Resource    ${EXECDIR}/resources/keywords/common-keywords.resource

Variables    ${EXECDIR}/resources/python_objects/variables.py
*** Keywords ***
Open Calendar Dropdown
    Set Focus To Element    ${safari_date_input_field}
    Press Keys    none    SPACE

Confirm Calendar Selection
    Press Keys    None    ENTER

Add Tour To Cart
    Click Element    ${add_safari_to_cart_button}

Verify Tour Added To Cart Message
    Alert Should Be Present    ${EMPTY}    action=accept
    Log To Console    handling alert succeeded
    Sleep    0.1s

Verify Cart Contains Tour
    [Arguments]    ${expected_date}
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    ${expected_date}

Select ${chosen_day} from dropdown calendar
    [Tags]    Daniel    Tan_refactor
    Set Test Variable    ${selected_day}    ${chosen_day}    #Sets a "file wide" variable so it can be accessed later on.
    ${input_count}    get_weekday_delta_offset    ${chosen_day}
    Open Calendar Dropdown
    Navigate ${input_count} steps to the right in the calendar
    Confirm Calendar Selection

Navigate ${amount_of_steps} steps to the right in the calendar
    [Tags]    Daniel    Tan_refactor
    [Documentation]    Input solution for the dynamic calendar ui in javascript.
    FOR    ${key_press}    IN RANGE    ${amount_of_steps}
        Press Keys    None    ARROW_RIGHT
        #Sleep    0.1s    #Use this if you want to see the actual movement during calendar selection. -TT
    END

Add VIP Tour
    [Arguments]    ${chosen_day}
    Select ${chosen_day} from dropdown calendar
    Select From List By Index    ${safari_type_dropdown}    1
    Add Tour To Cart
    Verify Tour Added To Cart Message

Add Multiple VIP Tours
    [Arguments]    ${count}    ${chosen_day}
    Navigate To Tour Page
    Wait For Safari Section
    FOR    ${index}    IN RANGE    ${count}
        Add VIP Tour    ${chosen_day}
        Log To Console    loop:${index}
    END
