/*
Generic implementation of the s3eTapjoy extension.
This file should perform any platform-indepedentent functionality
(e.g. error checking) before calling platform-dependent implementations.
*/

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#include "s3eTapjoy_internal.h"
s3eResult s3eTapjoyInit()
{
    //Add any generic initialisation code here
    return s3eTapjoyInit_platform();
}

void s3eTapjoyTerminate()
{
    //Add any generic termination code here
    s3eTapjoyTerminate_platform();
}

//s3eResult s3eTapjoyRegister(s3eTapjoyCallback cbid, s3eCallback fn, void* userData)
//{
//	return s3eTapjoyRegister_platform(cbid, fn, userData);
//}
//
//s3eResult s3eTapjoyUnRegister(s3eTapjoyCallback cbid, s3eCallback fn)
//{
//	return s3eTapjoyUnRegister_platform(cbid, fn);
//}

s3eResult TapjoyRequestConnect(const char* appID, const char* secretKey)
{
	return TapjoyRequestConnect_platform(appID, secretKey);
}

s3eResult TapjoyActionComplete(const char* actionID)
{
	return TapjoyActionComplete_platform(actionID);
}

s3eResult TapjoySetUserID(const char* userID)
{
	return TapjoySetUserID_platform(userID);
}

s3eResult TapjoyShowOffers()
{
	return TapjoyShowOffers_platform();
}

s3eResult TapjoyShowOffersWithCurrenyID(const char* currencyID, s3eBool enableCurrencySelector)
{
	return TapjoyShowOffersWithCurrenyID_platform(currencyID, enableCurrencySelector);
}

s3eResult TapjoyGetTapPoints(TapjoyGetTapPointsCallbackFn callbackFn, void* userData)
{
	return TapjoyGetTapPoints_platform(callbackFn, userData);
}

s3eResult TapjoySpendTapPoints(int amount, TapjoySpendTapPointsCallbackFn callbackFn, void* userData)
{
	return TapjoySpendTapPoints_platform(amount, callbackFn, userData);
}

s3eResult TapjoyAwardTapPoints(int amount, TapjoyAwardTapPointsCallbackFn callbackFn, void* userData)
{
	return TapjoyAwardTapPoints_platform(amount, callbackFn, userData);
}

s3eResult TapjoyShowVirtualGoods()
{
	return TapjoyShowVirtualGoods_platform();
}

TapjoyVGStoreItem* TapjoyGetPurchasedItem(int index)
{
	return TapjoyGetPurchasedItem_platform(index);
}

TapjoyVGStoreItem* TapjoyGetAvailableItem(int index)
{
	return TapjoyGetAvailableItem_platform(index);
}

s3eResult TapjoyGetFeaturedApp(TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData)
{
	return TapjoyGetFeaturedApp_platform(callbackFn, userData);
}

s3eResult TapjoyShowFeaturedAppFullScreenAd()
{
	return TapjoyShowFeaturedAppFullScreenAd_platform();
}

s3eResult TapjoySetFeaturedAppDisplayCount(int count)
{
	return TapjoySetFeaturedAppDisplayCount_platform(count);
}

s3eResult TapjoySetTransitionEffect(int transition)
{
	return TapjoySetTransitionEffect_platform(transition);
}

s3eResult TapjoySetOffersNavBarImage(const char* pPNGFilename)
{
	return TapjoySetOffersNavBarImage_platform(pPNGFilename);
}

s3eResult TapjoySetUserDefinedColor(int your_color_in_0xAAARRGGBB_format)
{
	return TapjoySetUserDefinedColor_platform(your_color_in_0xAAARRGGBB_format);
}

s3eResult TapjoyGetDisplayAd(const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData)
{
	return TapjoyGetDisplayAd_platform(adContentSize, shouldRefreshAd, callbackFn, userData);
}

s3eResult TapjoySetDisplayAdView(int left, int top, int width, int height)
{
	return TapjoySetDisplayAdView_platform(left, top, width, height);
}
