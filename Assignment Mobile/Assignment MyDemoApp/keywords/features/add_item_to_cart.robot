*** Keywords ***
Selected products
    Wait Until Page Contains Element    xpath=${ITEM}        30s
    Tap     xpath=${ITEM}

Click add to cart
    Wait Until Page contains Element        ${btn_add_to_cart}         30s
    Tap     ${btn_add_to_cart}

Verify number on cart
    Wait Until Page Contains Element    xpath=${AMOUNT_IN_CART}     30s
    ${txt_number}=    get text   xpath=${AMOUNT_IN_CART} 
    ${txt_number}=    Convert To Integer    ${txt_number}
    Should Be Equal As Numbers      ${txt_number}    1


Click on cart icon
    Wait Until Page Contains Element    xpath=${btn_cart_Icon}           30s
    Tap     xpath=${btn_cart_Icon}


Verify that in cart has only one product
#Verify product name in my cart
    Wait Until Page Contains Element    ${name_my_cart}             30s
    ${name}     Get Text    ${name_my_cart}
    Should Contain     ${name}     Sauce Labs Backpack
    Log To Console  Product name : Sauce Labs Backpack
   
#Verify product price
    Wait Until Page Contains Element    ${product_price}             30s
    ${Price}     Get Text    ${product_price}
    Should Contain     ${Price}     29.99
    Log To Console  Price : 29.99

#Verify product item
    Wait Until Page Contains Element    ${product_item}             30s
    ${Product_Item}     Get Text    ${product_item}
    Should Contain     ${Product_Item}    1 item
    Log To Console  Total Item : 1 item

#Verify total price
    Wait Until Page Contains Element    ${total_price}             30s
    ${total_price}     Get Text    ${total_price}
    Should Contain     ${total_price}    $29.99
    Log To Console  Total Price : $29.99