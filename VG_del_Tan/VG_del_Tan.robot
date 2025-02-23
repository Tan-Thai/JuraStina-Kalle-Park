*** Settings ***
Library  SeleniumLibrary
Resource    VG_del_Tan_keywords.resources
Test Setup  Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option("prefs", {"intl.accept_languages": "en-GB"})
Test Teardown    Close Browser


*** Test Cases ***


## Check that frontpage contains news ##
# The user should be able to see the current news when landing on the front page,
#  and when they return to it from another "page/view".
# It should contain all expected news

The user sees the frontpage with news when entering the website
    [Tags]    Tan    FrontPage-News
    [Documentation]    Test ensures that the frontpage is functional and actually shows the expected news.
    Given The user has access to the webpage and enters it
    When The user inspects the landing page
    Then The user should be able see the homepage filled with news.

The user sees the frontpage with news after registering and logging in
    [Tags]    Tan    FrontPage-News
    [Documentation]    Test ensures that the news are still shown after login. Could be made to compare with previous test.
    Given The user is on the homepage
    And Can see the news
    When The user registers and logs in
    Then The user should be able to see the homepage filled with news



## Check that a user has a unique name
# User should be able to register an account with a unique username
# When another account with the same username attempts to register then an error should appear with the message that
# the username they entered already is in use.

# extra, try with uppercase/lowercase diff.
The user registers an account
    [Tags]    Tan    Account-Register
    [Documentation]    Test ensures that it is possible to register an account
    Given The user is not logged in on any account
    When The user enters the registration page and registers an account
    Then The user should get a prompt that they have successfully created an account

The user login to an existing account with correct credentials
    [Tags]    Tan    Account-Login
    [Documentation]    Test ensures that a registered account is able to be accessed if the credentials are valid
    Given The user has an existing account
    When The user attempts to log in with 'valid' credentials
    Then The user should get a success message and be redirected to the homepage    #combining this step due to the redirect being attached to login.

The user login to an existing account with incorrect credentials
    [Tags]    Tan    Account-Login
    [Documentation]    Test ensures that a registered account requires correct credentials to be accessed
    Given The user has an existing account
    When The user attempts to log in with 'invalid' credentials
    Then The user should get an error message that tells them about invalid credentials

The user attempts to register an account with an already taken username
    [Tags]    Tan    Account-Login
    [Documentation]    Test ensures that a unique username cannot be used again-
    [Documentation]    during registration. An error message should be returned
    [Documentation]    The test also checks for case-sensitivity
    Given The user has an existing account
    When The user attempts to register with the same name as the existing account
    Then The user should get an error message that tells them that the username is taken

