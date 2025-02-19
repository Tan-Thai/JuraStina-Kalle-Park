*** Settings ***
Library  SeleniumLibrary
Resource    ../Generic-Test-Cases/generic-keywords.robot
Variables    snåla-kalle-variables.py

*** Keywords ***

Snåla-Kalle has an account ${ACCOUNT_NAME} with a previous visit
    [Tags]    Given
    The user has a registered account



# Snåla-Kalle has an account 'Snåla-Kalle' with a previous visit
#
#  Make embedded "${name} has an account..." ? - DK



# Snåla-Kalle has created a new account 'Ståla-Nalle' and is logged in



# Snåla-Kalle looks at the cart price of a '<ticket>' amd a '<tour>'



# Snåla-Kalle changes account to 'Snåla-Kalle'



# The 'first price' and 'second price' should match


## Borrowed ##

The user has a registered account with username ${USERNAME}
    [Tags]    Given
    They attempt to register with username USERNAME

They attempt to register with username ${USERNAME}
    [Tags]    When
    Click Element    ${nav_menu_register}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${snålakalle_password}
    Click Element    ${SUBMIT_REGISTER}