package com.tapjoy;

import android.content.Context;


/**
 * Created by Tapjoy.
 * Copyright 2010 Tapjoy.com All rights reserved.
 * 
 * For information about SDK integration, best practices and FAQs, please go to <a href="http://knowledge.tapjoy.com">http://knowledge.tapjoy.com </a>
 */


public final class TapjoyConnect
{ 
	private static TapjoyConnect tapjoyConnectInstance = null;
	public static final String TAPJOY_CONNECT 										= "TapjoyConnect";
	
	// Offers related.
	private static TJCOffers tapjoyOffers = null;
	private static TapjoyFeaturedApp tapjoyFeaturedApp = null;
	private static TapjoyDisplayAd tapjoyDisplayAd = null;
	
	
	/**
	 * Performs the Tapjoy Connect call to the Tapjoy server to notify it that
	 * this device is running your application.
	 * 
	 * This method should be called in the onCreate() method of your first activity
	 * and before any other TapjoyConnect methods.
	 * @param context						The Application context.
	 * @param appID							Your Tapjoy APP ID.
	 * @param secretKey						Your Tapjoy SECRET KEY.
	 */
	public static void requestTapjoyConnect(Context context, String appID, String secretKey)
	{
		tapjoyConnectInstance = new TapjoyConnect(context, appID, secretKey);
		tapjoyOffers = new TJCOffers(context);
		tapjoyFeaturedApp = new TapjoyFeaturedApp(context);
		tapjoyDisplayAd = new TapjoyDisplayAd(context);
	}
	
	
	/**
	 * Returns the singleton instance of TapjoyConnect.
	 * @return 								Singleton instance of TapjoyConnect.
	 */
	public static TapjoyConnect getTapjoyConnectInstance()
	{
		if (tapjoyConnectInstance == null)
		{
			android.util.Log.e(TAPJOY_CONNECT, "----------------------------------------");
			android.util.Log.e(TAPJOY_CONNECT, "ERROR -- call requestTapjoyConnect before any other Tapjoy methods");
			android.util.Log.e(TAPJOY_CONNECT, "----------------------------------------");
		}
		
		return tapjoyConnectInstance;
	}
	
	
	/**
	 * Performs the Tapjoy Connect call to the Tapjoy server to notify it that
	 * this device is running your application.
	 * @param context						The application context.
	 * @param appID							Your Tapjoy APP ID.
	 * @param secretKey						Your Tapjoy SECRET KEY.
	 */
	private TapjoyConnect(Context context, String appID, String secretKey)
	{
		TapjoyConnectCore.requestTapjoyConnect(context, appID, secretKey);
	}
	
	
	/**
	 * Assigns a user ID for this user/device.  This is used to identify the user
	 * in your application.  The default user ID is the device id.
	 * @param userID						User ID you wish to assign to this device.
	 */
	public void setUserID(String userID)
	{
		TapjoyConnectCore.setUserID(userID);
	}
	
	
	/**
	 * Gets the user ID assigned to this device.  By default, this is the device ID.
	 * @return								User ID assigned to this device.
	 */
	public String getUserID()
	{
		return TapjoyConnectCore.getUserID();
	}
	
	
	/**
	 * Gets the Tapjoy App ID used to identify app.
	 * @return								Tapjoy App ID used to identify app.
	 */
	public String getAppID()
	{
		return TapjoyConnectCore.getAppID();
	}
	
	
	/**
	 * ONLY USE FOR PAID APP INSTALLS.<br>
	 * This method should be called in the onCreate() method of your first activity after calling
	 * {@link #requestTapjoyConnect(Context context, String appID, String secretKey)}.<br>
	 * Must enable a paid app Pay-Per-Action on the Tapjoy dashboard.
	 * Starts a 15 minute timer.  After which, will send an actionComplete call with the paid app PPA to
	 * inform the Tapjoy server that the paid install PPA has been completed.
	 * @param paidAppPayPerActionID			The Pay-Per-Action ID for this paid app download action. 
	 */
	public void enablePaidAppWithActionID(String paidAppPayPerActionID)
	{
		TapjoyConnectCore.getInstance().enablePaidAppWithActionID(paidAppPayPerActionID);
	}
	

