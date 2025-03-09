*** Settings ***
Library  SeleniumLibrary

Resource    ${EXECDIR}/keywords/registration-keywords.resource
Resource    ${EXECDIR}/keywords/snåla-kalle-keywords.resource

Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser

*** Test Cases ***


Snåla-Kalle cross checks pricing of a tour on a new vs an old account
    [Tags]    Daniel    Tan_refactor
    [Documentation]    Assures that there is no "first-time-visitor-discount", despite the rumours
    Given Snåla-Kalle has an existing account and is logged in to a new account "Ståla-Nalle"
    When User checks the price on both accounts of a regular ticket and a herbivore tour
    Then The price of both purchases should match each other
