*** Settings ***
Documentation    All keywords and objects for checkout page
Library    SeleniumLibrary

*** Keywords ***
Input country name
    [Arguments]    ${country_name}
    Input Text    country       ${country_name}

Select country from suggestions list
    [Arguments]    ${country_name}
    Click Element    xpath://a[normalize-space()='${country_name}']

Agree term and purchase product with verification
    Click Element    css:label[for='checkbox2']
    Click Element    css:input[value='Purchase']
    Element Should Be Visible    css:.alert.alert-success.alert-dismissible
    Element Should Contain    css:.alert.alert-success.alert-dismissible        Success!