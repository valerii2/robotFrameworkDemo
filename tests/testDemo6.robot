*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py
Library    ../customLibraries/Cart.py
#Test Setup    Open the browser with url
Test Setup    Create WebDriver with Chrome options
#Test Setup    Create WebDriver With Firefox Options
#Test Setup    Create WebDriver With Edge Options
#Test Teardown    Close Browser
#Suite Setup
#Suite Teardown
Resource        ../pageObjects/Driver.resource
Resource        ../pageObjects/General.resource
Resource        ../pageObjects/LoginPage.robot
Resource        ../pageObjects/ShopPage.robot
Resource        ../pageObjects/CheckoutPage.robot



*** Variables ***

${shop_page_locator}        css:.nav-link
@{expected_product_list}    iphone X    Samsung Note 8      Nokia Edge      Blackberry
@{need_products_list}       Samsung Note 8      Blackberry
${country}      Austria
${checkout_suggestions}     css:.suggestions

*** Test Cases ***
Validate Unsuccesful login
    [Tags]    Negative
    LoginPage.Fill the login form     ${user_name}    ${invalid_password}
    General.Wait until the element is located on the page       ${alert_message_locator}
    LoginPage.Verify error message is correct

Validate succesful login and display product page
    [Tags]    Smoke
    LoginPage.Fill the login form     ${user_name}    ${valid_password}
    General.Wait until the element is located on the page       ${shop_page_locator}
    ShopPage.Verify product list in the shop        @{expected_product_list}
#    ShopPage.Select the product      Nokia Edge
    Add Products To Cart        ${need_products_list}
    Check Products In Cart      ${need_products_list}
    CheckoutPage.Input country name     ${country}
    General.Wait until the element is located on the page       ${checkout_suggestions}
    Select country from suggestions list        ${country}
    CheckoutPage.Agree term and purchase product with verification

Validate succesful login and display child window
    [Tags]    Positive
    LoginPage.Fill the login details and login form     ${user_name}    ${valid_password}


