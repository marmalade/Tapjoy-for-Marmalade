/*
Internal header for the s3eTapjoy extension.

This file should be used for any common function definitions etc that need to
be shared between the platform-dependent and platform-indepdendent parts of
this extension.
*/

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#ifndef S3ETAPJOY_H_INTERNAL
#define S3ETAPJOY_H_INTERNAL

#include "s3eTypes.h"
#include "s3eTapjoy.h"
#include "s3eTapjoy_autodefs.h"


/**
 * Initialise the extension.  This is called once then the extension is first
 * accessed by s3eregister.  If this function returns S3E_RESULT_ERROR the
 * extension will be reported as not-existing on the device.
 */
s3eResult s3eTapjoyInit();

/**
 * Platform-specific initialisation, implemented on each platform
 */
s3eResult s3eTapjoyInit_platform();

/**
 * Terminate the extension.  This is called once on shutdown, but only if the
 * extension was loader and Init() was successful.
 */
void s3eTapjoyTerminate();

/**
 * Platform-specific termination, implemented on each platform
 */
void s3eTapjoyTerminate_platform();
s3eResult s3eTapjoyRegister_platform(s3eTapjoyCallback cbid, s3eCallback fn, void* userData);

s3eResult s3eTapjoyUnRegister_platform(s3eTapjoyCallback cbid, s3eCallback fn);

s3eResult TapjoyRequestConnect_platform(const char* appID, const char* secretKey);

s3eResult TapjoyActionComplete_platform(const char* actionID);

s3eResult TapjoySetUserID_platform(const char* userID);

s3eResult TapjoyShowOffers_platform();

s3eResult TapjoyShowOffersWithCurrenyID_platform(const char* currencyID, s3eBool enableCurrencySelector);

s3eResult TapjoyGetTapPoints_platform(TapjoyGetTapPointsCallbackFn callbackFn, void* userData);

s3eResult TapjoySpendTapPoints_platform(int amount, TapjoySpendTapPointsCallbackFn callbackFn, void* userData);

s3eResult TapjoyAwardTapPoints_platform(int amount, TapjoyAwardTapPointsCallbackFn callbackFn, void* userData);

s3eResult TapjoyShowVirtualGoods_platform();

TapjoyVGStoreItem* TapjoyGetPurchasedItem_platform(int index);

TapjoyVGStoreItem* TapjoyGetAvailableItem_platform(int index);

s3eResult TapjoyGetFeaturedApp_platform(TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData);

s3eResult TapjoyShowFeaturedAppFullScreenAd_platform();

s3eResult TapjoySetFeaturedAppDisplayCount_platform(int count);

s3eResult TapjoySetTransitionEffect_platform(int transition);

s3eResult TapjoySetOffersNavBarImage_platform(const char* pPNGFilename);

s3eResult TapjoySetUserDefinedColor_platform(int your_color_in_0xAAARRGGBB_format);

s3eResult TapjoyGetDisplayAd_platform(const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData);

s3eResult TapjoySetDisplayAdView_platform(int left, int top, int width, int height);


#endif /* S3ETAPJOY_H_INTERNAL */