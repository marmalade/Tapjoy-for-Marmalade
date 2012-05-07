/*
 * android-specific implementation of the s3eTapjoy extension.
 * Add any platform-specific functionality here.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */

#include "s3eTapjoy_internal.h"
#include "s3eEdk.h"
#include "s3eEdk_android.h"
#include "s3e.h"


#include <jni.h>


#include "IwDebug.h"

#define S3E_CURRENT_EXT			TAPJOY
#define S3E_DEVICE_TAPJOY		S3E_EXT_TAPJOY_HASH

//enum s3eTapjoyCallback
//{
//	S3E_TAPJOY_GET_TAP_POINTS,
//    S3E_TAPJOY_SPEND_TAP_POINTS,
//    S3E_TAPJOY_AWARD_TAP_POINTS,
//	S3E_TAPJOY_CALLBACK_MAX
//};

static void GetTapPointsCallback(JNIEnv *env, jobject _this, int points, int error);
static void SpendTapPointsCallback(JNIEnv *env, jobject _this, int points, int error);
static void AwardTapPointsCallback(JNIEnv *env, jobject _this, int points, int error);
static void FeaturedAppCallback(JNIEnv *env, jobject _this, jobject featuredAppObject, int error);

// 8.2.0 update
static void DisplayAdCallback(JNIEnv *env, jobject _this, int error);
static void EarnedTapPointsCallback(JNIEnv *env, jobject _this, int points, int error);
static void VideoStatusCallback(JNIEnv *env, jobject _this, int status, int error);

static jobject g_Obj;
static jmethodID g_s3eTapjoyRegister;
static jmethodID g_s3eTapjoyUnRegister;
//static jmethodID g_s3eTapjoyGetErrorString;
//static jmethodID g_s3eTapjoyGetError;
static jmethodID g_TapjoyRequestConnect;
static jmethodID g_TapjoyActionComplete;
static jmethodID g_TapjoySetUserID;
static jmethodID g_TapjoyShowOffers;
static jmethodID g_TapjoyShowOffersWithCurrenyID;
static jmethodID g_TapjoyGetTapPoints;
static jmethodID g_TapjoySpendTapPoints;
static jmethodID g_TapjoyAwardTapPoints;

static jmethodID g_TapjoyInitVideoAd;
static jmethodID g_TapjoySetVideoCacheCount;
static jmethodID g_TapjoyEnableVideoCache;

// ANDROID SPECIFIC
static jmethodID g_TapjoySetEarnedTapPointsNotifier;
static jmethodID g_TapjoyEnableLogging;

// NOT USED ANDROID
static jmethodID g_TapjoyShowVirtualGoods;
static jmethodID g_TapjoyGetPurchasedItem;
static jmethodID g_TapjoyGetAvailableItem;

static jmethodID g_TapjoyGetFeaturedApp;
static jmethodID g_TapjoyGetFeaturedAppWithCurrencyID;
static jmethodID g_TapjoyShowFeaturedAppFullScreenAd;
static jmethodID g_TapjoySetFeaturedAppDisplayCount;

// NOT USED ANDROID
static jmethodID g_TapjoySetTransitionEffect;
static jmethodID g_TapjoySetOffersNavBarImage;
static jmethodID g_TapjoySetUserDefinedColor;

static jmethodID g_TapjoyGetDisplayAd;
static jmethodID g_TapjoyGetDisplayAdWithCurrencyID;
static jmethodID g_TapjoySetDisplayAdView;
static jmethodID g_TapjoyEnableBannerAdAutoRefresh;
static jmethodID g_TapjoyShowDisplayAd;
static jmethodID g_TapjoyHideDisplayAd;

