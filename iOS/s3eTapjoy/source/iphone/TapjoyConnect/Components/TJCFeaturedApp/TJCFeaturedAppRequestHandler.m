//
//  TJCFeaturedAppRequestHandller.m
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import "TJCFeaturedAppRequestHandler.h"
#import "TJCLog.h"
#import "TapjoyConnect.h"
#import "TJCCoreFetcher.h"
#import "TJCOffersWebView.h"
#import "TJCConstants.h"
#import "TJCFeaturedAppView.h"


@implementation TJCFeaturedAppRequestHandler

-(id) initRequestWithDelegate:(id<TJCFetchResponseDelegate>) aDelegate andRequestTag:(int)aTag
{
	if((self = [super initRequestWithDelegate:aDelegate andRequestTag:aTag]))
	{
		
	}
	return self;
}


- (void)requestFeaturedApp
{
	NSString *userID = [TapjoyConnect getUserID];
	
	// Save off the user id since we may need to access it later upon a possible retry.
	[TJCFeaturedAppView sharedTJCFeaturedAppView].publisherUserID_ = userID;
	
	NSString *requestString = [NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL, TJC_FEATURED_URL_NAME];
	
	NSString *alternateString = [NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL_ALTERNATE, TJC_FEATURED_URL_NAME];
	
	NSMutableDictionary *paramDict = [[[TapjoyConnect sharedTapjoyConnect] genericParameters] retain];
	
	// Add the publisher user ID to the generic parameters dictionary.
	[paramDict setObject:userID forKey:TJC_URL_PARAM_USER_ID];
	
	[self makeGenericRequestWithURL:requestString alternateURL:alternateString params:paramDict selector:@selector(featuredAppDataRecieved:)];
	[paramDict release];
}


- (void) requestFeaturedAppWithCurrencyID:(NSString*)currencyID
{
	NSString *userID = [TapjoyConnect getUserID];
	
	// Save off the user id since we may need to access it later upon a possible retry.
	[TJCFeaturedAppView sharedTJCFeaturedAppView].publisherUserID_ = userID;
	
	NSString *requestString = [NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL, TJC_FEATURED_URL_NAME];
	
	NSString *alternateString = [NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL_ALTERNATE, TJC_FEATURED_URL_NAME];
	
	NSMutableDictionary *paramDict = [[[TapjoyConnect sharedTapjoyConnect] genericParameters] retain];
	
	// Add the publisher user ID to the generic parameters dictionary.
	[paramDict setObject:userID forKey:TJC_URL_PARAM_USER_ID];
	
	// Add the currency ID to the generic parameters dictionary.
	[paramDict setObject:currencyID forKey:TJC_URL_PARAM_CURRENCY_ID];
	
	[self makeGenericRequestWithURL:requestString alternateURL:alternateString params:paramDict selector:@selector(featuredAppDataRecieved:)];
	[paramDict release];
}


- (void) featuredAppDataRecieved:(TJCCoreFetcher *) myFetcher 
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"Update Account Info Response Returned"];
	
	TBXMLElement *tjcConnectRetObject = [self validateResponseReturnedObject:myFetcher];
	
	if (!tjcConnectRetObject) 
		return;
	
	TBXMLElement *offerArryObj = [TBXML childElementNamed:@"OfferArray" parentElement:tjcConnectRetObject];
	
	if(!offerArryObj)
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return;
	}
	
	TBXMLElement *featureApp = [TBXML childElementNamed:@"TapjoyApp" parentElement:offerArryObj];
	
	if(!featureApp)
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return;
	}
	
	[deleg_ fetchResponseSuccessWithData:featureApp withRequestTag:myFetcher.requestTag];
}


-(void) dealloc
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCFeaturedAppRequestHandler dealloc"];
	[super dealloc];
}

@end
