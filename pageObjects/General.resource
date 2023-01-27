*** Settings ***
Documentation      A resource file with reusable keywords and variables.
...
...
...
Library    SeleniumLibrary
Library    Collections
Library    String


*** Variables ***
${user_name}     rahulshettyacademy
${invalid_password}     1234
${valid_password}       learning

*** Keywords ***

Wait until the element is located on the page
    [Arguments]    ${element_check}
    Wait Until Element Is Visible       ${element_check}    10
