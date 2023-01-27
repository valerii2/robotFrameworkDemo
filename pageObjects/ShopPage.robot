*** Settings ***
Documentation    All keywords and objects for shop page
Library    SeleniumLibrary
Library    Collections


*** Keywords ***
Verify product list in the shop
    [Arguments]  @{expected_product_list}
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