*** Settings ***
Documentation   Demo for parameterize test cases
Test Setup    Create WebDriver with Chrome options
#Test Teardown    Close Browser
Resource        ../pageObjects/General.resource
Resource    ../pageObjects/Driver.resource
Test Template    Validate Unsuccesful login


*** Variables ***
${alert_message_locator}    css:.alert
${alert_text_match}     Incorrect

*** Test Cases ***      username        password
Invalid username         Bob     learning
Invalid password        rahulshettyacademy      1234
Valid username and password     rahulshettyacademy      learning

*** Keywords ***

Validate Unsuccesful login
    [Arguments]    ${username}      ${password}
    Fill the login form     ${username}     ${password}
    Wait until it checks and display error message
    Verify error message is correct

Fill the login form
    [Arguments]    ${username}      ${password}
    Input Text    id:username   ${username}
    Input Password    id:password   ${password}
    Click Button    id:signInBtn

Wait until it checks and display error message
    Wait Until Element Is Visible    ${alert_message_locator}

Verify error message is correct
#    ${alert_text} =     Get Text    ${alert_message_locator}
#    Should Contain        ${alert_text}     ${alert_text_match}
    Element Should Contain    ${alert_message_locator}      ${alert_text_match}