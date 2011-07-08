package com.tapjoy;

import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;

import org.w3c.dom.Document;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
//import android.os.AsyncTask;
import android.telephony.TelephonyManager;
import android.util.DisplayMetrics;
import android.view.WindowManager;

public class TapjoyConnectCore
{
	private static Context context = null;
	
	private static TapjoyConnectCore tapjoyConnectCore = null;
	private static TapjoyURLConnection tapjoyURLConnection = null;
	
	// URL parameter variables.
	private static String deviceID = "";												// Device ID (IMEI/MEID).
	private static String deviceModel = "";												// Device type/model.
	private static String devicePlatform = "";											// Platform (iPhone, Android, etc).
	private static String deviceOSVersion = "";											// Android OS version.
	private static String deviceCountryCode = "";										// Default country code for this device.
	private static String deviceLanguage = "";											// Default language for this device.
	private static String appID = "";													// App ID.
	private static String appVersion = "";												// App version.
	private static String libraryVersion = "";											// Tapjoy Library version.
	private static String deviceScreenDensity = "";										// Screen density.
	private static String deviceScreenLayoutSize = "";									// Screen size.
	private static String userID = "";													// Publisher defined userID for this device.
	
	private static String secretKey= "";												// Secret key.
	private static String clientPackage = "";											// App package name.	
	private String referralURL = "";													// Referral parameter (format is "referrer=com.package.name")
	
	public static final String TAPJOY_CONNECT 										= "TapjoyConnect";
	
	// Pay Per Action related.
	private String actionURLParams = "";												// URL parameters for pay-per-action.
	
	// PAID APP
	private static String paidAppActionID = null;										// Pay-Per-Action ID for the paid app.
	private long elapsed_time = 0;
	private Timer timer = null;
	
	
	/**
	 * Returns the singleton instance of this class.
	 * @return								Singleton instance of this class.
	 */
	public static TapjoyConnectCore getInstance()
	{
		return tapjoyConnectCore;
	}
	
	
	/**
	 * Connects to the Tapjoy server and sends the Tapjoy Connect call.
	 * @param applicationContext			The application context.
	 * @param app_ID						The Tapjoy APP ID for this app.
	 * @param secret_Key					The Tapjoy SECRET KEY for this app.
	 */
	public static void requestTapjoyConnect(Context applicationContext, String app_ID, String secret_Key)
	{
		appID = app_ID;
		secretKey = secret_Key;
		tapjoyConnectCore = new TapjoyConnectCore(applicationContext);
	}
	
	
	/**
	 * Constructor.
	 * @param applicationContext			The application context.
	 */
	public TapjoyConnectCore(Context applicationContext)
	{
		context = applicationContext;
		tapjoyURLConnection = new TapjoyURLConnection();
		
		init();
		
		TapjoyLog.i(TAPJOY_CONNECT, "URL parameters: " + getURLParams());
		
//		ConnectTask connectTask = new ConnectTask();
//		connectTask.execute();
		
		new Thread(new Runnable() 
		{
			public void run() 
			{
				TapjoyLog.i(TAPJOY_CONNECT, "starting connect call...");
				
				String connectURLParams = getURLParams();
				
				// The referralURL contains both referrer parameter and its value e.g. referralURL="referrer=com.tapjoy.tapX"
		        if (!referralURL.equals(""))
		        {
		            // Pass referral parameters to connect call to Tapjoy server
		        	connectURLParams += "&" + referralURL;
		        }
				
				// Get the result of the http request.
				String result = tapjoyURLConnection.connectToURL(TapjoyConstants.TJC_SERVICE_URL + TapjoyConstants.TJC_CONNECT_URL_PATH, connectURLParams);
				
				// Handle the response for a connect call.
				if (result != null)
					handleConnectResponse(result);
			}
		}).start();
	}
	
	
	/**
	 * Constructs the generic URL parameters for the connect call.  Includes the verifier/timestamp parameter.
	 * Does NOT include:
	 *  	publisher_user_id				(publisher user ID)
	 *  	referrer						(for referral tracking)
	 * @return								Generic URL parameters used in the connect call.
	 */
	public static String getURLParams()
	{
		String urlParams = getGenericURLParams() + "&";
		String verifier = "";
		
		// Convert to seconds.
		long time = System.currentTimeMillis()/1000;
		verifier = getVerifier(time);
		
		urlParams += TapjoyConstants.TJC_TIMESTAMP + "=" + time + "&";
		urlParams += TapjoyConstants.TJC_VERIFIER + "=" + verifier;
		
		return urlParams;
	}
	
	
	/**
	 * Constructs the generic URL parameters.
	 * Does NOT include:
	 *  	publisher_user_id				(publisher user ID)
	 *  	referrer						(for referral tracking)
	 *  	verifier/timestamp
	 * @return								Generic URL parameters used in the connect call.
	 */
	public static String getGenericURLParams()
	{
		String urlParams = "";
		
		// Construct the url parameters.
		urlParams += TapjoyConstants.TJC_DEVICE_ID_NAME + "=" + deviceID + "&";
		urlParams += TapjoyConstants.TJC_DEVICE_NAME + "=" + deviceModel + "&";
		urlParams += TapjoyConstants.TJC_DEVICE_TYPE_NAME + "=" + devicePlatform + "&";
		urlParams += TapjoyConstants.TJC_DEVICE_OS_VERSION_NAME + "=" + deviceOSVersion + "&";
		urlParams += TapjoyConstants.TJC_DEVICE_COUNTRY_CODE + "=" + deviceCountryCode + "&";
		urlParams += TapjoyConstants.TJC_DEVICE_LANGUAGE + "=" + deviceLanguage + "&";
		urlParams += TapjoyConstants.TJC_APP_ID_NAME + "=" + appID + "&";
		urlParams += TapjoyConstants.TJC_APP_VERSION_NAME + "=" + appVersion + "&";
		urlParams += TapjoyConstants.TJC_CONNECT_LIBRARY_VERSION_NAME + "=" + libraryVersion;
		
		// Add device density and screen layout size.
		if (deviceScreenDensity.length() > 0 && deviceScreenLayoutSize.length() > 0)
		{
			urlParams += "&";
			urlParams += TapjoyConstants.TJC_DEVICE_SCREEN_DENSITY + "=" + deviceScreenDensity + "&";		
			urlParams += TapjoyConstants.TJC_DEVICE_SCREEN_LAYOUT_SIZE + "=" + deviceScreenLayoutSize;
		}
		
		return urlParams;
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
		TapjoyLog.i(TAPJOY_CONNECT, "enablePaidAppWithActionID: " + paidAppPayPerActionID);
		
		paidAppActionID = paidAppPayPerActionID;
		
		SharedPreferences prefs = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0);
		
