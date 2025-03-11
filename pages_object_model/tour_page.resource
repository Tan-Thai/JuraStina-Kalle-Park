*** Settings ***
Library    SeleniumLibrary
Library    ${EXECDIR}/python_objects/weekday_helper.py

Resource    ${EXECDIR}/keywords/common-keywords.resource

Variables    ${EXECDIR}/python_objects/variables.py
*** Keywords ***
Open Calendar Dropdown
    Set Focus To Element    ${safari_date_input_field}
    Press Keys    none    SPACE

Confirm Calendar Selection
    Press Keys    None    ENTER

Add Tour To Cart
    Log To Console   attempting to add tour to cart
    Click Element    ${add_safari_to_cart_button}
    Log To Console    sucessfully clicked add to cart

Verify Tour Added To Cart Message
    Log To Console    attempting to handle alert.
    Alert Should Be Present    ${EMPTY}    action=accept
    Log To Console    handling alert succeeded
    Sleep    0.5s

Verify Cart Contains Tour
    [Arguments]    ${expected_date}
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    ${expected_date}

Select ${chosen_day} from dropdown calendar
    [Tags]    Daniel    Tan_refactor
    Set Test Variable    ${selected_day}    ${chosen_day}    #Sets a "file wide" variable so it can be accessed later on.
    ${input_count}    get_weekday_delta_offset    ${chosen_day}    #importing library of our file allows calls to funcs. -TT
    # DESPERATION KICKING IN - DK
    # Tried several methods while waiting for food, and what I found as I gave up was something about to go eat was
    # "import keyword" and assigning keywords to the python functions -DK
    Press Keys    ${safari_date_input_field}    SPACE
    Navigate ${input_count} steps to the right in the calendar
    Log To Console   presses enter to select x date.
    Confirm Calendar Selection

Navigate ${amount_of_steps} steps to the right in the calendar
    [Tags]    Daniel    Tan_refactor
    [Documentation]    Input solution for the dynamic calendar ui in javascript.
    FOR    ${key_press}    IN RANGE    ${amount_of_steps}
        Press Keys    None    ARROW_RIGHT    #i got trolled by documentation. i assumed none was literally no text -TT
        #Sleep    0.1s    #Use this if you want to see the actual movement during calendar selection. -TT
    END

Add VIP Tour
    [Arguments]    ${chosen_day}
    Select From List By Index    ${safari_type_dropdown}    1 
    Select ${chosen_day} from dropdown calendar
    Add Tour To Cart
    Verify Tour Added To Cart Message

Add Multiple VIP Tours
    [Arguments]    ${count}    ${chosen_day}
    Navigate To Tour Page
    Wait For Safari Section
    FOR    ${index}    IN RANGE    ${count}
        Add VIP Tour    ${chosen_day}
    END
