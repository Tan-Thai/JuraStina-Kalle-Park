*** Settings ***
Library    SeleniumLibrary
Library    ../python-object-models/weekday_helper.py
Variables    ../python-object-models/variables.py

*** Keywords ***
They add a tour booked for next ${chosen_day} by navigating the calendar dropdown using the keyboard to the cart  #working name -DK
    [Tags]    When
    Click Element    ${nav_menu_safari}
    Wait Until Element Is Visible    ${safari_section}    10s
    Selecting ${chosen_day} from dropdown calendar
    Click Element    ${add_safari_to_cart_button}
    Handle Alert

Selecting ${chosen_day} from dropdown calendar
    [Tags]    Under_review    Daniel    Tan_refactor
    Set Test Variable    ${selected_day}    ${chosen_day}    #Sets a "file wide" variable so it can be accessed later on.
    ${input_count}    get_weekday_delta_offset    ${chosen_day}    #importing library of our file allows calls to funcs. -TT
    # DESPERATION KICKING IN - DK
    # Tried several methods while waiting for food, and what I found as I gave up was something about to go eat was
    # "import keyword" and assigning keywords to the python functions -DK
    Press Keys    ${safari_date_input_field}    SPACE
    Navigate ${input_count} steps to the right in the calendar
    Press Keys    None    Enter

Navigate ${amount_of_steps} steps to the right in the calendar
    [Tags]    Under_review    Daniel    Tan_refactor
    [Documentation]    Input solution for the dynamic calendar ui in javascript.
    FOR    ${key_press}    IN RANGE    ${amount_of_steps}
        Press Keys    None    ARROW_RIGHT    #i got trolled by documentation. i assumed none was literally no text -TT
        #Sleep    0.1s    #Use this if you want to see the actual movement during calendar selection. -TT
    END

They should be able to see the tour in the cart
    [Tags]    Then
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    10s
    #${locale}    Execute Javascript    return navigator.language
    #Log To Console    Browser locale is: ${locale}
    ${listed_items}    Get Text    ${cart_details}
    ${expected_date} =    get_upcoming_target_weekday_date    ${selected_day}

    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    ${expected_date}