//
//  TJCAdRequestHandler.h
//
//  Created by Tapjoy on 9/27/10.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJCCoreFetcherHandler.h"

extern NSString *kTJCAdClickURLStr;
extern NSString *kTJCAdImageDataStr;


/*!	\interface TJCAdRequestHandler
 *	\brief The Tapjoy Connect Ad Request Handler class.
 *
 * This class handles the actual URL request to grab the ad data from the server.
 */
@interface TJCAdRequestHandler : TJCCoreFetcherHandler 
#if __IPHONE_4_0
<TJCWebFetcherDelegate, NSXMLParserDelegate>
#else
<TJCWebFetcherDelegate>
#endif
{
	BOOL accumulatingClickURL;				/*!< Indicates whether the NSXML parser is currently parsing the click URL data. */
	NSMutableString *clickURL_;			/*!< The redirect url for the ABC Ad. */
	BOOL accumulatingImageDataStr;		/*!< Indicates whether the NSXML parser is currently parsinge the image data. */
	NSMutableString *imageDataStr_;		/*!< The image data in string form. */
	BOOL isDataFetchSuccessful_;			/*!< Only set to true if valid data was recieved from the server. */
}

/*!	\fn initRequestWithDelegate:andRequestTag(id<TJCFetchResponseDelegate> aDelegate, int aTag)
 *	\brief Initializes the #TJCAdRequestHandler object with the given delegate and tag id.
 *
 *	\param aDelegate The #TJCFetchResponseDelegate delegate object to initialize with.
 *	\return The #TJCFeaturedAppModel object.
 */
- (id)initRequestWithDelegate:(id<TJCFetchResponseDelegate>)aDelegate andRequestTag:(int)aTag;

/*!	\fn requestAdWithSize:(NSString*)adSize
 *	\brief Initiates the URL request to get the ad data from the server.
 *
 *  \param adSize Must be one of #TJC_AD_BANNERSIZE_320X50 or #TJC_AD_BANNERSIZE_640X100 or #TJC_AD_BANNERSIZE_768x90.
 *	\return n/a
 */
- (void)requestAdWithSize:(NSString*)adSize;

- (BOOL)isDataFetchSuccessful;

@end