s3eResult s3eTapjoyInit_platform()
{
	IwTrace(TAPJOY, ("---------- INIT ----------"));

    //Get the environment from the pointer
    JNIEnv* env = s3eEdkJNIGetEnv();
    jobject obj = NULL;
    jmethodID cons = NULL;

    //Get the extension class
    jclass cls = s3eEdkAndroidFindClass("s3eTapjoy");
    if (!cls)
        goto fail;

    //Get its constructor
    cons = env->GetMethodID(cls, "<init>", "()V");
    if (!cons)
        goto fail;

    //Construct the java class
    obj = env->NewObject(cls, cons);
    if (!obj)
        goto fail;

    //Get all the extension methods
    g_s3eTapjoyRegister = env->GetMethodID(cls, "s3eTapjoyRegister", "()I");
    if (!g_s3eTapjoyRegister)
        goto fail;

    g_s3eTapjoyUnRegister = env->GetMethodID(cls, "s3eTapjoyUnRegister", "()I");
    if (!g_s3eTapjoyUnRegister)
        goto fail;

//    g_s3eTapjoyGetErrorString = env->GetMethodID(cls, "s3eTapjoyGetErrorString", "()V");
//    if (!g_s3eTapjoyGetErrorString)
//        goto fail;
//
//    g_s3eTapjoyGetError = env->GetMethodID(cls, "s3eTapjoyGetError", "()V");
//    if (!g_s3eTapjoyGetError)
//        goto fail;

    g_TapjoyRequestConnect = env->GetMethodID(cls, "TapjoyRequestConnect", "(Ljava/lang/String;Ljava/lang/String;)I");
    if (!g_TapjoyRequestConnect)
        goto fail;

    g_TapjoyActionComplete = env->GetMethodID(cls, "TapjoyActionComplete", "(Ljava/lang/String;)I");
    if (!g_TapjoyActionComplete)
        goto fail;

    g_TapjoySetUserID = env->GetMethodID(cls, "TapjoySetUserID", "(Ljava/lang/String;)I");
    if (!g_TapjoySetUserID)
        goto fail;

    g_TapjoyShowOffers = env->GetMethodID(cls, "TapjoyShowOffers", "()I");
    if (!g_TapjoyShowOffers)
        goto fail;

    g_TapjoyShowOffersWithCurrenyID = env->GetMethodID(cls, "TapjoyShowOffersWithCurrenyID", "(Ljava/lang/String;Z)I");
    if (!g_TapjoyShowOffersWithCurrenyID)
        goto fail;

    g_TapjoyGetTapPoints = env->GetMethodID(cls, "TapjoyGetTapPoints", "()I");
    if (!g_TapjoyGetTapPoints)
        goto fail;

    g_TapjoySpendTapPoints = env->GetMethodID(cls, "TapjoySpendTapPoints", "(I)I");
    if (!g_TapjoySpendTapPoints)
        goto fail;

    g_TapjoyAwardTapPoints = env->GetMethodID(cls, "TapjoyAwardTapPoints", "(I)I");
    if (!g_TapjoyAwardTapPoints)
        goto fail;

    g_TapjoyShowVirtualGoods = env->GetMethodID(cls, "TapjoyShowVirtualGoods", "()I");
    if (!g_TapjoyShowVirtualGoods)
        goto fail;

    g_TapjoyGetPurchasedItem = env->GetMethodID(cls, "TapjoyGetPurchasedItem", "(I)V");
    if (!g_TapjoyGetPurchasedItem)
        goto fail;

    g_TapjoyGetAvailableItem = env->GetMethodID(cls, "TapjoyGetAvailableItem", "(I)V");
    if (!g_TapjoyGetAvailableItem)
        goto fail;

    g_TapjoyGetFeaturedApp = env->GetMethodID(cls, "TapjoyGetFeaturedApp", "()I");
    if (!g_TapjoyGetFeaturedApp)
        goto fail;

    g_TapjoyGetFeaturedAppWithCurrencyID = env->GetMethodID(cls, "TapjoyGetFeaturedAppWithCurrencyID", "(Ljava/lang/String;)I");
    if (!g_TapjoyGetFeaturedAppWithCurrencyID)
        goto fail;

    g_TapjoyShowFeaturedAppFullScreenAd = env->GetMethodID(cls, "TapjoyShowFeaturedAppFullScreenAd", "()I");
    if (!g_TapjoyShowFeaturedAppFullScreenAd)
        goto fail;

    g_TapjoySetFeaturedAppDisplayCount = env->GetMethodID(cls, "TapjoySetFeaturedAppDisplayCount", "(I)I");
    if (!g_TapjoySetFeaturedAppDisplayCount)
        goto fail;

    g_TapjoySetTransitionEffect = env->GetMethodID(cls, "TapjoySetTransitionEffect", "(I)I");
    if (!g_TapjoySetTransitionEffect)
        goto fail;

    g_TapjoySetOffersNavBarImage = env->GetMethodID(cls, "TapjoySetOffersNavBarImage", "(Ljava/lang/String;)I");
    if (!g_TapjoySetOffersNavBarImage)
        goto fail;

    g_TapjoySetUserDefinedColor = env->GetMethodID(cls, "TapjoySetUserDefinedColor", "(I)I");
    if (!g_TapjoySetUserDefinedColor)
        goto fail;

    g_TapjoyGetDisplayAd = env->GetMethodID(cls, "TapjoyGetDisplayAd", "(Ljava/lang/String;Z)I");
    if (!g_TapjoyGetDisplayAd)
        goto fail;

	g_TapjoyGetDisplayAdWithCurrencyID = env->GetMethodID(cls, "TapjoyGetDisplayAdWithCurrencyID", "(Ljava/lang/String;Ljava/lang/String;Z)I");
    if (!g_TapjoyGetDisplayAdWithCurrencyID)
        goto fail;

    g_TapjoySetDisplayAdView = env->GetMethodID(cls, "TapjoySetDisplayAdView", "(IIII)I");
    if (!g_TapjoySetDisplayAdView)
        goto fail;
    
	g_TapjoySetEarnedTapPointsNotifier = env->GetMethodID(cls, "TapjoySetEarnedTapPointsNotifier", "()I");
    if (!g_TapjoySetEarnedTapPointsNotifier)
        goto fail;

	g_TapjoyInitVideoAd = env->GetMethodID(cls, "TapjoyInitVideoAd", "()I");
    if (!g_TapjoyInitVideoAd)
        goto fail;

	g_TapjoySetVideoCacheCount = env->GetMethodID(cls, "TapjoySetVideoCacheCount", "(I)I");
    if (!g_TapjoySetVideoCacheCount)
        goto fail;

	g_TapjoyEnableVideoCache = env->GetMethodID(cls, "TapjoyEnableVideoCache", "(Z)I");
    if (!g_TapjoySetVideoCacheCount)
        goto fail;

	// g_TapjoySetCurrencyMultiplier = env->GetMethodID(cls, "TapjoySetCurrencyMultiplier", "(I)I");
	//     if (!g_TapjoySetCurrencyMultiplier)
	//         goto fail;
	// 
	// g_TapjoyGetCurrencyMultiplier = env->GetMethodID(cls, "TapjoyGetCurrencyMultiplier", "()I");
	//     if (!g_TapjoyGetCurrencyMultiplier)
	//         goto fail;

	g_TapjoyEnableBannerAdAutoRefresh = env->GetMethodID(cls, "TapjoyEnableBannerAdAutoRefresh", "(Z)I");
    if (!g_TapjoyEnableBannerAdAutoRefresh)
        goto fail;

	g_TapjoyEnableLogging = env->GetMethodID(cls, "TapjoyEnableLogging", "(Z)I");
    if (!g_TapjoyEnableLogging)
        goto fail;

	g_TapjoyShowDisplayAd = env->GetMethodID(cls, "TapjoyShowDisplayAd", "()I");
    if (!g_TapjoyShowDisplayAd)
        goto fail;

	g_TapjoyHideDisplayAd = env->GetMethodID(cls, "TapjoyHideDisplayAd", "()I");
    if (!g_TapjoyHideDisplayAd)
        goto fail;

fail:
    
	const JNINativeMethod nativeMethodDefs[] =
	{
        {"GetTapPointsCallback",                "(II)V",							(void *)&GetTapPointsCallback},
        {"SpendTapPointsCallback",              "(II)V",							(void *)&SpendTapPointsCallback},
        {"AwardTapPointsCallback",              "(II)V",							(void *)&AwardTapPointsCallback},
		{"FeaturedAppCallback",					"(Ljava/lang/Object;I)V",			(void *)&FeaturedAppCallback},
		{"EarnedTapPointsCallback",				"(II)V",							(void *)&EarnedTapPointsCallback},
		{"DisplayAdCallback",					"(I)V",								(void *)&DisplayAdCallback},
		{"VideoStatusCallback",					"(II)V",							(void *)&VideoStatusCallback},
	};
    
	env->RegisterNatives(cls, nativeMethodDefs, sizeof(nativeMethodDefs)/sizeof(nativeMethodDefs[0]));


    jthrowable exc = env->ExceptionOccurred();
    if (exc)
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        IwTrace(TAPJOY, ("One or more java methods could not be found"));
        return S3E_RESULT_ERROR;
    }

    IwTrace(TAPJOY, ("s3eTapjoy init success"));
    g_Obj = env->NewGlobalRef(obj);
    env->DeleteLocalRef(obj);
    env->DeleteLocalRef(cls);

    // Add any platform-specific initialisation code here
    return S3E_RESULT_SUCCESS;
}

