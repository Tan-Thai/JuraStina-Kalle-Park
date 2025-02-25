*** Settings ***
Library  SeleniumLibrary
Library    ../resources/global_files/weekday_helper.py
Variables  VG_Variables.py

*** Keywords ***

The user is on the landing page
    [Tags]    Given
    [Documentation]    Ensures that the user has landed on the homepage
     Title Should Be    Jura-Stina-Kalle Park

The user loads the landing page
    [Tags]    When
    [Documentation]    Ensures that the page is fully loaded in and confirms the section that constitutes as "homepage"
    Wait Until Element Is Visible    ${landing_page_section}

The user should see news articles displayed on the homepage
    [Tags]    Then
    [Documentation]    Ensures that the homepage actually contains the news we expect
    #https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Get%20WebElements
    # quick yolo
    Wait Until Element Is Visible    ${card_container}
    ${cards}=     Get Webelements    ${card_list}
    Should Not Be Empty    ${cards}    The container is empty, which indicates that no news are present

