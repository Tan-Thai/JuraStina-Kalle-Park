*** Settings ***
Library  SeleniumLibrary
Resource    ../Generic-Test-Cases/generic-keywords.robot
Resource    snåla-kalle-keywords.robot
Variables  snåla-kalle-variables.py
Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser


*** Test Cases ***


Snåla-Kalle cross checks pricing of a tour on a new vs an old account
    [Tags]    Daniel
    [Documentation]    Assures that there is no "first-time-visitor-discount", despite the rumours
    Given Snåla-Kalle has an account Snåla-Kalle with a previous visit
    And Snåla-Kalle has created a new account Ståla-Nalle and is logged in
    When Snåla-Kalle looks at the price_of_first_item of a 'REGULAR' ticket and a HERBIVORE tour
    And Snåla-Kalle changes account to Snåla-Kalle
    And Snåla-Kalle looks at the price_of_second_item of a 'REGULAR' ticket and a HERBIVORE tour
    Then The price_of_first_item and price_of_second_item should match
    #
    # I am guessing the variables are not getting declared correctly
    #  or falling out of scope during "Snåla-Kalle looks at the price..." step -DK