		// Load the stored elapsed time from the prefs.
		elapsed_time = prefs.getLong(TapjoyConstants.PREF_ELAPSED_TIME, 0);
		
		TapjoyLog.i(TAPJOY_CONNECT, "paidApp elapsed: " + elapsed_time);
		
		// If elapsed time is enough, then call the paid app PPA.
		if (elapsed_time >= TapjoyConstants.PAID_APP_TIME)
		{
			// If there is a valid paid app action ID, then trigger the PPA.
			if (paidAppActionID != null && paidAppActionID.length() > 0)
			{
				TapjoyLog.i(TAPJOY_CONNECT, "Calling PPA actionComplete...");
				
				actionComplete(paidAppActionID);
			}
		}
		else
		// Only have 1 timer running at a time.
		if (timer == null)
		{
			timer = new Timer();
			timer.schedule(new PaidAppTimerTask(), TapjoyConstants.TIMER_INCREMENT, TapjoyConstants.TIMER_INCREMENT);
		}
	}
	
	
	/**
	 * Initialize data from the device information and application info.
	 * This data is used in our URL connection to the Tapjoy server. 
	 */
	private void init()
	{
		PackageManager manager = context.getPackageManager();
		
		try 
		{
			
			// Get app version.
			PackageInfo packageInfo = manager.getPackageInfo(context.getPackageName(), 0);
			appVersion = packageInfo.versionName;
			
			// Device platform.
			devicePlatform = TapjoyConstants.TJC_DEVICE_PLATFORM_TYPE;
			
			// Get the device model.
			deviceModel = android.os.Build.MODEL;
			
			// Get the Android OS Version.
			deviceOSVersion = android.os.Build.VERSION.RELEASE;
			
			// Get the device country and language code.
			deviceCountryCode = Locale.getDefault().getCountry();
			deviceLanguage = Locale.getDefault().getLanguage();
			
			// Tapjoy SDK Library version.
			libraryVersion = TapjoyConstants.TJC_LIBRARY_VERSION_NUMBER;
			
			SharedPreferences settings = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0);
			
			try
			{
				TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
				
				if (telephonyManager != null)
				{
					deviceID = telephonyManager.getDeviceId();
				}
				
				TapjoyLog.i(TAPJOY_CONNECT, "deviceID: " + deviceID);
				
				boolean invalidDeviceID = false;
				
				//----------------------------------------
				// Is the device ID null or empty?
				//----------------------------------------
				if (deviceID == null)
				{
					TapjoyLog.e(TAPJOY_CONNECT, "Device id is null.");
					invalidDeviceID = true;
				}
				else
				//----------------------------------------
				// Is this an emulator device ID?
				//----------------------------------------
				if (deviceID.length() == 0 || deviceID.equals("000000000000000") || deviceID.equals("0"))
				{
					TapjoyLog.e(TAPJOY_CONNECT, "Device id is empty or an emulator.");
					invalidDeviceID = true;
				}
				//----------------------------------------
				// Valid device ID.
				//----------------------------------------
				else
				{
					// Lower case the device ID.
					deviceID = deviceID.toLowerCase();
				}
				
				// Is the device ID invalid?  This is probably an emulator or pre-production device.
				if (invalidDeviceID)
				{
					StringBuffer buff = new StringBuffer();
					buff.append("EMULATOR");
					String deviceId = settings.getString(TapjoyConstants.PREF_EMULATOR_DEVICE_ID, null);
					
					// Do we already have an emulator device id stored for this device?
					if( deviceId != null && !deviceId.equals(""))
					{
						deviceID = deviceId;
					}
					// Otherwise generate a deviceID for emulator testing.
					else
					{
						String constantChars = "1234567890abcdefghijklmnopqrstuvw";
						
						for (int i = 0; i < 32; i++)
						{
							int randomChar = (int) ( Math.random()* 100) ;
							int ch = randomChar % 30;
							buff.append(constantChars.charAt(ch));
						}
						
						deviceID = buff.toString().toLowerCase();
						
						// Save the emulator device ID in the prefs so we can reuse it.
						SharedPreferences.Editor editor = settings.edit();
						editor.putString(TapjoyConstants.PREF_EMULATOR_DEVICE_ID, deviceID);
						editor.commit();
					}
				}
			}
			catch(Exception e)
			{
				TapjoyLog.e(TAPJOY_CONNECT, "Error getting deviceID. e: " + e.toString());
				deviceID = null;
			}
			
			// Set the userID to the deviceID as the initial value.
			if (userID.length() == 0)
				userID = deviceID;
			
			// Get screen density, dimensions and layout.
			try
			{
				DisplayMetrics metrics = new DisplayMetrics();
				WindowManager windowManager = (WindowManager)context.getSystemService(Context.WINDOW_SERVICE);
				windowManager.getDefaultDisplay().getMetrics(metrics);
				
				//TapjoyLog.i(TAPJOY_CONNECT, "screen_dimensions: " + metrics.widthPixels + "x" + metrics.heightPixels);
				
				Configuration configuration = context.getResources().getConfiguration();
				
				deviceScreenDensity = "" + metrics.densityDpi;
				deviceScreenLayoutSize = "" + (configuration.screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK);
			}
			catch (Exception e)
			{
				TapjoyLog.e(TAPJOY_CONNECT, "Error getting screen density/dimensions/layout: " + e.toString());
			}
			
			// Get the referral URL
			String tempReferralURL = settings.getString(TapjoyConstants.PREF_REFERRAL_URL, null);
			if (tempReferralURL != null && !tempReferralURL.equals(""))
				referralURL = tempReferralURL;
			
			// Get the client package name.
			clientPackage = context.getPackageName();
			
			TapjoyLog.i(TAPJOY_CONNECT, "Metadata successfully loaded");
			
			TapjoyLog.i(TAPJOY_CONNECT, "APP_ID = [" + appID + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "CLIENT_PACKAGE = [" + clientPackage + "]");
			
			TapjoyLog.i(TAPJOY_CONNECT, "deviceID: [" + deviceID + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "deviceName: [" + deviceModel + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "deviceType: [" + devicePlatform + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "libraryVersion: [" + libraryVersion + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "deviceOSVersion: [" + deviceOSVersion + "]");
			
			TapjoyLog.i(TAPJOY_CONNECT, "COUNTRY_CODE: [" + deviceCountryCode + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "LANGUAGE_CODE: [" + deviceLanguage + "]");
			
			TapjoyLog.i(TAPJOY_CONNECT, "density: [" + deviceScreenDensity + "]");
			TapjoyLog.i(TAPJOY_CONNECT, "screen_layout: [" + deviceScreenLayoutSize + "]");
			
			TapjoyLog.i(TAPJOY_CONNECT, "referralURL: [" + referralURL + "]");
			
			//TapjoyLog.i(TAPJOY_CONNECT, "primaryColor: [" + Integer.toHexString(primaryColor) + "]");

		}
		catch (Exception e) 
		{
			TapjoyLog.e(TAPJOY_CONNECT, "Error initializing Tapjoy parameters.");
		}
	}

	
	/**
	 * Helper class to perform the connect call in the background.
	 */
