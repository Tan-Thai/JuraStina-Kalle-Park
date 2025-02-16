*** Settings ***
Library  SeleniumLibrary
Variables  variables.py

*** Keywords ***

### Registration ###
The user is not logged in, and is on the homepage
    # Confirms by checking if the logout button is present
    # https://forum.robotframework.org/t/differences-between-if-elseif-and-run-keyword-if/5746/4
    # Seems like "run keyword if" is old compared to "if/else". -TT
    [Tags]    Given
    ${is_logged_in}=    Run Keyword And Return Status    Element Should Be Visible   ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Click Element    ${nav_menu_logout}
    Run Keyword If    ${is_logged_in}    Handle Alert
    Wait Until Page Contains Element    ${nav_menu_login}    timeout=10s

They attempt to register with valid credentials
    [Tags]    When
    Click Element    ${nav_menu_register}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${SUBMIT_REGISTER}

They should be redirected to the login page
    [Tags]    Then
    # Should this not look for the login form itself instead of a login button?
    # Especially since login button is part of the nav-menu and thus always visible --TT
    Wait Until Element Is Visible    ${login_section}    10s

### Login ###
The user has a registered account
    [Tags]    Given
    They Attempt To Register With Valid Credentials

They log in with '${credential_type}' credentials
    [Tags]    When
    # Using embedded variables that allows the input to be changed from "valid" to "invalid"
    # https://forum.robotframework.org/t/differences-between-if-elseif-and-run-keyword-if/5746/4
    # Seems like "run keyword if" is old compared to "if/else". -TT
    # Can hardcode the functions of input here if we wanted, but I think this looks cleaner. -TT
    Wait Until Element Is Visible    ${login_section}    10s
    IF  "${credential_type}" == "valid"
        They Enter Valid Login Credentials
    ELSE IF  "${credential_type}" == "invalid"
        They Enter Invalid Login Credentials
    ELSE
        Fail    Invalid credential type: ${credential_type}
    END

They should be logged in and be redirected to the homepage
    [Tags]    Then
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${nav_menu_logout}    10s

They should see an error message indicating login failure
    [Tags]    Then
    Wait Until Element Contains    ${login_message}    Invalid username or password.

### Logout ###
The User Is Logged In
    [Tags]    Given
    The User Has A Registered Account
    They Log In With 'valid' Credentials
    They should be logged in and be redirected to the homepage

They Log Out
    [Tags]    When
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Page Contains Element    ${nav_menu_logout}    timeout=10s
    Click Element    ${nav_menu_logout}
    Handle Alert

They should be redirected to the homepage and see the login button
    [Tags]    Then
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${nav_menu_login}    10s

### Ticket ###
They add a ticket to the cart
    [Tags]    When    Given
    Click Element    ${nav_menu_ticket}
    Wait Until Element Is Visible    ${ticket_type_dropdown}    10s
    Select From List By Index    ${ticket_type_dropdown}    1
    Sleep    1s
    ${selected}=    Get Selected List Value    ${ticket_type_dropdown}
    Should Be Equal    ${selected}    VIP
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

### Tour ###
They add a viable tour with a chosen date to the cart
    [Tags]    When
    Click Element    ${nav_menu_safari}
    Wait Until Element Is Visible    ${safari_section}    10s
    Click Element    ${safari_date_input_field}
    #TODO: FIGURE OUT WHY AMERICAN DATE INPUT WORKS DESPITE OUR WEBSITE BEING DD-MM-YYYY. I hate this -TT
    ## I initially thought it was because we used 'en-us' locale. BUT the issue still persists with 'en-GB'.
    ## Conclusion: The website is trolling us. Legit decide and dont use all 3 variants man 🙃
    ##    Input from RobotFramework> MM-DD-YYYY
    ##    Input from Manual test > DD-MM-YYYY
    ##    Output in cart > YYYY-MM-DD            --TT
    Input Text    ${safari_date_input_field}    ${next_monday_date}
    Select From List By Index    ${safari_type_dropdown}    1
    Click Element    ${add_safari_to_cart_button}
    Handle Alert

They should be able to see the tour in the cart
    [Tags]    Then
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    10s
    ${locale}    Execute Javascript    return navigator.language
    Log To Console    Browser locale is: ${locale}
    #TODO: Currently expected date string is going by YY-MM-DD. Actual string is DD-MM-YY
    ${listed_items}    Get Text    ${cart_details}
    Should Not Contain    ${listed_items}    Your cart is empty
    Should Contain    ${listed_items}    ${expected_monday_date_in_cart}

### Checkout ###
Proceed with the purchase at checkout
    [Tags]    When
    #TODO: Check why buying a ticket and then choosing a tour is not working.
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    10s
    Click Button    ${checkout_button}

They should be able to see a checkout summary with their purchased items
    [Tags]    Then
    # TODO Check the text maybe? Should not be needed as the checkout button only works when there's items in the cart.
    ## test passes so i think this works??? -TT
    ${message} =    Handle Alert    #We handle + save the string attached in the alert here.
    Should Contain    ${message}    Checkout Summary:

The cart should be empty
    [Tags]    And
    Click Element    ${nav_menu_cart}
    Wait Until Element Is Visible    ${cart_section}    timeout=10s
    Element Should Contain    ${cart_details}    Your cart is empty


### Internal ###
They enter invalid login credentials
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${INVALID_USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Element    ${submit_login}

They enter valid login credentials
    [Tags]    Internal
    Input Text    ${LOGIN_USERNAME_FIELD}    ${USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${submit_login}
