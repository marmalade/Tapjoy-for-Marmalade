/*
 * iphone-specific implementation of the Tapjoy extension.
 * Add any platform-specific functionality here.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */

#import <UIKit/UIKit.h>
#import "TapjoyConnect.h"

#include "s3eTapjoy_internal.h"
#include "s3eEdk.h"
#include "s3eEdk_iphone.h"

#define S3E_CURRENT_EXT TAPJOY
#include "s3eEdkError.h"
#define S3E_DEVICE_TAPJOY S3E_EXT_TAPJOY_HASH


// Helper functions
static char* CopyToCString(NSString* string)
{
	if (string)
	{
		const char* pStr = [string UTF8String];
		char* pCopy = (char*) s3eEdkMallocOS(strlen(pStr) + 1);
		if (pCopy)
		{
			strcpy(pCopy, pStr);
			return pCopy;
		}
	}
	return NULL;
}

static NSString* ToNSString(const char* pStr)
{
	if (pStr)
	{
		return [NSString stringWithUTF8String:pStr];
	}
	return nil;
}


@interface s3eTapjoySessionDelegate : NSObject <TJCAdDelegate>
{
	NSString *adSize_;
	BOOL shouldRefreshAd_;
	CGRect adRect_;
}

@property (nonatomic, copy) NSString *adSize_;
@property BOOL shouldRefreshAd_;
@property CGRect adRect_;


- (id)init;
- (void)getTapPointsCB:(NSNotification*)notifyObj;
- (void)awardTapPointsCB:(NSNotification*)notifyObj;
- (void)spendTapPointsCB:(NSNotification*)notifyObj;
- (void)getFeaturedAppCB:(NSNotification*)notifyObj;

@end


@implementation s3eTapjoySessionDelegate


@synthesize adSize_, adRect_, shouldRefreshAd_;

- (id)init
{
	if ((self = [super init]))
	{
		[[NSNotificationCenter defaultCenter] addObserver:self
															  selector:@selector(getTapPointsCB:)
																	name:TJC_TAP_POINTS_RESPONSE_NOTIFICATION
																 object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
															  selector:@selector(awardTapPointsCB:)
																	name:TJC_AWARD_TAP_POINTS_RESPONSE_NOTIFICATION
																 object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
															  selector:@selector(spendTapPointsCB:)
																	name:TJC_SPEND_TAP_POINTS_RESPONSE_NOTIFICATION
																 object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
															  selector:@selector(getFeaturedAppCB:)
																	name:TJC_FEATURED_APP_RESPONSE_NOTIFICATION object:nil];
		
		adSize_ = TJC_AD_BANNERSIZE_320X50;
		shouldRefreshAd_ = NO;
		adRect_ = CGRectMake(0, 0, 320, 50);
	}
	
	return self;
}

- (void)getTapPointsCB:(NSNotification*)notifyObj
{
	int tapPoints = [notifyObj.object intValue];
	
	TapjoyGetTapPointsResult result;
	result.m_PointTotal = tapPoints;
	
	// Fire callback function.
	s3eResult res = s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
														S3E_TAPJOY_CALLBACK_GET_TAP_POINTS,
														&result,
														sizeof(result),
														NULL,
														S3E_TRUE);

}

- (void)awardTapPointsCB:(NSNotification*)notifyObj
{
	int tapPoints = [notifyObj.object intValue];
	
	TapjoyAwardTapPointsResult result;
	result.m_PointTotal = tapPoints;
	
	// Fire callback function.
	s3eResult res = s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
														S3E_TAPJOY_CALLBACK_AWARD_TAP_POINTS,
														&result,
														sizeof(result),
														NULL,
														S3E_TRUE);
	
}

- (void)spendTapPointsCB:(NSNotification*)notifyObj
{
	int tapPoints = [notifyObj.object intValue];
	
	TapjoySpendTapPointsResult result;
	result.m_PointTotal = tapPoints;
	
	// Fire callback function.
	s3eResult res = s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
														S3E_TAPJOY_CALLBACK_SPEND_TAP_POINTS,
														&result,
														sizeof(result),
														NULL,
														S3E_TRUE);
	
}


