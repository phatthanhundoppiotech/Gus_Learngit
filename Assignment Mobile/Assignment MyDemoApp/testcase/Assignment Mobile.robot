*** Settings ***
Library     AppiumLibrary
Resource    ./keywords/pages/common.robot
Resource    ./keywords/features/add_item_to_cart.robot
Resource    ./keywords/locators/mydemoapp_locators.robot
Variables   ./resources/settings/mydemoapp_settings.yaml


*** Test Cases ***
Open Application and Verify add product to my cart
    Open Application MyDemoApp
    Selected products
    Click add to cart
    Verify number on cart
    Click on cart icon
    Verify that in cart has only one product


