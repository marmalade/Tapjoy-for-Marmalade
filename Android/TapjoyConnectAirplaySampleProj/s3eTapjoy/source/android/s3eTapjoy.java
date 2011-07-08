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

class s3eTapjoy implements TapjoyAwardPointsNotifier, TapjoyNotifier, TapjoySpendPointsNotifier, TapjoyFeaturedAppNotifier, TapjoyDisplayAdNotifier
{
    public int s3eTapjoyRegister()
    {
        return 0;
    }
    public int s3eTapjoyUnRegister()
    {
        return 0;
    }
    public int TapjoyRequestConnect(String appID, String secretKey)
    {
        //TapjoyLog.enableLogging(true);

        Context myContext = (Context) LoaderActivity  .m_Activity;
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
//        TapjoyConnect.getTapjoyConnectInstance().setBannerAdSize(adContentSize);
//        TapjoyConnect.getTapjoyConnectInstance().getDisplayAd(this);
        return 0;
    }
    public int TapjoySetDisplayAdView(int left, int top, int width, int height)
    {
//        TapjoyConnect.getTapjoyConnectInstance().setDisplayAdView(left, top, width, height);
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
        GetTapPointsCallback(pointTotal);
    }

    // This method must be implemented if using the TapjoyConnect.getTapPoints() method.
    // It is the callback method which contains the currency and points data.
    public void getUpdatePointsFailed(String error)
    {

    }

    // Notifier for receiving the featured app data on a successful connect.
    public void getFeaturedAppResponse(TapjoyFeaturedAppObject featuredApObject)
    {
        TapjoyLog.i("TAJPJOY", "getFeaturedAppResponse");
        FeaturedAppCallback((TapjoyFeaturedAppObject)featuredApObject);
    }

    // Notifier for when there is an error or no featured app to display.
    public void getFeaturedAppResponseFailed(String error)
    {

    }

    // Notifier for when spending virtual currency succeeds.
    public void getSpendPointsResponse(String currencyName, int pointTotal)
    {
        TapjoyLog.i("TAJPJOY", "getSpendPointsResponse: " + pointTotal);
        SpendTapPointsCallback(pointTotal);
    }

    // Notifier for when spending virtual currency fails.
    public void getSpendPointsResponseFailed(String error)
    {

    }

    public void getDisplayAdResponse(View view)
    {
        TapjoyLog.i("TAJPJOY", "getDisplayAdResponse");
    }

    public void getDisplayAdResponseFailed(String error)
    {

    }

    public void getAwardPointsResponse(String currencyName, int pointTotal)
    {
        TapjoyLog.i("TAJPJOY", "getAwardPointsResponse: " + pointTotal);
        AwardTapPointsCallback(pointTotal);
    }

    public void getAwardPointsResponseFailed(String error)
    {

    }


    // MARMALADE CALLBACK METHODS
    public native void GetTapPointsCallback(int points);

    public native void SpendTapPointsCallback(int points);

    public native void AwardTapPointsCallback(int points);

    public native void FeaturedAppCallback(Object featuredAppObject);
}