- (void)getFeaturedAppCB:(NSNotification*)notifyObj
{
	TJCFeaturedAppModel *featuredApp = notifyObj.object;
	
	// Set featured app object data, to be passed back to the callback function.
	TapjoyGetFeaturedAppResult result;
	TapjoyFeaturedAppObject featuredAppObj;
	featuredAppObj.m_Cost = CopyToCString(featuredApp.cost);
	featuredAppObj.m_StoreID = CopyToCString(featuredApp.storeID);
	featuredAppObj.m_Name = CopyToCString(featuredApp.name);
	featuredAppObj.m_Description = CopyToCString(featuredApp.description);
	featuredAppObj.m_Amount = featuredApp.amount;
	featuredAppObj.m_IconURL = CopyToCString(featuredApp.iconURL);
	featuredAppObj.m_RedirectURL = CopyToCString(featuredApp.redirectURL);
	featuredAppObj.m_MaxTimesToDisplayThisApp = featuredApp.maxTimesToDisplayThisApp;
	featuredAppObj.m_FullScreenAdURL = CopyToCString(featuredApp.fullScreenAdURL);
	
	result.m_FeaturedAppObject = featuredAppObj;
	
	// Fire callback function.
	s3eResult res = s3eEdkCallbacksEnqueue(S3E_DEVICE_TAPJOY,
														S3E_TAPJOY_CALLBACK_GET_FEATURED_APP,
														&result,
														sizeof(result),
														NULL,
														S3E_TRUE);
	
	s3eEdkFreeOS((void*)featuredAppObj.m_Cost);
	s3eEdkFreeOS((void*)featuredAppObj.m_StoreID);
	s3eEdkFreeOS((void*)featuredAppObj.m_Name);
	s3eEdkFreeOS((void*)featuredAppObj.m_Description);
	s3eEdkFreeOS((void*)featuredAppObj.m_IconURL);
	s3eEdkFreeOS((void*)featuredAppObj.m_RedirectURL);
	s3eEdkFreeOS((void*)featuredAppObj.m_FullScreenAdURL);
}


- (void)didRecieveAd:(TJCAdView*)adView
{
	adView.frame = adRect_;
	
	// Add the banner ad view to the top most view.
	UIView *surfaceView = s3eEdkGetSurfaceUIView();
	[surfaceView addSubview:[TapjoyConnect getDisplayAdView]];
}


- (void)didFailWithMessage:(NSString*)msg
{
	NSLog(@"No Tapjoy Display Ads available");
}


- (NSString*)adContentSize
{
	return adSize_;
}


- (BOOL)shouldRefreshAd
{
	return shouldRefreshAd_;
}


@end



s3eTapjoySessionDelegate* sessionDelegate;

s3eResult s3eTapjoyInit_platform()
{	
	sessionDelegate = [[s3eTapjoySessionDelegate alloc] init];
	
	// Add any platform-specific initialisation code here
	return S3E_RESULT_SUCCESS;
}

void s3eTapjoyTerminate_platform()
{
	[sessionDelegate release];
	
	// Add any platform-specific termination code here
}

s3eResult s3eTapjoyRegister_platform(s3eTapjoyCallback cbid, s3eCallback fn, void* userData)
{
	return S3E_RESULT_ERROR;
}

s3eResult s3eTapjoyUnRegister_platform(s3eTapjoyCallback cbid, s3eCallback fn)
{
	return S3E_RESULT_ERROR;
}

