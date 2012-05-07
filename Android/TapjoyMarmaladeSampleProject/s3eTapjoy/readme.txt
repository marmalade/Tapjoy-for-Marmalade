Tapjoy Marmalade Plugin for Android


Follows these steps to integrate this extension into your Marmalade application:
  * Copy the s3eTapjoy folder into your Airplay-SDK\extensions folder.
  * Include the sub project in your mkb file using "subproject ../extension/Tapjoy"
  * Run your project's mkb file to generate the project.
  * You will need a custom AndroidManifest.xml and add these parameters to it:
		Within the <activity> tags add:
			<!-- Tapjoy -->
			<activity android:name="com.tapjoy.TJCOffersWebView" android:configChanges="keyboardHidden|orientation" />
			<activity android:name="com.tapjoy.TapjoyFeaturedAppWebView" android:configChanges="keyboardHidden|orientation" />
	        <activity android:name="com.tapjoy.TapjoyVideoView" android:configChanges="keyboardHidden|orientation" />
	
		Also add these permissions:
			<!-- Tapjoy -->
			<uses-permission android:name="android.permission.INTERNET" />
			<uses-permission android:name="android.permission.READ_PHONE_STATE" />
			<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
		    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
		
  * In the Deploy Tool Advanced settings > External JAR file, make sure to include the file located at lib/android/s3eTapjoy.jar
  * Use the Deploy Tool to build an ARM project to deploy to an Android device.

Refer to the sample app included within for more details.



// This method is called to initialize the TapjoyConnect system. This method should be called upon app initialization and must not have logic to prevent it from being called in any case.
s3eResult TapjoyRequestConnect(const char* appID, const char* secretKey) S3E_RESULT_ERROR run_on_os_thread

// This is called when an action is completed. Actions are much like connects, except that this method is only called when a user completes an in-game action.
s3eResult TapjoyActionComplete(const char* actionID) S3E_RESULT_ERROR run_on_os_thread

// Sets the user ID. The user ID defaults to the UDID. This is only changed when NOT using Tapjoy Managed Currency.
s3eResult TapjoySetUserID(const char* userID) S3E_RESULT_ERROR run_on_os_thread

// Displays the offer wall.
s3eResult TapjoyShowOffers() S3E_RESULT_ERROR run_on_os_thread

s3eResult TapjoyShowOffersWithCurrenyID(const char* currencyID, s3eBool enableCurrencySelector) S3E_RESULT_ERROR run_on_os_thread

// Initiates a request to get a user's Tap Points (Tapjoy Managed currency).
s3eResult TapjoyGetTapPoints(TapjoyGetTapPointsCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Updates the Tap Points for the user with the given spent amount of currency. If the spent amount exceeds the current amount of currency the user has, nothing will happen.
s3eResult TapjoySpendTapPoints(int amount, TapjoySpendTapPointsCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Updates the Tap Points for the user with the given awarded amount of currency.
s3eResult TapjoyAwardTapPoints(int amount, TapjoyAwardTapPointsCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Not supported
//s3eResult TapjoyShowVirtualGoods() S3E_RESULT_ERROR run_on_os_thread
//
// Not supported
//TapjoyVGStoreItem* TapjoyGetPurchasedItem(int index) NULL run_on_os_thread
//
// Not supported
//TapjoyVGStoreItem* TapjoyGetAvailableItem(int index) NULL run_on_os_thread

// Initiates a request to get the full screen ad.
s3eResult TapjoyGetFeaturedApp(TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Shows a full screen full screen ad ad. This should be called after full screen ad data is retrieved from the server.
s3eResult TapjoyShowFeaturedAppFullScreenAd() S3E_RESULT_ERROR run_on_os_thread

// Sets the display count for full screen ad. The display count is separate for each unique full screen ad.
s3eResult TapjoySetFeaturedAppDisplayCount(int count) S3E_RESULT_ERROR run_on_os_thread

// Unavailable on Android
//s3eResult TapjoySetTransitionEffect(int transition) S3E_RESULT_ERROR run_on_os_thread
//
// Unavailable on Android
//s3eResult TapjoySetOffersNavBarImage(const char* pPNGFilename) S3E_RESULT_ERROR run_on_os_thread
//
// Unavailable on Android
//s3eResult TapjoySetUserDefinedColor(int your_color_in_0xAAARRGGBB_format) S3E_RESULT_ERROR run_on_os_thread

// adContentSize must be one of TJC_AD_BANNERSIZE_320X50 or TJC_AD_BANNERSIZE_480X32.
// Parameters are ignored on Android
s3eResult TapjoyGetDisplayAd(const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Set the pixel rectangle to display current advertisement, if downloaded
s3eResult TapjoySetDisplayAdView(int left, int top, int width, int height) S3E_RESULT_ERROR run_on_os_thread

// Initiates a request to get the full screen ad with a specified currencyID.
s3eResult TapjoyGetFeaturedAppWithCurrencyID(const char* currencyID, TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Initiates a request to get a Tapjoy banner ad with a specified currencyID.
s3eResult TapjoyGetDisplayAdWithCurrencyID(const char* currencyID, const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData) S3E_RESULT_ERROR run_on_os_thread

// Initializes video ads. It is recommended that this be called upon app start. No additional steps are needed to integrate video ads. 
// Caching automatically begins after this method is called and will automatically be displayed in the offer wall when it has finished caching onto the device.
s3eResult TapjoyInitVideoAd(TapjoyVideoStatusCallbackFn callbackFn) S3E_RESULT_ERROR run_on_os_thread

// Sets whether to enable caching for videos.  By default this is enabled.
s3eResult TapjoyEnableVideoCache(s3eBool enable) S3E_RESULT_ERROR run_on_os_thread

// Sets the number of videos to cache on the device. This value is 5 by default. Lower this value if there is heavy network dependent code running during the initialization of the application.
s3eResult TapjoySetVideoCacheCount(int count) S3E_RESULT_ERROR run_on_os_thread

// Enables a notifier which triggers whenever the user earns currency through Tapjoy.  // ANDROID ONLY
s3eResult TapjoySetEarnedTapPointsNotifier(TapjoyEarnedTapPointsCallbackFn callbackFn) S3E_RESULT_ERROR run_on_os_thread

// Updates the banner ad with a new one or disables auto-refresh.  // ANDROID ONLY
s3eResult TapjoyEnableBannerAdAutoRefresh(s3eBool shouldAutoRefresh) S3E_RESULT_ERROR run_on_os_thread

// Enables Tapjoy library logging to the console.  // ANDROID ONLY
s3eResult TapjoyEnableLogging(s3eBool enable) S3E_RESULT_ERROR run_on_os_thread

// Shows the banner ad.  // ANDROID ONLY
s3eResult TapjoyShowDisplayAd() S3E_RESULT_ERROR run_on_os_thread

// Hides the banner ad.  // ANDROID ONLY
s3eResult TapjoyHideDisplayAd() S3E_RESULT_ERROR run_on_os_thread
