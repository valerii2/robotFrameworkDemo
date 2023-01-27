*** Settings ***
Documentation    All keywords and objects for login page
Library    SeleniumLibrary


*** Variables ***
${alert_message_locator}    css:.alert
${alert_text_match}         Incorrect

*** Keywords ***
Fill the login form
    [Arguments]    ${username}  ${password}
    Input Text    id:username   ${username}
    Input Password    id:password   ${password}
    Click Button    id:signInBtn

Verify error message is correct
#    ${alert_text} =     Get Text    ${alert_message_locator}
#    Should Contain        ${alert_text}     ${alert_text_match}
    Element Should Contain    ${alert_message_locator}      ${alert_text_match}

Fill the login details and login form
    [Arguments]    ${username}  ${password}
    Input Text    id:username   ${username}
    Input Password    id:password   ${password}
    Click Element    xpath:(//input[@id='usertype'])[2]
    Wait Until Element Is Visible    css:.modal-content
    Click Button    id:okayBtn
    Click Button    id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-content
    Select Checkbox    id:terms
    Checkbox Should Be Selected    id:terms