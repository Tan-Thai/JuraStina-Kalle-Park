*** Settings ***
Library  SeleniumLibrary
Library    ../resources/global_files/weekday_helper.py
Library    ../resources/global_files/CartHelper.py
Variables  variables.py

*** Variables ***
${cart_helper}    CartHelper

*** Keywords ***
setup test env
    Open Browser    ${URL}    ${BROWSER}
    Initialize Cart Helper
    Create Dictionary

Initialize Cart Helper
    ${cart_helper} =  #### something here to enable the carthelper.
    Log To Console    init cart
    Set Test Variable  ${CART_HELPER}

The User Is Logged In
    [Tags]    Given
    The User Has A Registered Account
    They Log In With 'valid' Credentials
    They should be logged in and be redirected to the homepage

The user has a registered account
    [Tags]    Given
    They Attempt To Register With Valid Credentials

They attempt to register with valid credentials
    [Tags]    When
    Click Element    ${nav_menu_register}
    Input Text    ${USERNAME_FIELD}    ${valid_username}
    Input Text    ${PASSWORD_FIELD}    ${valid_password}
    Click Element    ${SUBMIT_REGISTER}

They log in with '${credential_type}' credentials
    [Tags]    When
    # Using embedded variables that allows the input to be changed from "valid" to "invalid"
    # https://forum.robotframework.org/t/differences-between-if-elseif-and-run-keyword-if/5746/4
    # Seems like "run keyword if" is old compared to "if/else". -TT
    # Can hardcode the functions of input here if we wanted, but I think this looks cleaner. -TT
    Wait Until Element Is Visible    ${login_section}    10s

    IF  "${credential_type.lower()}" == "valid"
        They Enter Valid Login Credentials
    ELSE IF  "${credential_type.lower()}" == "invalid"
        They Enter Invalid Login Credentials
    ELSE
        Fail    Invalid credential type: ${credential_type}
    END

They enter invalid login credentials
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${INVALID_USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Element    ${submit_login}

They enter valid login credentials
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${valid_username}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${valid_password}
    Click Element    ${submit_login}

They should be logged in and be redirected to the homepage
    [Tags]    Then
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${nav_menu_logout}    10s

They add a '${ticket_type}' ticket to the cart
    [Tags]    When    Given
    Click Element    ${nav_menu_ticket}
    Wait Until Element Is Visible    ${ticket_category_dropdown}    10s

    # unsure if this works but this will make it all lowercase from my understanding
    # as shown in valid/invalid, you can skip setting variables and just use `.lower()` right away
    # instead of creating multiple steps. But i think its good to showcase both for learning purposes. -TT
    ${ticket_type_lower}    Set Variable    ${ticket_type.lower()}

    IF  "${ticket_type_lower}" == "regular"
        Select From List By Index    ${ticket_category_dropdown}    0
    ELSE IF  "${ticket_type_lower}" == "vip"
        Select From List By Index    ${ticket_category_dropdown}    1
    ELSE
        Fail    Invalid ticket type: ${ticket_type}
    END

    ${selected}=    Get Selected List Value    ${ticket_category_dropdown}
    ${selected_lower}    Set Variable   ${selected.lower()}
    Should Contain    ${selected_lower}    ${ticket_type_lower}
    Click Element    ${add_ticket_to_cart_button}

    ${message} =    Handle Alert
    Should Contain    ${message}    ${item_added_to_cart_message_text}

They should be able to see the ticket in the cart
    [Tags]    Then
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    10s
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    Ticket    #Currently hardcoded to test, not sure if its needed as variable.-TT
