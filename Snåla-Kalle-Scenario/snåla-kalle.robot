*** Settings ***
Library  SeleniumLibrary
Resource    ../Generic-Test-Cases/generic-keywords.robot
Variables  snåla-kalle-variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser

*** Test Cases ***


Snåla-Kalle cross checks pricing of a tour on a new vs an old account
    [Tags]    Daniel
    [Documentation]    Assures that there is no "first-time-visitor-discount", despite the rumours
    #
    #    No keywords implemented as of this push
    #
    Given That Snåla-Kalle has an account 'Snåla-Kalle' with a previous visit
    And Snåla-Kalle has created a new account 'Ståla-Nalle' and is logged in
    When Snåla-Kalle looks at the cart price of a '<ticket>' and a '<tour>'    # choose ticket and tour
    And Snåla-Kalle changes account to 'Snåla-Kalle'
    And Snåla-Kalle looks at the cart price of a '<ticket>' amd a '<tour>'    # choose ticket and tour
    Then The 'first price' and 'second price' should match
