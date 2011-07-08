//
//  TJCAdRequestHandler.m
//
//  Created by Tapjoy on 9/27/10.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import "TJCAdRequestHandler.h"
#import "TJCCoreFetcher.h"
#import "TapjoyConnect.h"
#import "TJCLog.h"

// NSNotification name for reporting errors
NSString *kTJCAdErrorNotif = @"TJCAdErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kTJCAdMsgErrorKey = @"TJCAdMsgErrorKey";

NSString *kTJCAdClickURLStr = @"ClickURL";

NSString *kTJCAdImageDataStr = @"Image";


@implementation TJCAdRequestHandler

-(id)initRequestWithDelegate:(id<TJCFetchResponseDelegate>)aDelegate andRequestTag:(int)aTag
{
	if ((self = [super initRequestWithDelegate:aDelegate andRequestTag:aTag]))
	{
		clickURL_ = [[NSMutableString alloc] init];
		imageDataStr_ = [[NSMutableString alloc] init];
		isDataFetchSuccessful_ = NO;
	}
	
	return self;
}


- (void)requestAdWithSize:(NSString*)adSize
{
	// Reset success bool whenever a request is made. It will be set to success when data is retrieved from the server.
	isDataFetchSuccessful_ = NO;
	
	NSString *userID = [TapjoyConnect getUserID];
	
	NSString *requestString = [NSString stringWithFormat:@"%@%@",TJC_SERVICE_URL,@"display_ad"];
	
	NSString *alternateString = [NSString stringWithFormat:@"%@%@",TJC_SERVICE_URL_ALTERNATE,@"display_ad"];
	
	NSMutableDictionary *paramDict = [[[TapjoyConnect sharedTapjoyConnect] genericParameters] retain];
	
	// Add the publisher user ID to the generic parameters dictionary.
	[paramDict setObject:userID forKey:TJC_URL_PARAM_USER_ID];
	
	// Add the content size of the ad to the request URL.
	[paramDict setObject:adSize forKey:TJC_URL_PARAM_DISPLAY_AD_SIZE];
	
	[self makeGenericRequestWithURL:requestString alternateURL:alternateString params:paramDict selector:@selector(adDataRecieved:)];
	[paramDict release];
}


- (void)adDataRecieved:(TJCCoreFetcher*) myFetcher 
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"Ad Data Response Returned"];
	
	TBXMLElement *tjcConnectRetObject = [self validateResponseReturnedObject:myFetcher];
	
	// Check for valid return data;
	if(!tjcConnectRetObject) 
	{
		// Initiate fail method call.
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return;
	}
	
#if __IPHONE_4_0
	NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:myFetcher.data] autorelease];
	[parser setDelegate:self];
	[parser parse];
#else
	[TJCLog logWithLevel:LOG_DEBUG format:@"Update Account Info Response Returned"];
	
	TBXMLElement *clickURLObj = [TBXML childElementNamed:kTJCAdClickURLStr parentElement:tjcConnectRetObject];
	
	if (!clickURLObj)
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return;
	}
	
	TBXMLElement *imageDataStrObj = [TBXML childElementNamed:kTJCAdImageDataStr parentElement:tjcConnectRetObject];
	
	if (!imageDataStrObj)
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return;
	}
	
	clickURL_ = [[NSMutableString stringWithString:[TBXML textForElement:clickURLObj]] retain];
	imageDataStr_ = [[NSMutableString stringWithString:[TBXML textForElement:imageDataStrObj]] retain];
	
	// Create an array to be passed in to the fetch response method.
	NSArray *dataArray = [[NSArray alloc] initWithObjects:clickURL_, imageDataStr_, nil];
	
	// Set success bool only here!
	isDataFetchSuccessful_ = YES;
	
	// We don't use the tag here so just pass in a zero.
	[deleg_ fetchResponseSuccessWithData:dataArray withRequestTag:0];
	
	[dataArray release];
#endif
}


- (BOOL)isDataFetchSuccessful
{
	return isDataFetchSuccessful_;
}


- (void)dealloc
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCAdRequestHandler dealloc"];
	
	[clickURL_ release];
	[imageDataStr_ release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName
  namespaceURI:(NSString*)namespaceURI
 qualifiedName:(NSString*)qName
	 attributes:(NSDictionary*)attributeDict 
{
	// Check for element tag names here. We only care about the clickURL and image data.
	if ([elementName isEqualToString:kTJCAdClickURLStr]) 
	{
		[clickURL_ setString:@""];
		accumulatingClickURL = YES;
	} 
	else if ([elementName isEqualToString:kTJCAdImageDataStr]) 
	{
		[imageDataStr_ setString:@""];
		accumulatingImageDataStr = YES;
	} 
}


- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string 
{
	// Append string data for each element here. This is called after the start of an element is found.
	if (accumulatingClickURL)
	{
		[clickURL_ appendString:string];
	}
	else if (accumulatingImageDataStr)
	{
		[imageDataStr_ appendString:string];		
	}	
}


- (void)parser:(NSXMLParser*)parser 
 didEndElement:(NSString*)elementName
  namespaceURI:(NSString*)namespaceURI
 qualifiedName:(NSString*)qName 
{
	// Stop accumulating parsed data. It won't start again until specific elements begin.
	accumulatingClickURL = NO;
	accumulatingImageDataStr = NO;	
}


- (void)parserDidEndDocument:(NSXMLParser*)parser
{
	// Check for errors.
	if ((clickURL_ == nil) || (imageDataStr_ == nil))
	{
		// Initiate fail method call.
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:0];
		return;
	}
	
	if ([clickURL_ isEqualToString:@""] || [imageDataStr_ isEqualToString:@""])
	{
		// Initiate fail method call.
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:0];
		return;
	}
	
	// Create an array to be passed in to the fetch response method.
	NSArray *dataArray = [[NSArray alloc] initWithObjects:clickURL_, imageDataStr_, nil];
	
	// Set success bool only here!
	isDataFetchSuccessful_ = YES;
	
	// We don't use the tag here so just pass in a zero.
	[deleg_ fetchResponseSuccessWithData:dataArray withRequestTag:0];
	
	[dataArray release];
}


// an error occurred while parsing the ad data,
// post the error as an NSNotification to our app delegate.
- (void)handleAdError:(NSError*)parseError 
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kTJCAdErrorNotif
																		 object:self
																	  userInfo:[NSDictionary dictionaryWithObject:parseError
																														forKey:kTJCAdMsgErrorKey]];
}

// an error occurred while parsing the ad data,
// pass the error to the main thread for handling.
- (void)parser:(NSXMLParser*)parser parseErrorOccurred:(NSError*)parseError
{
	if ([parseError code] != NSXMLParserDelegateAbortedParseError)
	{
		[self performSelectorOnMainThread:@selector(handleAdError:)
									  withObject:parseError
								  waitUntilDone:NO];
	}
}

@end
