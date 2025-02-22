*** Settings ***
Library  SeleniumLibrary
Resource    ../Generic-Test-Cases/generic-keywords.robot
Resource    snåla-kalle-keywords.robot
Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser
   

*** Test Cases ***


Snåla-Kalle cross checks pricing of a tour on a new vs an old account
    [Tags]    Daniel
    [Documentation]    Assures that there is no "first-time-visitor-discount", despite the rumours
    Given Snåla-Kalle has an account Snåla-Kalle with a previous visit
    And User has created a new account Ståla-Nalle and is logged in
    When User checks the price of a 'REGULAR' ticket and a tour
    And User changes account to Snåla-Kalle
    And User checks the price of a 'REGULAR' ticket and a tour
    Then The price of both purchases should match each other