s3eResult TapjoyRequestConnect_platform(const char* appID, const char* secretKey)
{
	[TapjoyConnect requestTapjoyConnect:ToNSString(appID) secretKey:ToNSString(secretKey)];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyActionComplete_platform(const char* actionID)
{
	[TapjoyConnect actionComplete:ToNSString(actionID)];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySetUserID_platform(const char* userID)
{
	[TapjoyConnect setUserID:ToNSString(userID)];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyShowOffers_platform()
{
	[TapjoyConnect showOffers];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyShowOffersWithCurrenyID_platform(const char* currencyID, s3eBool enableCurrencySelector)
{
	[TapjoyConnect showOffersWithCurrencyID:ToNSString(currencyID) withCurrencySelector:enableCurrencySelector];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyGetTapPoints_platform(TapjoyGetTapPointsCallbackFn callbackFn, void* userData)
{
	// Register the tap points callback function. When the notification for tap points is fired, we will enqueue(call) the callback function with the tap points amount.
	s3eResult res = EDK_CALLBACK_REG(TAPJOY, GET_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);
	
	[TapjoyConnect getTapPoints];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySpendTapPoints_platform(int amount, TapjoySpendTapPointsCallbackFn callbackFn, void* userData)
{
	// Register the tap points callback function. When the notification for tap points is fired, we will enqueue(call) the callback function with the tap points amount.
	s3eResult res = EDK_CALLBACK_REG(TAPJOY, SPEND_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);
	
	[TapjoyConnect spendTapPoints:amount];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyAwardTapPoints_platform(int amount, TapjoyAwardTapPointsCallbackFn callbackFn, void* userData)
{
	// Register the tap points callback function. When the notification for tap points is fired, we will enqueue(call) the callback function with the tap points amount.
	s3eResult res = EDK_CALLBACK_REG(TAPJOY, AWARD_TAP_POINTS, (s3eCallback)callbackFn, NULL, false);
	
	[TapjoyConnect awardTapPoints:amount];
	
	return S3E_RESULT_SUCCESS;	
}

s3eResult TapjoyShowVirtualGoods_platform()
{
	//[TapjoyConnect showVirtualGoods];
	
	return S3E_RESULT_SUCCESS;
}

TapjoyVGStoreItem* TapjoyGetPurchasedItem_platform(int index)
{	
	return NULL;
}

TapjoyVGStoreItem* TapjoyGetAvailableItem_platform(int index)
{
	return NULL;
}

s3eResult TapjoyGetFeaturedApp_platform(TapjoyGetFeaturedAppCallbackFn callbackFn, void* userData)
{
	// Register the featured callback function. When the notification for featured app is fired, we will enqueue(call) the callback function with the featured app object.
	s3eResult res = EDK_CALLBACK_REG(TAPJOY, GET_FEATURED_APP, (s3eCallback)callbackFn, NULL, false);
	
	[TapjoyConnect getFeaturedApp];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyShowFeaturedAppFullScreenAd_platform()
{
	[TapjoyConnect showFeaturedAppFullScreenAd];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySetFeaturedAppDisplayCount_platform(int count)
{
	[TapjoyConnect setFeaturedAppDisplayCount:count];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySetTransitionEffect_platform(int transition)
{
	[TapjoyConnect setTransitionEffect:(TJCTransitionEnum)transition];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySetOffersNavBarImage_platform(const char* pPNGFilename)
{
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySetUserDefinedColor_platform(int your_color_in_0xAAARRGGBB_format)
{
	[TapjoyConnect setUserdefinedColorWithIntValue:your_color_in_0xAAARRGGBB_format];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoyGetDisplayAd_platform(const char* adContentSize, s3eBool shouldRefreshAd, TapjoyGetDisplayAdCallbackFn callbackFn, void* userData)
{
	// Set banner ad properties.
	sessionDelegate.adSize_ = ToNSString(adContentSize);
	sessionDelegate.shouldRefreshAd_ = shouldRefreshAd;
	
	// Init banner ads. We don't need a callback function here since the delegate follows the TJCAdDelegate protocol and the appropriate methods will be called when ad data is recieved.
	[TapjoyConnect getDisplayAdWithDelegate:sessionDelegate];
	
	return S3E_RESULT_SUCCESS;
}

s3eResult TapjoySetDisplayAdView_platform(int left, int top, int width, int height)
{
	sessionDelegate.adRect_ = CGRectMake(left, top, width, height);
	
	return S3E_RESULT_SUCCESS;
}
