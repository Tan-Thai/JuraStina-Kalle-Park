*** Settings ***
Library  SeleniumLibrary
Resource    ../Generic-Test-Cases/generic-keywords.robot
Variables  snåla-kalle-variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser

*** Test Cases ***


Snåla-Kalle cross checks pricing of a tour on a new vs an old account
    [Tags]    Daniel
    [Documentation]
    Given That Snåla-Kalle has an account 'Snåla_Kalle' with a previous booking