void s3eTapjoyTerminate_platform()
{
    // Add any platform-specific termination code here
}

s3eResult s3eTapjoyRegister_platform(s3eTapjoyCallback cbid, s3eCallback fn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_s3eTapjoyRegister);
}

s3eResult s3eTapjoyUnRegister_platform(s3eTapjoyCallback cbid, s3eCallback fn)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_s3eTapjoyUnRegister);
}

s3eResult TapjoyRequestConnect_platform(const char* appID, const char* secretKey)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring appID_jstr = env->NewStringUTF(appID);
    jstring secretKey_jstr = env->NewStringUTF(secretKey);
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyRequestConnect, appID_jstr, secretKey_jstr);
}

s3eResult TapjoyActionComplete_platform(const char* actionID)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring actionID_jstr = env->NewStringUTF(actionID);
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyActionComplete, actionID_jstr);
}

s3eResult TapjoySetUserID_platform(const char* userID)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring userID_jstr = env->NewStringUTF(userID);
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetUserID, userID_jstr);
}

s3eResult TapjoyShowOffers_platform()
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyShowOffers);
}

s3eResult TapjoyShowOffersWithCurrenyID_platform(const char* currencyID, s3eBool enableCurrencySelector)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring currencyID_jstr = env->NewStringUTF(currencyID);
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyShowOffersWithCurrenyID, currencyID_jstr, enableCurrencySelector);
}

