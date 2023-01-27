*** Settings ***
Documentation   Link to another windwow, grab email, return to main window, and complete login form
Test Setup    Create WebDriver with Chrome options
#Test Teardown    Close Browser
Resource        ../pageObjects/General.resource
Resource    ../pageObjects/Driver.resource


*** Test Cases ***
Switch between windows, grab information, past to form
    Set link to another-child window
    Verify that child window is opened
    Grab email from child window
    Paste email in login form

*** Keywords ***
Set link to another-child window
    Click Element    css:.blinkingText
    Sleep    5

Verify that child window is opened
    Switch Window    NEW
    Element Text Should Be    css:div[class='inner-box'] h1     DOCUMENTS REQUEST

Grab email from child window
    ${mark}=    Set Variable    @
    ${text}=    Get Text    css:.im-para.red
    Log    ${text}
    @{text_list}=   Split String     ${text}
    Log    ${text_list}
    FOR    ${word}  IN  @{text_list}
        IF  '${mark}' in '${word}'
        ${email}=   Set Variable     ${word}
        Log   ${email}
        END
    END
    Set Global Variable    ${email}

Paste email in login form
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username       ${email}