//	private class ConnectTask extends AsyncTask<Void, Void, Boolean>
//	{
//		@Override
//		protected Boolean doInBackground(Void... params)
//		{
//			TapjoyLog.e(TAPJOY_CONNECT, "starting connect call...");
//			
//			boolean returnValue = false;
//			
//			String connectURLParams = getURLParams();
//			
//			// The referralURL contains both referrer parameter and its value e.g. referralURL="referrer=com.tapjoy.tapX"
//	        if (!referralURL.equals(""))
//	        {
//	            // Pass referral parameters to connect call to Tapjoy server
//	        	connectURLParams += "&" + referralURL;
//	        }
//			
//			// Get the result of the http request.
//			String result = tapjoyURLConnection.connectToURL(TapjoyConstants.TJC_SERVICE_URL + TapjoyConstants.TJC_CONNECT_URL_PATH, connectURLParams);
//			
//			// Handle the response for a connect call.
//			if (result != null)
//				returnValue = handleConnectResponse(result);
//			
//			return returnValue;
//		}
//	}
	
	
	/**
	 * Helper class to perform the Pay-Per-Action completed call in the background.
	 */
//	private class PayPerActionTask extends AsyncTask<Void, Void, Boolean>
//	{
//		@Override
//		protected Boolean doInBackground(Void... params)
//		{
//			boolean returnValue = false;
//			
//			// Get the result of the http request.
//			String result = tapjoyURLConnection.connectToURL(TapjoyConstants.TJC_SERVICE_URL + TapjoyConstants.TJC_CONNECT_URL_PATH, actionURLParams);
//			
//			// Handle the response for a connect call.
//			if (result != null)
//				returnValue = handlePayPerActionResponse(result);
//			
//			return returnValue;
//		}
//	}
	
	
	/**
	 * Timer which executes the actionComplete with paid app actionID once completed.
	 */
	private class PaidAppTimerTask extends TimerTask
	{
		public void run()
		{
			elapsed_time += TapjoyConstants.TIMER_INCREMENT;

			TapjoyLog.i(TAPJOY_CONNECT, "elapsed_time: " + elapsed_time + " (" + elapsed_time / 1000 / 60 + "m " + (elapsed_time / 1000 % 60) + "s)");

			SharedPreferences prefs = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0);
			SharedPreferences.Editor editor = prefs.edit();
			editor.putLong(TapjoyConstants.PREF_ELAPSED_TIME, elapsed_time);
			editor.commit();

			// Have 15 minutes passed?
			if (elapsed_time >= TapjoyConstants.PAID_APP_TIME)
			{
				TapjoyLog.i(TAPJOY_CONNECT, "timer done...");

				// If there is a valid paid app action ID, then trigger the PPA.
				if (paidAppActionID != null && paidAppActionID.length() > 0)
				{
					TapjoyLog.i(TAPJOY_CONNECT, "Calling PPA actionComplete...");

					actionComplete(paidAppActionID);
				}

				cancel();
			}
		}
	}
	
	
	/**
	 * Handles the response from calling Connect.
	 * @param response					HTTP response from the server.
	 * @return							TRUE if the response is handled and notifier has been called, FALSE otherwise.
	 */
	private boolean handleConnectResponse(String response)
	{
		// Create a document so we can parse the XML easily.
		Document document = TapjoyUtil.buildDocument(response);
		
		if (document != null)
		{
			String nodeValue = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Success"));
			
			// The Tapjoy Connect call was successful.
			if (nodeValue != null && nodeValue.equals("true"))
			{
				TapjoyLog.i(TAPJOY_CONNECT, "Successfully connected to tapjoy site.");
				return true;
			}
			else
			{
				TapjoyLog.e(TAPJOY_CONNECT, "Tapjoy Connect call failed.");
			}
		}
		
		return false;
	}
	
	
	/**
	 * Handles the response from a completed Pay-Per-Action.
	 * @param response					HTTP response from the server.
	 * @return							TRUE if the response is handled and notifier has been called, FALSE otherwise.
	 */
	private boolean handlePayPerActionResponse(String response)
	{
		// Create a document so we can parse the XML easily.
		Document document = TapjoyUtil.buildDocument(response);
		
		if (document != null)
		{
			String nodeValue = TapjoyUtil.getNodeTrimValue(document.getElementsByTagName("Success"));
			
			// The Tapjoy Connect call was successful.
			if (nodeValue != null && nodeValue.equals("true"))
			{
				TapjoyLog.i(TAPJOY_CONNECT, "Successfully sent completed Pay-Per-Action to Tapjoy server.");
				return true;
			}
			else
			{
				TapjoyLog.e(TAPJOY_CONNECT, "Completed Pay-Per-Action call failed.");
			}
		}
		
		return false;
	}

	
	/**
	 * Releases the TapjoyConnectInstance object. This must be called whenever the application exits.
	 */
	public void release()
	{
		tapjoyConnectCore = null;
		tapjoyURLConnection = null;
		
		TapjoyLog.i(TAPJOY_CONNECT, "Releasing core static instance.");
	}
	

	//================================================================================
	// HELPER Methods
	//================================================================================
	
	
	/**
	 * Gets the Tapjoy App ID.
	 * @return								The Tapjoy App ID.
	 */
	public static String getAppID()
	{
		return appID;
	}
	
	
	/**
	 * Gets the unique identifier for this device.
	 * @return								The device ID.
	 */
	public static String getDeviceID()
	{
		return deviceID;
	}
	
	
	/**
	 * Gets the user ID for this device.
	 * @return								The user ID for this device.
	 */
	public static String getUserID()
	{
		return userID;
	}
	
	
	/**
	 * Gets the app package name.
	 * @return								The app package name.
	 */
	public static String getClientPackage()
	{
		return clientPackage;
	}
	
	
	/**
	 * Gets The application context.
	 * @return								The application context.
	 */
	public static Context getContext()
	{
		return context;
	}
	
	
	/**
	 * Returns the verifier hash.
	 * The format is:
	 * appID:deviceID:timestamp:secretKey
	 * @param time							Time in seconds since 1/1/1970
	 * @return								The verifier hash.
	 */
	public static String getVerifier(long time)
	{
		String verifier = "";
		
		try
		{
			// Verifier format:
			// "app_id:device_id:time_stamp:secret_key"
			verifier = TapjoyUtil.SHA256(appID + ":" + deviceID + ":" + time + ":" + secretKey);
		}
		catch (Exception e)
		{
			TapjoyLog.e(TAPJOY_CONNECT, "getVerifier ERROR: " + e.toString());
		}
		
		return verifier;
	}
	
	
	/**
	 * Returns the verifier hash for awardTapPoints
	 * The format is:
	 * appID:deviceID:timestamp:secretKey:amount:guid
	 * @param time							Time in seconds since 1/1/1970
	 * @return								The verifier hash.
	 */
	public static String getAwardPointsVerifier(long time, int amount, String guid)
	{
		String verifier = "";
		
		try
		{
			// Verifier format:
			// "app_id:device_id:time_stamp:secret_key:tap_points:guid"
			verifier = TapjoyUtil.SHA256(appID + ":" + deviceID + ":" + time + ":" + secretKey + ":" + amount + ":" + guid);
		}
		catch (Exception e)
		{
			TapjoyLog.e(TAPJOY_CONNECT, "getAwardPointsVerifier ERROR: " + e.toString());
		}
		
		return verifier;
	}
	
	
	/**
	 * Sets the user ID for this device.  This is used by the publisher to identify the user for their app.
	 * This needs to be called before any call to Offers, Featured App, etc.
	 * If this method is not called, the device ID will be used by default.
	 * @param id							User ID which is used to identify this user for this device.
	 */
	public static void setUserID(String id)
	{
		userID = id;
	}
	
	
	/**
	 * Sets the device ID for debugging purposes.  This only works when the deviceID is invalid for this device (simulator/emulator).
	 * @param id							String to use as the deviceID.
	 */
	public static void setDebugDeviceID(String id)
	{
		deviceID = id;
		
		SharedPreferences settings = context.getSharedPreferences(TapjoyConstants.TJC_PREFERENCE, 0);
		
		// Save the emulator device ID in the prefs so we can reuse it.
		SharedPreferences.Editor editor = settings.edit();
		editor.putString(TapjoyConstants.PREF_EMULATOR_DEVICE_ID, deviceID);
		editor.commit();
	}
	
	
	//================================================================================
	// PAY-PER-ACTION Methods
	//================================================================================
	
	
	/**
	 * Informs the Tapjoy server that the specified Pay-Per-Action was completed. 
	 * @param actionID				The action ID of the completed action.
	 */
	public void actionComplete(String actionID)
	{
		// The PPA call is identical to Connect except the PPA ID is passed as the app_id parameter.
		actionURLParams = "";
		
		// Construct the url parameters.
		actionURLParams += TapjoyConstants.TJC_DEVICE_ID_NAME + "=" + deviceID + "&";
		actionURLParams += TapjoyConstants.TJC_DEVICE_NAME + "=" + deviceModel + "&";
		actionURLParams += TapjoyConstants.TJC_DEVICE_TYPE_NAME + "=" + devicePlatform + "&";
		actionURLParams += TapjoyConstants.TJC_DEVICE_OS_VERSION_NAME + "=" + deviceOSVersion + "&";
		actionURLParams += TapjoyConstants.TJC_DEVICE_COUNTRY_CODE + "=" + deviceCountryCode + "&";
		actionURLParams += TapjoyConstants.TJC_DEVICE_LANGUAGE + "=" + deviceLanguage + "&";
		
		// Use Action ID instead of app ID here.
		actionURLParams += TapjoyConstants.TJC_APP_ID_NAME + "=" + actionID + "&";
		
		actionURLParams += TapjoyConstants.TJC_APP_VERSION_NAME + "=" + appVersion + "&";
		actionURLParams += TapjoyConstants.TJC_CONNECT_LIBRARY_VERSION_NAME + "=" + libraryVersion;
		
		// Add device density and screen layout size.
		if (deviceScreenDensity.length() > 0 && deviceScreenLayoutSize.length() > 0)
		{
			actionURLParams += "&";
			actionURLParams += TapjoyConstants.TJC_DEVICE_SCREEN_DENSITY + "=" + deviceScreenDensity + "&";		
			actionURLParams += TapjoyConstants.TJC_DEVICE_SCREEN_LAYOUT_SIZE + "=" + deviceScreenLayoutSize;
		}
		
		// Add verifier.
		actionURLParams += "&";
		
		// Convert to seconds.
		long time = System.currentTimeMillis()/1000;		
		actionURLParams += TapjoyConstants.TJC_TIMESTAMP + "=" + time + "&";
		actionURLParams += TapjoyConstants.TJC_VERIFIER + "=" + getVerifier(time);
		
		TapjoyLog.i(TAPJOY_CONNECT, "PPA URL parameters: " + actionURLParams);
		
//		PayPerActionTask payPerActionTask = new PayPerActionTask();
//		payPerActionTask.execute();
		
		new Thread(new Runnable() 
		{
			public void run() 
			{
				// Get the result of the http request.
				String result = tapjoyURLConnection.connectToURL(TapjoyConstants.TJC_SERVICE_URL + TapjoyConstants.TJC_CONNECT_URL_PATH, actionURLParams);
				
				// Handle the response for a connect call.
				if (result != null)
					handlePayPerActionResponse(result);
			}
		}).start();
	}
}