s3eResult TapjoyGetTapPoints_platform(TapjoyGetTapPointsCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    
    // Register Callback
    EDK_CALLBACK_REG(TAPJOY, GET_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);
    
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyGetTapPoints);
}

s3eResult TapjoySpendTapPoints_platform(int amount, TapjoySpendTapPointsCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    
    // Register Callback
    EDK_CALLBACK_REG(TAPJOY, SPEND_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);
    
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySpendTapPoints, amount);
}

s3eResult TapjoyAwardTapPoints_platform(int amount, TapjoyAwardTapPointsCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    
    // Register Callback
    EDK_CALLBACK_REG(TAPJOY, AWARD_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);
    
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyAwardTapPoints, amount);
}

s3eResult TapjoyShowVirtualGoods_platform()
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyShowVirtualGoods);
}

TapjoyVGStoreItem* TapjoyGetPurchasedItem_platform(int index)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    env->CallVoidMethod(g_Obj, g_TapjoyGetPurchasedItem, index);
    return NULL;
}

TapjoyVGStoreItem* TapjoyGetAvailableItem_platform(int index)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    env->CallVoidMethod(g_Obj, g_TapjoyGetAvailableItem, index);
    return NULL;
}

s3eResult TapjoyGetFeaturedApp_platform(TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();

	// Register Callback
    EDK_CALLBACK_REG(TAPJOY, GET_FEATURED_APP, (s3eCallback)callbackFn, NULL, false);

    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyGetFeaturedApp);
}

s3eResult TapjoyGetFeaturedAppWithCurrencyID_platform(const char* currencyID, TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
	jstring currencyID_jstr = env->NewStringUTF(currencyID);
	
	// Register Callback
    EDK_CALLBACK_REG(TAPJOY, GET_FEATURED_APP, (s3eCallback)callbackFn, NULL, false);

    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyGetFeaturedApp, currencyID_jstr);
}

s3eResult TapjoyShowFeaturedAppFullScreenAd_platform()
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyShowFeaturedAppFullScreenAd);
}

s3eResult TapjoySetFeaturedAppDisplayCount_platform(int count)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetFeaturedAppDisplayCount, count);
}

s3eResult TapjoySetTransitionEffect_platform(int transition)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetTransitionEffect, transition);
}

s3eResult TapjoySetOffersNavBarImage_platform(const char* pPNGFilename)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring pPNGFilename_jstr = env->NewStringUTF(pPNGFilename);
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetOffersNavBarImage, pPNGFilename_jstr);
}

s3eResult TapjoySetUserDefinedColor_platform(int your_color_in_0xAAARRGGBB_format)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetUserDefinedColor, your_color_in_0xAAARRGGBB_format);
}

s3eResult TapjoyGetDisplayAd_platform(const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring adContentSize_jstr = env->NewStringUTF(adContentSize);

	// Register Callback
	EDK_CALLBACK_REG(TAPJOY, GET_DISPLAY_AD, (s3eCallback)callbackFn, NULL, false);

    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyGetDisplayAd, adContentSize_jstr, shouldRefreshAd);
}

