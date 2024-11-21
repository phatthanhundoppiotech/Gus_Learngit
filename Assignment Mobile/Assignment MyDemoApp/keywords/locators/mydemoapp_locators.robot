*** Variables ***
${ITEM}               //android.widget.TextView[@content-desc="store item text" and @text="Sauce Labs Backpack"]
${btn_add_to_cart}     accessibility_id=Add To Cart button
${AMOUNT_IN_CART}      //android.view.ViewGroup[@content-desc="cart badge"]/android.widget.ImageView//following-sibling::android.widget.TextView
${btn_cart_Icon}       //android.view.ViewGroup[@content-desc="cart badge"]/android.widget.ImageView
${name_my_cart}        accessibility_id=product label
${product_price}       accessibility_id=product price
${product_item}        accessibility_id=total number
${total_price}         accessibility_id=total price