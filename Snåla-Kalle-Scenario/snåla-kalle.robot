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
    # Given Snåla-Kalle has an existing account and a new account 'Snåla-Nalle' is created and logged in
        # reasoning: we have the tools to change account 'could' potentially just bake this into 1
        # only drawback would be the missing "with a previous visit" in our case
    ## alt: ##
    # Given Snåla-Kalle has an account with a previous purchase and visit
        # reasoning: this will keep our current structure but just make it clear that "a" purchase has been made before.
    Given Snåla-Kalle has an account Snåla-Kalle with a previous visit
    And User has created a new account Ståla-Nalle and is logged in

    # When Both users check the price of a 'Regular' ticket and a tour
        # reasoning: We might as well combine this into 1 step and then break it down in keywords.
        # easier for the reader to understand that we are "comparing" 2 by
        # saying that we are checking prices of both more or less.
    When User checks the price of a 'REGULAR' ticket and a tour
    And User changes account to Snåla-Kalle
    And User checks the price of a 'REGULAR' ticket and a tour

    Then The price of both purchases should match each other


# Create og account
    # register > login
    # do a purchase to to simulate previous visit
    # log out
# create second "new" user
    #login
    
# buy ticket + tour and then record the price
    # logout

# login into first user
    # replicate purchase

# compare price diff