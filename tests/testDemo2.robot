*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Library    Collections
#Test Setup    Open the browser with url
Test Setup    Create WebDriver with Chrome options
#Test Teardown    Close Browser
Resource        ../pageObjects/General.resource
Resource    ../pageObjects/Driver.resource



*** Variables ***
${alert_message_locator}    css:.alert
${alert_text_match}         Incorrect
${shop_page_locator}        css:.nav-link
@{expected_product_list}    iphone X    Samsung Note 8      Nokia Edge      Blackberry

*** Test Cases ***
#Validate Unsuccesful login
#    Fill the login form     ${user_name}    ${invalid_password}
#    Wait until the element is located on the page       ${alert_message_locator}
#    Verify error message is correct

#Validate succesful login and display product page
#    Fill the login form     ${user_name}    ${valid_password}
#    Wait until the element is located on the page       ${shop_page_locator}
#    Verify product list in the shop
#    Select the product      Nokia Edge

Validate succesful login and display child window
    Fill the login details and login form     ${user_name}    ${valid_password}

*** Keywords ***


Fill the login form
    [Arguments]    ${username}  ${password}
    Input Text    id:username   ${username}
    Input Password    id:password   ${password}
    Click Button    id:signInBtn

Wait until the element is located on the page
    [Arguments]    ${element_check}
    Wait Until Element Is Visible       ${element_check}

Verify error message is correct
#    ${alert_text} =     Get Text    ${alert_message_locator}
#    Should Contain        ${alert_text}     ${alert_text_match}
    Element Should Contain    ${alert_message_locator}      ${alert_text_match}

Verify product list in the shop
    @{actual_product_list}=     Create List
    @{shop_elements}=   Get Webelements    xpath://h4[@class='card-title']

    FOR  ${shop_element}  IN  @{shop_elements}
        Log    ${shop_element.text}
        Append To List    ${actual_product_list}    ${shop_element.text}
    END

    Log    ${actual_product_list}
    Log    ${expected_product_list}
    Lists Should Be Equal    ${expected_product_list}   ${actual_product_list}

Select the product
    [Arguments]    ${product_name}
    @{shop_elements}=   Get Webelements    xpath://h4[@class='card-title']
    ${item_number}=     Set Variable    1
    FOR  ${shop_element}  IN  @{shop_elements}
        IF    '${product_name}' == '${shop_element.text}'       BREAK
        ${item_number}=     Evaluate    ${item_number} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${item_number}]/button

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
