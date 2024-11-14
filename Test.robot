*** Settings ***
Library  SeleniumLibrary
Library    String
Suite Setup    SeleniumLibrary.Set Selenium Speed     0.5
Test Teardown   Close Browser

*** Variables ***
${UAT_URL}         https://training-platform.doppio-tech.com
${PASSWORD}        @Vitamin444
${CONFIRM_PASSWORD}  @Vitamin444
${PRODUCT}         phone
${CARD_NUMBER}     4111111111111111
${EXPIRY_DATE}     12/2026
${CVC}             575
${phone_number}    0969964474
${address}         399/172
${Name}            Phat
${Sur_Name}        Chum
${search_P}        Doppee phone
${card_name}       Cat Test



*** Keywords ***
Open Browser To Website
    [Arguments]    ${url}=${UAT_URL}
    Open Browser    ${url}    Chrome
    Maximize Browser Window

Generate email
    ${numbers}=    Evaluate    random.randrange(10000)
    ${user_email}    Set Variable     gus${numbers}@gmail.com
    Set Global Variable     ${user_email}
    RETURN      ${user_email}

Input email address
    [Arguments]     ${user_email}
     Input Text    ${txt_email}    ${user_email}

Input password
    [Arguments]    ${password}
    Input Text    ${txt_password}    ${password}

Input confirm password
    [Arguments]    ${confirm_password}
    Input Text    ${txt_confirm_password}   ${confirm_password}

Click sign up for new account
    Click MyElement    ${btn_signup_new_account}

See pop up register user success
    Wait Until Element Is Visible    ${txt_message} 

Click ok button for register user success
    Click MyElement    ${btn_ok_regis}
    
Register user success
    [Arguments]    ${user_email}     ${password}    ${confirm_password}
    Click Element    xpath=//div[@id='app']//span[@aria-label='user']
    Click Element    xpath=//div[@id="app"]//button[@type='button']/span
    Input Text      xpath=//div[@id='app']//span//input[@id='basic_username']    ${user_email} 
    Input Text      xpath=//div[@id='app']//span//input[@id='basic_password']    ${password}
    Input Text      xpath=//div[@id='app']//span//input[@id='basic_confirmPassword']    ${confirm_password}
    Click Button    xpath=//div[@id='app']//button
    Wait Until Element Is Visible	//span[@class="ant-modal-confirm-title"]
    Click Element    xpath=//span[contains(text(),'OK')]
     
Search for product
    [Arguments]    ${search_P}
    Input Text          xpath=//div[@id="app"]//input  ${search_P}
    Wait Until Element Is Visible    xpath=//div[@id="app"]//input      
    Click Element       xpath=//div[@id="app"]//button/span[@aria-label='search'] 
    Wait Until Element Is Visible    xpath=//div[@id="app"]//button/span[@aria-label='search']     
    Click Element       xpath=//div[@id="app"]//div[text()='Doppee phone']

Add Product To Cart
    Click Element       xpath=//div[@id="app"]//button/span[text()='Add to cart']
    Wait Until Element Is Visible    //span[text()='Product detail page']
    Click Element       xpath=//button[@class="css-eq3tly ant-btn ant-btn-primary"]

Fill Delivery Info
    [Arguments]    ${Name}  ${surName}  ${address}  ${phone_number}   
    Click Element       xpath=//div[@id="app"]//span[@aria-label='shopping-cart']
    Input Text          xpath=//div[@id="app"]//input[@id='form_item_name']     ${Name}
    Input Text          xpath=//div[@id="app"]//input[@id='form_item_surName']  ${surName}
    Input Text          xpath=//div[@id="app"]//input[@id='form_item_address']  ${address}
    Input Text          xpath=//div[@id="app"]//input[@id='form_item_phone']    ${phone_number}

Purchase Product With Credit Card
    [Arguments]    ${CARD_NUMBER}  ${EXPIRY_DATE}  ${CVC}  ${card_name}
    Click Element       xpath=//div[@id="app"]//span[text()='PAY']
    Click Element       xpath=//div[@id="app"]//span[text()='Credit Card']
    Click Element       xpath=//div[@id="app"]//span[text()='Next']
    Input Text          xpath=//div[@id="app"]//input[@id='basic_bin']      ${CARD_NUMBER}
    Input Text          xpath=//div[@id="app"]//input[@id='basic_exp']      ${EXPIRY_DATE}
    Input Text          xpath=//div[@id="app"]//input[@id='basic_cvc']      ${CVC}
    Input Text          xpath=//div[@id="app"]//input[@id='basic_owner']    ${card_name}
    Click Element       xpath=//div[@id="app"]//span[text()='Confirm Payment']
    Wait Until Element Is Visible	//span[@class="ant-modal-confirm-title"]
    Click Element       xpath=//div//span[text()='OK']

Get Order
    ${order_details}    Get text   xpath=//div[@class='success-description']
    ${order_details}=    String.Replace String     ${order_details}     \n    ${SPACE}
    @{splited_detail}=   String.Split String    ${order_details}       ${SPACE}
    RETURN    ${splited_detail[2]}

Navigate to My Orders
    [Arguments]     ${Order_id}
    Click Element       xpath=//div[@id="app"]//span[text()='Continue Shopping']
    Click Element    xpath=//div[@id='app']//span[@aria-label='user']
    Scroll Element Into View    xpath=//div[@class='ant-spin-container']
    Sleep   10S
    Click Element       xpath=//div[@role="tab" and text()="Preparing"]
    ${order_details}    Get text    xpath=//tr[contains(@class, 'ant-table-row')]/td[1]
    IF  ${order_details} == ${Order_id}
        Pass Execution      Order id is correct   
    END
   

*** Test Cases ***
Registration and create order success
    ${user_email}=     Generate email
    Log To Console  ${user_email}
    Open Browser To Website    ${UAT_URL}
    Register user success   ${user_email}   ${password}     ${confirm_password}
    Search for product      ${search_P}
    Add product to cart
    Fill Delivery Info  ${Name}  ${surName}  ${address}  ${phone_number}  
    Purchase Product With Credit Card   ${CARD_NUMBER}  ${EXPIRY_DATE}  ${CVC}  ${card_name}
    ${Order_id}=      Get Order  
    Log To Console  ${Order_id}
    Navigate To My Orders  ${Order_id} 
 
    #edit