s3eResult TapjoyGetDisplayAdWithCurrencyID_platform(const char* currencyID, const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    jstring adContentSize_jstr = env->NewStringUTF(adContentSize);
	jstring currencyID_jstr = env->NewStringUTF(currencyID);
	
	// Register Callback
	EDK_CALLBACK_REG(TAPJOY, GET_DISPLAY_AD, (s3eCallback)callbackFn, NULL, false);
	
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyGetDisplayAd, currencyID_jstr, adContentSize_jstr, shouldRefreshAd);
}

s3eResult TapjoySetDisplayAdView_platform(int left, int top, int width, int height)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetDisplayAdView, left, top, width, height);
}

s3eResult TapjoyEnableBannerAdAutoRefresh_platform(s3eBool enable)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyEnableBannerAdAutoRefresh, enable);
}

s3eResult TapjoyShowDisplayAd_platform()
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyShowDisplayAd);
}

s3eResult TapjoyHideDisplayAd_platform()
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyHideDisplayAd);
}

s3eResult TapjoySetEarnedTapPointsNotifier_platform(TapjoyEarnedTapPointsCallbackFn callbackFn)
{
    JNIEnv* env = s3eEdkJNIGetEnv();

	// Register Callback
	EDK_CALLBACK_REG(TAPJOY, EARNED_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);

    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetEarnedTapPointsNotifier);
}

s3eResult TapjoyInitVideoAd_platform(TapjoyVideoStatusCallbackFn callbackFn)
{
    JNIEnv* env = s3eEdkJNIGetEnv();

	// Register Callback
	EDK_CALLBACK_REG(TAPJOY, VIDEO_STATUS, (s3eCallback)callbackFn, NULL, false);

    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyInitVideoAd);
}

s3eResult TapjoySetVideoCacheCount_platform(int count)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoySetVideoCacheCount, count);
}

s3eResult TapjoyEnableVideoCache_platform(s3eBool enable)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyEnableVideoCache, enable);
}

s3eResult TapjoyEnableLogging_platform(s3eBool enable)
{
    JNIEnv* env = s3eEdkJNIGetEnv();
    return (s3eResult)env->CallIntMethod(g_Obj, g_TapjoyEnableLogging, enable);
}

//Native functions called by java
void GetTapPointsCallback(JNIEnv *env, jobject _this, int points, int error)
{
	TapjoyGetTapPointsResult result;
	result.m_PointTotal = points;
	result.m_Error = (s3eTapjoyError)error;

	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_GET_TAP_POINTS,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}

void SpendTapPointsCallback(JNIEnv *env, jobject _this, int points, int error)
{  
	TapjoySpendTapPointsResult result;
	result.m_PointTotal = points;
	result.m_Error = (s3eTapjoyError)error;

	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_SPEND_TAP_POINTS,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}

void AwardTapPointsCallback(JNIEnv *env, jobject _this, int points, int error)
{  
	TapjoyAwardTapPointsResult result;
	result.m_PointTotal = points;
	result.m_Error = (s3eTapjoyError)error;

	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_AWARD_TAP_POINTS,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}

void FeaturedAppCallback(JNIEnv *env, jobject _this, jobject featuredAppObject, int error)
{  
	TapjoyGetFeaturedAppResult result;
	TapjoyFeaturedAppObject featuredApp;
	
	// Don't use this for now.
	result.m_FeaturedAppObject = featuredApp;
	result.m_Error = (s3eTapjoyError)error;

	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_GET_FEATURED_APP,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}

void DisplayAdCallback(JNIEnv *env, jobject _this, int error)
{  
	TapjoyGetDisplayAdResult result;
	result.m_Error = (s3eTapjoyError)error;
	
	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_GET_DISPLAY_AD,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}

void EarnedTapPointsCallback(JNIEnv *env, jobject _this, int amount, int error)
{
	TapjoyEarnedTapPointsResult result;
	result.m_Amount = amount;
	result.m_Error = (s3eTapjoyError)error;

	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_EARNED_TAP_POINTS,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}

void VideoStatusCallback(JNIEnv *env, jobject _this, int status, int error)
{
	TapjoyVideoStatusResult result;
	result.m_statusCode = status;
	result.m_Error = (s3eTapjoyError)error;

	s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
							S3E_TAPJOY_CALLBACK_VIDEO_STATUS,
							&result,
							sizeof(result),
							NULL,
							S3E_TRUE);
}
