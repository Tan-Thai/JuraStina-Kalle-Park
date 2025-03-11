*** Settings ***
Library    SeleniumLibrary
Library    ${EXECDIR}/python_objects/weekday_helper.py

Variables    ${EXECDIR}/python_objects/variables.py
*** Keywords ***
Open Calendar Dropdown
    Press Keys    ${safari_date_input_field}    SPACE

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

Select ${chosen_day} from dropdown calendar
    [Tags]    Under_review    Daniel    Tan_refactor
    Log    starting the dropdown calendar
    Set Test Variable    ${selected_day}    ${chosen_day}    #Sets a "file wide" variable so it can be accessed later on.
    ${input_count}    get_weekday_delta_offset    ${chosen_day}    #importing library of our file allows calls to funcs. -TT
    Log    input count: ${input_count}
    # DESPERATION KICKING IN - DK
    # Tried several methods while waiting for food, and what I found as I gave up was something about to go eat was
    # "import keyword" and assigning keywords to the python functions -DK
    Log    presses enter in date input field
    Press Keys    ${safari_date_input_field}    SPACE
    Log    attempts to step right in the calendar view
    Navigate ${input_count} steps to the right in the calendar
    Log    presses enter to select x date.
    Press Keys    None    Enter

Navigate ${amount_of_steps} steps to the right in the calendar
    [Tags]    Under_review    Daniel    Tan_refactor
    [Documentation]    Input solution for the dynamic calendar ui in javascript.
    FOR    ${key_press}    IN RANGE    ${amount_of_steps}
        Press Keys    None    ARROW_RIGHT    #i got trolled by documentation. i assumed none was literally no text -TT
        #Sleep    0.1s    #Use this if you want to see the actual movement during calendar selection. -TT
    END

Add VIP Tour
    [Arguments]    ${chosen_day}
    Click Element    ${nav_menu_safari}
    Wait Until Element Is Visible    ${safari_section}    10s
    Select From List By Index    ${safari_type_dropdown}    1 
    Select ${chosen_day} from dropdown calendar
    Click Element    ${add_safari_to_cart_button}
    Handle Alert

Add Multiple VIP Tours
    [Arguments]    ${count}    ${chosen_day}
    FOR    ${index}    IN RANGE    ${count}
        Add VIP Tour    ${chosen_day}
    END
