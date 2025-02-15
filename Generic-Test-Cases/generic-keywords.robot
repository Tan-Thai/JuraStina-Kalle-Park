*** Settings ***
Library  SeleniumLibrary
Variables  variables.py

*** Keywords ***

### Refactor - Registration ###
The user is not logged in, and is on the homepage
# Confirms by checking if the logout button is present
    ${is_logged_in}=    Run Keyword And Return Status    Element Should Be Visible   ${logout_button}
    Run Keyword If    ${is_logged_in}    Click Element    ${logout_button}
    Run Keyword If    ${is_logged_in}    Handle Alert
    Wait Until Page Contains Element    ${login_button}    timeout=10s

They attempt to register with valid credentials
    Click Element    ${register_button}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${SUBMIT_REGISTER}
    
### Refactor - Login ###
The user has a registered account
    They Attempt To Register With Valid Credentials
    
They log in with '${credential_type}' credentials
    # Using embedded variables that allows the input to be changed from "valid" to "invalid"
    # https://forum.robotframework.org/t/differences-between-if-elseif-and-run-keyword-if/5746/4
    # Seems like "run keyword if" is old compared to "if/else".
    Wait Until Element Is Visible    ${login_section}    10s
    IF  "${credential_type}" == "valid"
        They Enter Valid Login Credentials
    ELSE IF  "${credential_type}" == "invalid"
        They Enter Invalid Login Credentials
    ELSE
        Fail    Invalid credential type: ${credential_type}
    END

They should be logged in and be redirected to the homepage
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${logout_button}    10s

They should see an error message indicating login failure
    Wait Until Element Contains    ${login_message}    Invalid username or password.

### Refactor log out ###
They Log Out
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Page Contains Element    ${LOGOUT_BUTTON}    timeout=10s
    Click Element    ${LOGOUT_BUTTON}
    Handle Alert

They should be redirected to the homepage and see the login button
    Wait Until Element Is Visible    ${home_section}    10s
    Wait Until Element Is Visible    ${login_button}    10s
    
The User Is Logged In refactor
    The User Has A Registered Account
    They Log In With 'valid' Credentials
    They should be logged in and be redirected to the homepage

### refactor ticket ###
They add a ticket to the cart
    Click Element    ${buy_tickets_button}
    Click Element    ${submit_add_to_cart}

They should be able to see a confirmation message that the ticket was added
    Read alert message    ${ticket_added_to_cart_message_text}
    Handle Alert

### refactor tour ###
The user has bought a ticket - refactor
    They Add A Ticket To The Cart refactor
    #TODO: Check why buying a ticket and then choosing a tour is not working.
    #Proceed with the purchase at checkout
    #Handle Alert

### checkout refactor ###
They Add A Ticket To The Cart refactor
    Click Element    ${buy_tickets_button}
    Click Element    ${submit_add_to_cart}
    Handle Alert

Proceed with the purchase at checkout
    Click Element    ${cart_button}
    Wait Until Element Is Visible    ${cart_section}    10s
    Click Button    ${checkout_button}    

They should be able to see a checkout summary with their purchased items
    # TODO Check the text maybe? Should not be needed as the checkout button only works when there's items in the cart.
    # - TT
    ## test passes so i think this works???
    ${message} =    Handle Alert    #We handle + save the string attached in the alert here.
    Should Contain    ${message}    Checkout Summary:

They select a tour and a date
    Click Element    ${safari_button}
    Wait Until Element Is Visible    ${safari_section}    10s
    Select From List By Index    ${tour_dropdown}    1
    Input Text    ${safari_date_input}    ${safari_date}

They add the selected tour to the cart
    Click Element    ${submit_safari_to_cart}


####### Registration #######

User is on the register page
    Wait Until Page Contains Element    ${REGISTER_BUTTON}    timeout=10s
    Click Element    ${REGISTER_BUTTON}

They enter a valid username and password
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}

Click the register button
    Click Element    ${SUBMIT_REGISTER}



####### Login & Logout #######

They should be redirected to the login page
    # Should this not look for the login form itself instead of a login button?
    # Especially since login button is part of the nav-menu and thus always visible --TT
    # Wait Until Page Contains Element    ${LOGIN_BUTTON}    timeout=10s
    Wait Until Element Is Visible    ${login_section}    10s
    
User is on the login page
    Wait Until Page Contains Element    ${LOGIN_BUTTON}    timeout=10s
    Click Element    ${LOGIN_BUTTON}


They should be able to login
    # Confirms by checking if the logout button is present
    Wait Until Page Contains Element    ${LOGOUT_BUTTON}    timeout=10s

They should not be able to login
    # Confirms by checking if the login message is present
    Wait Until Page Contains Element    ${LOGIN_MESSAGE}    timeout=10s


They enter valid login credentials
    Input Text    ${LOGIN_USERNAME_FIELD}    ${USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${submit_login}
    #Sleep    2s
    #Input Text    ${LOGIN_USERNAME_FIELD}    ${USERNAME}
    #Input Text    ${LOGIN_PASSWORD_FIELD}    ${PASSWORD}

They enter invalid login credentials
    Input Text    ${LOGIN_USERNAME_FIELD}    ${INVALID_USERNAME}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Element    ${submit_login}


Click the login button
    Click Element    ${SUBMIT_LOGIN}
    Sleep    1s

They should be able to logout
    Wait Until Page Contains Element    ${LOGOUT_BUTTON}    timeout=10s
    Click Element    ${LOGOUT_BUTTON}
    Handle Alert
    Wait Until Page Contains Element    ${login_button}    timeout=10s



####### Buy Tickets #######

The user is on the buy tickets page
    Sleep    1s
    Wait Until Page Contains Element    ${buy_tickets_button}    timeout=10s
    Click Element    ${buy_tickets_button}

Click the add to cart button
    Click Element    ${submit_add_to_cart}

Add the tour ticket to cart
    Click Element    ${submit_safari_to_cart}

The page says item added to cart
    Read alert message    ${ticket_added_to_cart_message_text}

The user is on the cart page
    Wait Until Page Contains Element    ${cart_button}    timeout=10s
    Click Element    ${cart_button}

The user should be able to see the item in the cart
    Wait Until Page Contains Element    ${cart_details}    timeout=10s
    Page Should Contain Element    ${cart_item}

The user is on the buy safari page
    Wait Until Page Contains Element    ${safari_button}    timeout=10s
    Click Element    ${safari_button}

The user selects a specific tour and a date
    Select From List By Index    ${tour_dropdown}    1
    Input Text    ${safari_date_input}    ${safari_date}



####### Setup #######

The user has an account
    User is on the register page
    They enter a valid username and password
    Click the register button

The user is logged in
    User is on the login page
    They enter valid login credentials
    Click the login button
    Sleep    2s

The user has an item in the cart
    The user is on the buy tickets page
    Click the add to cart button
    Handle Alert

The user has bought a ticket
    The user is logged in
    The user is on the buy tickets page
    Click the add to cart button
    Handle Alert

####### General #######

Read alert message
    [Arguments]    ${MESSAGE_TEXT}
    Sleep    2s
    Alert Should Be Present    ${MESSAGE_TEXT}