	//================================================================================
	// PAY-PER-ACTION Methods
	//================================================================================
	
	
	/**
	 * Informs the Tapjoy server that the specified Pay-Per-Action was completed.  Should
	 * be called whenever a user completes an in-game action.
	 * @param actionID				The action ID of the completed action.
	 */
	public void actionComplete(String actionID)
	{
		TapjoyConnectCore.getInstance().actionComplete(actionID);
	}
	
	
	//================================================================================
	// OFFERS Methods
	//================================================================================
	/**
	 * Show available offers to the user.
	 */
	public void showOffers()
	{
		tapjoyOffers.showOffers();
	}
	
	
	/**
	 * Show available offers using a currencyID and currency selector flag.  
	 * This method should only be used if the application supports multiple currencies.
	 * Apps that support multiple currencies cannot be managed by Tapjoy.
	 * @param currencyID				ID of the currency to display.
	 * @param enableCurrencySelector	Whether to display the currency selector to toggle currency.
	 */
	public void showOffersWithCurrencyID(String currencyID, boolean enableCurrencySelector)
	{
		tapjoyOffers.showOffersWithCurrencyID(currencyID, enableCurrencySelector);
	}
	
	
	/**
	 * Gets the virtual currency data from the server for this device.
	 * The data will be returned in a callback to updatePoints() to the class implementing the notifier.
	 * @param notifier The class implementing the TapjoyNotifier callback.
	 */
	public void getTapPoints(TapjoyNotifier notifier)
	{
		tapjoyOffers.getTapPoints(notifier);
	}
	

	/**
	 * Spends virtual currency.  This can only be used for currency managed by Tapjoy.
	 * The data will be returned in a callback to updatePoints() to the class implementing the notifier.
	 * @param notifier The class implementing the TapjoySpendPointsNotifier callback.
	 */
	public void spendTapPoints(int amount, TapjoySpendPointsNotifier notifier)
	{
		tapjoyOffers.spendTapPoints(amount, notifier);
	}
	
	
	/**
	 * Awards virtual currency.  This can only be used for currency managed by Tapjoy.
	 * The data will be returned in a callback to getAwardPointsResponse() to the class implementing the notifier.
	 * @param notifier The class implementing the TapjoyAwardPointsNotifier callback.
	 */
	public void awardTapPoints(int amount, TapjoyAwardPointsNotifier notifier)
	{
		tapjoyOffers.awardTapPoints(amount, notifier);
	}
	
	
	//================================================================================
	// FEATURED APP Methods
	//================================================================================
	
	
	/**
	 * Retrieves the Featured App data from the server.
	 * Data is returned to the callback method TapjoyFeaturedAppNotifier.getFeaturedAppResponse().
	 * @param notifier				Class implementing TapjoyFeaturedAppNotifier for the Featured App data callback.
	 */
	public void getFeaturedApp(TapjoyFeaturedAppNotifier notifier)
	{
		tapjoyFeaturedApp.getFeaturedApp(notifier);
	}
	
	
	/**
	 * Retrieves the Featured App data from the server.
	 * Data is returned to the callback method TapjoyFeaturedAppNotifier.getFeaturedAppResponse().
	 * This should only be used if the application supports multiple currencies.
	 * @param currencyID			ID of the currency to award.
	 * @param notifier				Class implementing TapjoyFeaturedAppNotifier for the Featured App data callback.
	 */
	public void getFeaturedAppWithCurrencyID(String currencyID, TapjoyFeaturedAppNotifier notifier)
	{
		tapjoyFeaturedApp.getFeaturedApp(currencyID, notifier);
	}
	
	
	/**
	 * Sets the maximum number of times the same featured app should be displayed.
	 * @param count					The maximum number of times to display a featured app.
	 */
	public void setFeaturedAppDisplayCount(int count)
	{
		tapjoyFeaturedApp.setDisplayCount(count);
	}
	
	
	/**
	 * Displays the Featured App fullscreen ad.
	 * Should be called after getFeaturedApp() and after receiving the TapjoyFeaturedAppNotifier.getFeaturedAppResponse callback. 
	 */
	public void showFeaturedAppFullScreenAd()
	{
		tapjoyFeaturedApp.showFeaturedAppFullScreenAd();
	}
	
	
	//================================================================================
	// DISPLAY AD Methods
	//================================================================================
	
	
	/**
	 * Sets the size (dimensions) of the banner ad.  By default this is 320x50.<br>
	 * Supported sizes are:<br>
	 * {@link TapjoyDisplayAdSize#TJC_AD_BANNERSIZE_320X50}<br>
	 * {@link TapjoyDisplayAdSize#TJC_AD_BANNERSIZE_640X100}<br>
	 * {@link TapjoyDisplayAdSize#TJC_AD_BANNERSIZE_768X90}<br>
	 * @param dimensions			Dimensions of the banner.
	 */
	public void setBannerAdSize(String dimensions)
	{
		tapjoyDisplayAd.setBannerAdSize(dimensions);
	}
	
	
	/**
	 * Retrieves the Display Ad data from the server.
	 * Data is returned to the callback method TapjoyFeaturedAppNotifier.getFeaturedAppResponse().
	 * @param notifier				Class implementing TapjoyFeaturedAppNotifier for the Featured App data callback.
	 */
	public void getDisplayAd(TapjoyDisplayAdNotifier notifier)
	{
		tapjoyDisplayAd.getDisplayAd(notifier);
	}
}
