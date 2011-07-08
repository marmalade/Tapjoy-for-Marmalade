//
//  TJCAdView.h
//
//  Created by Tapjoy on 9/28/10.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "TJCFetchResponseProtocol.h"
#import "TJCAdDelegateProtocol.h"
#import "TapjoyConnect.h"

#define TJC_AD_BANNERSIZE_320X50		@"320x50"
#define TJC_AD_BANNERSIZE_640X100	@"640x100"
#define TJC_AD_BANNERSIZE_768X90		@"768x90"


#define TJC_AD_REFRESH_DELAY		(15.0)

extern NSString *kTJCAdFailStr;

@class TJCAdRequestHandler;

/*!	\interface TJCAdView
 *	\brief The Tapjoy Connect Ad View class.
 *
 */
@interface TJCAdView : UIView <TJCFetchResponseDelegate>
{
	NSString *clickURL_;					/*!< The redirect url for the ABC Ad. */
	NSString *imageDataStr_;			/*!< The image data in string form. */
	UIImageView *imageView_;			/*!< The Ad image view. */
	UIImageView *previousImageView_;	/*!< The previous Ad image view. */
	NSString *contentSizeStr_;			/*!< The content size string of the Ad. */
	UIView *adViewOverlay_;				/*!< This is used to darken the ad view when the ad is touched. */
	NSTimer *refreshTimer_;				/*!< The refresh timer that fires off a callback message each refresh. */
	
	TJCAdRequestHandler *adHandlerObj_;	/*!< The Ad request handler handles URL requests and responses. */
	id<TJCAdDelegate> adDelegate_;		/*!< The Ad delegate used to handle delegate protocol methods. */
}


@property (nonatomic, retain) NSString *clickURL;
@property (nonatomic, retain) NSString *imageDataStr;	
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImageView *previousImageView;
@property (nonatomic, retain) NSString *contentSizeStr;
@property (nonatomic, retain) UIView *adViewOverlay;

@property (nonatomic, retain) TJCAdRequestHandler *adHandlerObj;
@property (nonatomic, retain) id<TJCAdDelegate> adDelegate;

+ (TJCAdView*) sharedTJCAdView;

/*!	\fn getAdWithDelegate:(id<TJCAdDelegate>)deleg
 *	\brief Initiates a URL request to get the Tapjoy Ad data.
 *
 *	\param The delegate object that Tapjoy Ad Messages will be sent to.
 *	\return n/a
 */
+ (id) getAdWithDelegate:(id<TJCAdDelegate>)deleg;

/*!	\fn fetchResponseSuccessWithData:withRequestTag:(void* dataObj, int aTag)
 *	\brief Called when the request for the ad data succeeeds.
 *
 *	\param dataObj The ad data returned from the server.
 *	\param aTag ID associated with the request.
 *	\return n/a
 */
- (void)fetchResponseSuccessWithData:(void*)dataObj withRequestTag:(int)aTag;

/*!	\fn fetchResponseError:errorDescription:requestTag:(TJCResponseError errorType, id errorDescObj, int aTag)
 *	\brief Called when and error occurs with the URL request.
 *
 *	\param errorType Contains error information.
 *	\param errorDescObj Contains error data.
 *	\param aTag ID associated with the request.
 *	\return n/a
 */
- (void) fetchResponseError:(TJCResponseError)errorType errorDescription:(id)errorDescObj requestTag:(int)aTag;

/*!	\fn refreshAd
 *	\brief Attempts to load a new Ad.
 *
 *	\param n/a
 *	\return n/a
 */
+ (void) refreshAd;

/*!	\fn isAdLoaded
 *	\brief Indicates whether ad data has been successfully loaded.
 *
 *	\param n/a
 *	\return YES to indicate that the ad data has been successfully loaded, NO otherwise.
 */
+ (BOOL) isAdLoaded;

@end




@interface TapjoyConnect (TJCAdView)

/*!	\fn getDisplayAdWithDelegate:(id<TJCAdDelegate>)deleg
 *	\brief Initiates a URL request to get the Tapjoy Ad data.
 *
 *	\return The TJCAdView singleton object.
 */
+ (id) getDisplayAdWithDelegate:(id <TJCAdDelegate>)deleg;

/*!	\fn refreshDisplayAd
 *	\brief Attempts to load a new Ad.
 *
 *	\param n/a
 *	\return n/a
 */
+ (void) refreshDisplayAd;

/*!	\fn isDisplayAdLoaded
 *	\brief Indicates whether ad data has been successfully loaded.
 *
 *	\param n/a
 *	\return YES to indicate that the ad data has been successfully loaded, NO otherwise.
 */
+ (BOOL) isDisplayAdLoaded;

/*!	\fn getDisplayAdView
 *	\brief The Tapjoy Display Ad UIView returned by this method should be added to the current superview after an Ad has been successfully loaded.
 *
 *	\param n/a
 *	\return The Tapjoy Display Ad UIView.
 */
+ (TJCAdView*) getDisplayAdView;

@end

