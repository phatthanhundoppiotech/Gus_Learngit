*** Keywords ***
Open Application MyDemoApp
    Open Application    	remote_url=http://localhost:4723/wd/hub     
    ...     deviceName=Pixel_4_API_30   
    ...     platformVersion=11.0    
    ...     platformName=Android
    ...     appPackage=com.saucelabs.mydemoapp.rn
    ...     appActivity=com.saucelabs.mydemoapp.rn.MainActivity