*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Test Teardown    Close Browser
#Resource


*** Variables ***
${alert_message_locator}    css:.alert
${alert_text_match}     Incorrect

*** Test Cases ***
Validate Unsuccesful login
    Open the browser with url
    Fill the login form
    Wait until it checks and display error message
    Verify error message is correct

*** Keywords ***
Open the browser with url
    Create Webdriver    Chrome
    Maximize Browser Window
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the login form
    Input Text    id:username   Name
    Input Password    id:password   1234
    Click Button    id:signInBtn

Wait until it checks and display error message
    Wait Until Element Is Visible    ${alert_message_locator}

Verify error message is correct
#    ${alert_text} =     Get Text    ${alert_message_locator}
#    Should Contain        ${alert_text}     ${alert_text_match}
    Element Should Contain    ${alert_message_locator}      ${alert_text_match}