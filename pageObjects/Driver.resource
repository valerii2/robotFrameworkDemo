*** Settings ***
Documentation    File for creation WebDriver and his options
Library    SeleniumLibrary
Library    Collections
Library    String


*** Variables ***
${url}      https://rahulshettyacademy.com/loginpagePractise/
${browser_name}     Firefox      # Chrome Firefox   Edge

*** Keywords ***
Open the browser with url
    Create Webdriver    ${browser_name}
    Maximize Browser Window
    Go To    ${url}

Create WebDriver with Chrome options
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --start-maximized
#    Call Method    ${chrome_options}    add_argument    --window-size=1920,1080
    Call Method    ${chrome_options}    add_argument    --chrome  # use 'headless' if you don't need a browser UI / 'chrome' if UI need
#    Call Method    ${chrome_options}    add_argument    ----incognito
    Call Method    ${chrome_options}    add_experimental_option     detach      ${True}     # Keeps the browser open

    ${excluded}    Create List      enable-logging
    Call Method    ${chrome_options}    add_experimental_option     excludeSwitches     ${excluded}

    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${url}

Create WebDriver with Firefox options
    ${firefox_options} =    Evaluate    selenium.webdriver.FirefoxOptions()
    Call Method    ${firefox_options}    add_argument    --start-maximized
#    Call Method    ${firefox_options}    add_argument    --window-size=1920,1080
    Call Method    ${firefox_options}    add_argument    --firefox  # use 'headless' if you don't need a browser UI / 'chrome' if UI need
    Create WebDriver    Firefox    firefox_options=${firefox_options}
    Go To    ${url}

Create WebDriver with Edge options
    ${edge_options} =    Evaluate    selenium.webdriver.EdgeOptions()
    Call Method    ${edge_options}    add_argument    --start-maximized
#    Call Method    ${edge_options}    add_argument    --window-size=1920,1080
    Call Method    ${edge_options}    add_argument    --edge  # use 'headless' if you don't need a browser UI / 'chrome' if UI need
    Create WebDriver    Edge    edge_options=${edge_options}
    Go To    ${url}