// REPLACE_LICENSE_HEADER

/*
java implementation of the s3eTapjoy extension.

Add android-specific functionality here.

These functions are called via JNI from native code.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */
import com.ideaworks3d.marmalade.LoaderAPI;
import com.ideaworks3d.marmalade.LoaderActivity;

import android.app.Activity;
import android.view.View;
import android.content.Context;

import com.tapjoy.*;

// For banners.
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;

class s3eTapjoy implements TapjoyAwardPointsNotifier, TapjoyNotifier, TapjoySpendPointsNotifier, 
							TapjoyFeaturedAppNotifier, TapjoyDisplayAdNotifier, TapjoyEarnedPointsNotifier, TapjoyVideoNotifier
{
	public static LinearLayout linearLayout = null;
	
	public static View bannerView = null;
	int bannerX;
	int bannerY;
	boolean hideBanner;
	
	public static final int ERROR_NONE			= 0;
	public static final int ERROR_NETWORK_ERROR = 5000;
	public static final int ERROR_NO_CONTENT	= 5001;
	
	public int s3eTapjoyRegister()
	{
		return 0;
	}
	public int s3eTapjoyUnRegister()
	{
		return 0;
	}
	public int TapjoyEnableLogging(boolean enable)
	{
		TapjoyLog.enableLogging(enable);
		return 0;
	}
	public int TapjoyRequestConnect(String appID, String secretKey)
	{
		Context myContext = (Context) LoaderActivity.m_Activity;
		TapjoyConnect.requestTapjoyConnect(myContext, appID, secretKey);
		return 0;
	}
	public int TapjoyActionComplete(String actionID)
	{
		TapjoyConnect.getTapjoyConnectInstance().actionComplete(actionID);
		return 0;
	}
	public int TapjoySetUserID(String userID)
	{
		TapjoyConnect.getTapjoyConnectInstance().setUserID(userID);
		return 0;
	}
	public int TapjoyShowOffers()
	{
		TapjoyConnect.getTapjoyConnectInstance().showOffers();
		return 0;
	}
	public int TapjoyShowOffersWithCurrenyID(String currencyID, boolean enableCurrencySelector)
	{
		TapjoyConnect.getTapjoyConnectInstance().showOffersWithCurrencyID(currencyID, enableCurrencySelector);
		return 0;
	}
	public int TapjoyGetTapPoints()
	{
		TapjoyConnect.getTapjoyConnectInstance().getTapPoints(this);
		return 0;
	}
	public int TapjoySpendTapPoints(int amount)
	{
		TapjoyConnect.getTapjoyConnectInstance().spendTapPoints(amount, this);
		return 0;
	}
	public int TapjoyAwardTapPoints(int amount)
	{
		TapjoyConnect.getTapjoyConnectInstance().awardTapPoints(amount, this);
		return 0;
	}
	public int TapjoyShowVirtualGoods()
	{
		return 0;
	}
	public void TapjoyGetPurchasedItem(int index)
	{

	}
	public void TapjoyGetAvailableItem(int index)
	{

	}
	public int TapjoyGetFeaturedApp()
	{
		TapjoyConnect.getTapjoyConnectInstance().getFeaturedApp(this);
		return 0;
	}
	public int TapjoyGetFeaturedAppWithCurrencyID(String currencyID)
	{
		TapjoyConnect.getTapjoyConnectInstance().getFeaturedAppWithCurrencyID(currencyID, this);
		return 0;
	}
	public int TapjoyShowFeaturedAppFullScreenAd()
	{
		TapjoyConnect.getTapjoyConnectInstance().showFeaturedAppFullScreenAd();
		return 0;
	}
	public int TapjoySetFeaturedAppDisplayCount(int count)
	{
		TapjoyConnect.getTapjoyConnectInstance().setFeaturedAppDisplayCount(count);
		return 0;
	}
	public int TapjoySetTransitionEffect(int transition)
	{
		return 0;
	}
	public int TapjoySetOffersNavBarImage(String pPNGFilename)
	{
		return 0;
	}
	public int TapjoySetUserDefinedColor(int your_color_in_0xAAARRGGBB_format)
	{
		return 0;
	}
	public int TapjoyGetDisplayAd(String adContentSize, boolean shouldRefreshAd)
	{
		hideBanner = false;
		TapjoyConnect.getTapjoyConnectInstance().setBannerAdSize(adContentSize);
		TapjoyConnect.getTapjoyConnectInstance().enableBannerAdAutoRefresh(shouldRefreshAd);
		TapjoyConnect.getTapjoyConnectInstance().getDisplayAd(this);
		return 0;
	}
	public int TapjoyGetDisplayAdWithCurrencyID(String currencyID, String adContentSize, boolean shouldRefreshAd)
	{
		hideBanner = false;
		TapjoyConnect.getTapjoyConnectInstance().setBannerAdSize(adContentSize);
		TapjoyConnect.getTapjoyConnectInstance().enableBannerAdAutoRefresh(shouldRefreshAd);
		TapjoyConnect.getTapjoyConnectInstance().getDisplayAdWithCurrencyID(currencyID, this);
		return 0;
	}
	public int TapjoySetDisplayAdView(int left, int top, int width, int height)
	{
		bannerX = left;
		bannerY = top;
		
		if (!hideBanner)
			LoaderActivity.m_Activity.runOnUiThread(new UpdateBannerAd(bannerX, bannerY));
		return 0;
	}
	public int TapjoyShowDisplayAd()
	{
		hideBanner = false;
		LoaderActivity.m_Activity.runOnUiThread(new UpdateBannerAd(bannerX, bannerY));
		return 0;
	}
	public int TapjoyHideDisplayAd()
	{
		hideBanner = true;
		TapjoyConnect.getTapjoyConnectInstance().enableBannerAdAutoRefresh(false);
		
		LoaderActivity.m_Activity.runOnUiThread(new Runnable()
			{
				public void run() 
				{
					if (linearLayout != null)
					{
						linearLayout.removeAllViews();
					}
				}
			});		
		return 0;
	}
	public int TapjoySetEarnedTapPointsNotifier()
	{
		TapjoyConnect.getTapjoyConnectInstance().setEarnedPointsNotifier(this);
		return 0;
	}
	public int TapjoyInitVideoAd()
	{
		TapjoyConnect.getTapjoyConnectInstance().initVideoAd(this);
		return 0;
	}
	public int TapjoySetVideoCacheCount(int count)
	{
		TapjoyConnect.getTapjoyConnectInstance().setVideoCacheCount(count);
		return 0;
	}
	public int TapjoyEnableVideoCache(boolean enable)
	{
		TapjoyConnect.getTapjoyConnectInstance().enableVideoCache(enable);
		return 0;
	}
	public int TapjoyEnableBannerAdAutoRefresh(boolean enable)
	{
		TapjoyConnect.getTapjoyConnectInstance().enableBannerAdAutoRefresh(enable);
		return 0;
	}
	
	//================================================================================
	// CALLBACK Methods
	//================================================================================

	
	// This method must be implemented if using the TapjoyConnect.getTapPoints() method.
	// It is the callback method which contains the currency and points data.
	public void getUpdatePoints(String currencyName, int pointTotal)
	{
		TapjoyLog.i("TAJPJOY", "getUpdatePoints: " + pointTotal);
		GetTapPointsCallback(pointTotal, ERROR_NONE);
	}
	
	// This method must be implemented if using the TapjoyConnect.getTapPoints() method.
	// It is the callback method which contains the currency and points data.
	public void getUpdatePointsFailed(String error)
	{
		GetTapPointsCallback(0, ERROR_NETWORK_ERROR);
	}
	
	// Notifier for receiving the featured app data on a successful connect.
	public void getFeaturedAppResponse(TapjoyFeaturedAppObject featuredApObject)
	{
		TapjoyLog.i("TAJPJOY", "getFeaturedAppResponse");
		FeaturedAppCallback((TapjoyFeaturedAppObject)featuredApObject, ERROR_NONE);
	}

	// Notifier for when there is an error or no featured app to display.
	public void getFeaturedAppResponseFailed(String error)
	{
		FeaturedAppCallback(null, ERROR_NO_CONTENT);
	}

	// Notifier for when spending virtual currency succeeds.
	public void getSpendPointsResponse(String currencyName, int pointTotal)
	{
		TapjoyLog.i("TAJPJOY", "getSpendPointsResponse: " + pointTotal);
		SpendTapPointsCallback(pointTotal, ERROR_NONE);
	}

	// Notifier for when spending virtual currency fails.
	public void getSpendPointsResponseFailed(String error)
	{
		SpendTapPointsCallback(0, ERROR_NETWORK_ERROR);
	}

	public void getDisplayAdResponse(View view)
	{
		TapjoyLog.i("TAJPJOY", "getDisplayAdResponse");
		bannerView = view; 
		DisplayAdCallback(ERROR_NONE);
		
		LoaderActivity.m_Activity.runOnUiThread(new UpdateBannerAd(bannerX, bannerY));
	}

	public void getDisplayAdResponseFailed(String error)
	{
		DisplayAdCallback(ERROR_NO_CONTENT);
	}
	
	// Helper method to add/update the banner ad.
	private class UpdateBannerAd implements Runnable
	{
		int x;
		int y;
		
		public UpdateBannerAd(int banner_x, int banner_y)
		{
			x = banner_x;
			y = banner_y;
		}
		
		public void run()
		{
			try
			{
				Context myContext = (Context) LoaderActivity.m_Activity;
				
				// Get the screen size.
				WindowManager mW = (WindowManager)LoaderActivity.m_Activity.getSystemService(Context.WINDOW_SERVICE);
				int screenWidth = mW.getDefaultDisplay().getWidth();
				int screenHeight = mW.getDefaultDisplay().getHeight();
			
				//bannerView = TapjoyConnect.getTapjoyConnectInstance().getBannerAdView();
			
				// Null check.
				if (bannerView == null)
				{
					return;
				}
					
				int ad_width = bannerView.getLayoutParams().width;
				int ad_height = bannerView.getLayoutParams().height;
			
				// Resize banner if it's too big.
				if (screenWidth < ad_width)
				{
					// Using screen width, but substitute for the any width.
					int desired_width = screenWidth;
			
					// Resize banner to desired width and keep aspect ratio.
					LayoutParams layout = new LayoutParams(desired_width, (desired_width*ad_height)/ad_width);
					bannerView.setLayoutParams(layout);
				}
			
				if (linearLayout != null)
				{
					linearLayout.removeAllViews();
				}
			
				linearLayout = new LinearLayout(myContext);
				linearLayout.setLayoutParams(new ViewGroup.LayoutParams(screenWidth, screenHeight));
			
				// Use padding to set the x/y coordinates.
				linearLayout.setPadding(x, y, 0, 0);
				linearLayout.addView(bannerView);
			
				LoaderActivity.m_Activity.getWindow().addContentView(linearLayout, new ViewGroup.LayoutParams(screenWidth, screenHeight));
			}
			catch (Exception e)
			{
				Log.e("TapjoyPluginActivity", "exception adding banner: " + e.toString());
			}
		}
	}

	public void getAwardPointsResponse(String currencyName, int pointTotal)
	{
		TapjoyLog.i("TAJPJOY", "getAwardPointsResponse: " + pointTotal);
		AwardTapPointsCallback(pointTotal, ERROR_NONE);
	}

	public void getAwardPointsResponseFailed(String error)
	{
		AwardTapPointsCallback(0, ERROR_NETWORK_ERROR);
	}
	
	public void earnedTapPoints(int amount)
	{
		TapjoyLog.i("TAJPJOY", "earnedTapPoints: " + amount);
		EarnedTapPointsCallback(amount, ERROR_NONE);
	}
	
	public void videoReady()
	{
		// See s3eTapjoyVideoStatus for the codes, 0 = video ready
		VideoStatusCallback(0, ERROR_NONE);
	}

	public void videoError(int statusCode)
	{
		// See s3eTapjoyVideoStatus for the codes, 2 = start of error codes
		VideoStatusCallback(statusCode+1, ERROR_NONE);
	}

	public void videoComplete()
	{
		// See s3eTapjoyVideoStatus for the codes, 1 = video complete
		VideoStatusCallback(1, ERROR_NONE);
	}
	
	
	// AIRPLAY CALLBACK METHODS 
    public native void GetTapPointsCallback(int points, int error);
    public native void SpendTapPointsCallback(int points, int error);
    public native void AwardTapPointsCallback(int points, int error);
    public native void FeaturedAppCallback(Object featuredAppObject, int error);
	public native void EarnedTapPointsCallback(int points, int error);
	public native void VideoStatusCallback(int status, int error);
	public native void DisplayAdCallback(int error);
}
