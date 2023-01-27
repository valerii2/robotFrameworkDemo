*** Settings ***
Documentation   Demo for parameterize test cases
Test Setup    Create WebDriver with Chrome options
Test Teardown    Close Browser
Resource        ../pageObjects/General.resource
Resource    ../pageObjects/Driver.resource
#Library    DataDriver       file=resources/data.csv     encoding=utf_8      dialect=unix
Library    DataDriver       file=resources/data1.xlsx       #  sheet_name=2nd Sheet
Test Template    Validate Unsuccesful login


*** Variables ***
${alert_message_locator}    css:.alert
${alert_text_match}     Incorrect

*** Test Cases ***
Login form with user ${username} and password ${password}       Default     UserData


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