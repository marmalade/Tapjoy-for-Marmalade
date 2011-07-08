//
//  TapjoyConnect.m
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
//

#import "TapjoyConnect.h"
#import <CommonCrypto/CommonHMAC.h>


static TapjoyConnect *sharedInstance_ = nil; //To make TapjoyConnect Singleton
static NSString *orignalRequest = TJC_SERVICE_URL;

@implementation TapjoyConnect

@synthesize appID = appID_;
@synthesize secretKey = secretKey_;
@synthesize userID = userID_;
@synthesize isInitialConnect = isInitialConnect_;

+ (TapjoyConnect*)sharedTapjoyConnect
{
	if(!sharedInstance_)
	{
		sharedInstance_ = [[super alloc] init];
	}
	
	return sharedInstance_;
}


- (NSMutableDictionary*)genericParameters
{
	// Device info.
	UIDevice *device = [UIDevice currentDevice];
	NSString *identifier = [[NSString stringWithString:[device uniqueIdentifier]] lowercaseString];
	NSString *model = [device model];
	NSString *systemVersion = [device systemVersion];
	
#if !defined (TJC_CONNECT_SDK)
	NSString *device_name = [device platform];
	//NSLog(@"device name: %@", device_name);
#endif
	
	// Locale info.
	NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
	NSString *language = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];	
	
	// App info.
	NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
	
	NSString *lad = [self isJailBrokenStr];
	
	NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
	// Get seconds since Jan 1st, 1970.
	NSString *timeStamp = [NSString stringWithFormat:@"%d", (int)timeInterval];
	
	// Compute verifier.
	NSString *verifier = [TapjoyConnect TJCSHA256CommonParamsWithTimeStamp:timeStamp];
	
	if (!appID_)
	{
		NSLog(@"requestTapjoyConnect:secretKey: must be called before any other Tapjoy methods!");
	}
	
	NSMutableDictionary * genericDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
													 identifier, TJC_UDID,
													 model, TJC_DEVICE_TYPE_NAME,
#if !defined (TJC_CONNECT_SDK)
													 device_name, TJC_DEVICE_NAME,
#endif
													 systemVersion, TJC_DEVICE_OS_VERSION_NAME,
													 appID_, TJC_APP_ID_NAME,
													 bundleVersion, TJC_APP_VERSION_NAME,
													 TJC_LIBRARY_VERSION_NUMBER, TJC_CONNECT_LIBRARY_VERSION_NAME,
													 countryCode, TJC_DEVICE_COUNTRY_CODE,
													 language, TJC_DEVICE_LANGUAGE,
													 lad, TJC_DEVICE_LAD,
													 timeStamp, TJC_TIMESTAMP,
													 verifier, TJC_VERIFIER,
													 nil];
	
	return [genericDict autorelease];
}


- (NSString*)urlEncode:(id)object
{
	NSString *string = [NSString stringWithFormat: @"%@", object];
	return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}


- (NSString*)createQueryStringFromDict:(NSDictionary*) paramDict
{
	if(!paramDict)
	{
#if !defined (TJC_CONNECT_SDK)
		[TJCLog logWithLevel:LOG_DEBUG format:@"Sending Nil Getting Generic Dictionary Now"];
#endif
		paramDict = [[TapjoyConnect sharedTapjoyConnect] genericParameters];
	}
	
	NSMutableArray *parts = [NSMutableArray array];
	for (id key in [paramDict allKeys])
	{
		id value = [paramDict objectForKey: key];
		NSString *part = [NSString stringWithFormat: @"%@=%@", [self urlEncode:key], [self urlEncode:value]];
		[parts addObject: part];
	}
	return [parts componentsJoinedByString: @"&"];
}


- (void)connectWithParam:(NSMutableDictionary*)genericDict
{
	NSString *requestString1 = [NSString stringWithFormat:@"%@%@?%@",orignalRequest,@"connect", [self createQueryStringFromDict:genericDict]];
	
	NSString *requestString = [requestString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSURL * myURL = [[NSURL alloc] initWithString:requestString];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL: myURL
																				cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData
																		  timeoutInterval: 30];
	[myURL release];
	
	connection_ = [[NSURLConnection alloc] initWithRequest: myRequest delegate: self];
	connectAttempts_++;	
}


- (NSCachedURLResponse*)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse 
{
	// Returning nil will ensure that no cached response will be stored for the connection.
	// This is in case the cache is being used by something else.
	return nil;
}


static const char* jailbreak_apps[] =
{
	"/Applications/Cydia.app", 
	"/Applications/limera1n.app", 
	"/Applications/greenpois0n.app", 
	"/Applications/blackra1n.app",
	"/Applications/blacksn0w.app",
	"/Applications/redsn0w.app",
	NULL,
};

- (BOOL)isJailBroken
{
	// Now check for known jailbreak apps. If we encounter one, the device is jailbroken.
	for (int i = 0; jailbreak_apps[i] != NULL; ++i)
	{
		if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]])
		{
			//NSLog(@"isjailbroken: %s", jailbreak_apps[i]);
			return YES;
		}		
	}
	
	// TODO: Add more checks? This is an arms-race we're bound to lose.
	
	return NO;
}

- (NSString*)isJailBrokenStr
{
	if ([self isJailBroken])
	{
		return @"42";
	}
	
	return @"0";
}


- (id)initWithAppID:(NSString*)appID withSecretKey:(NSString*)secretKey
{
	appID_ = [appID retain];
	secretKey_ = [secretKey retain];
	connection_ = nil;
	connectAttempts_ = 0;
	
	return self;
}


+ (TapjoyConnect*)requestTapjoyConnect:(NSString*)appID secretKey:(NSString*)secretKey
{
	[[TapjoyConnect sharedTapjoyConnect] initWithAppID:appID withSecretKey:secretKey];
	
	// Default user id to the UDID.
	[TapjoyConnect sharedTapjoyConnect].userID = [[NSString stringWithString:[[UIDevice currentDevice] uniqueIdentifier]] lowercaseString];
	
	// This should really only be set to YES here ever.
	[TapjoyConnect sharedTapjoyConnect].isInitialConnect = YES;
	
	[[TapjoyConnect sharedTapjoyConnect] connectWithParam:[[TapjoyConnect sharedTapjoyConnect] genericParameters]];
	
#if __IPHONE_4_0
	[[NSNotificationCenter defaultCenter] addObserver:self 
														  selector:@selector(deviceNotificationReceived) 
																name:UIApplicationDidBecomeActiveNotification 
															 object:nil];
#endif
	
#if !defined (TJC_CONNECT_SDK) && !defined (TJC_GAME_STATE_SDK)
	// Update tap points.
	[TapjoyConnect getTapPoints];
#endif
	
	return [TapjoyConnect sharedTapjoyConnect];
}


+ (TapjoyConnect*)actionComplete:(NSString*)actionID
{
	// Get the generic params.
 	NSMutableDictionary *paramDict = [[TapjoyConnect sharedTapjoyConnect] genericParameters];
	
	// Overwrite the appID with the actionID. This is how actions are sent.
	[paramDict setObject:[NSString stringWithString:actionID] forKey:TJC_APP_ID_NAME];
	
	// Ping the server.
	[[TapjoyConnect sharedTapjoyConnect] connectWithParam:paramDict];
	
	return [TapjoyConnect sharedTapjoyConnect];
}


+ (void)deviceNotificationReceived
{
	// Since we're relying on UIApplicationDidBecomeActiveNotification, we need to make sure we don't call connect twice in a row
	// upon initial start-up of the applicaiton.
	if ([[TapjoyConnect sharedTapjoyConnect] isInitialConnect])
	{
		[TapjoyConnect sharedTapjoyConnect].isInitialConnect = NO;
	}
	else
	{
		// Call connect when the app 
		[[TapjoyConnect sharedTapjoyConnect] connectWithParam:[[TapjoyConnect sharedTapjoyConnect] genericParameters]];
	}
	
#if !defined (TJC_CONNECT_SDK)
	// When the app goes into the background, refresh the offers web view to clear out stale offers.
	if ([[TJCOffersWebView sharedTJCOffersWebView] isViewVisible_])
	{
		//[[TJCOffersWebView sharedTJCOffersWebView] loadView];
		[[TJCOffersWebView sharedTJCOffersWebView] refreshWebView];
	}
	
#if !defined (TJC_GAME_STATE_SDK)
	// Update tap points.
	[TapjoyConnect getTapPoints];
#endif
	
#endif
}


+ (NSString*)getAppID
{
	return [[TapjoyConnect sharedTapjoyConnect] appID];
}


+ (void)setUserID:(NSString*)theUserID
{
	[TapjoyConnect sharedTapjoyConnect].userID = [theUserID retain];
}


+ (NSString*)getUserID
{
	if (![[TapjoyConnect sharedTapjoyConnect] userID])
	{
		[TapjoyConnect sharedTapjoyConnect].userID = [[NSString stringWithString:[[UIDevice currentDevice] uniqueIdentifier]] lowercaseString];
	}
	
	return [[TapjoyConnect sharedTapjoyConnect] userID];
}


+ (NSString*)getSecretKey
{
	return [[TapjoyConnect sharedTapjoyConnect] secretKey];
}


+ (NSString*)TJCSHA256CommonParamsWithTimeStamp:(NSString*)timeStamp
{
	NSString *appID = [TapjoyConnect getAppID];
	
	NSString *keyStr = [TapjoyConnect getSecretKey];
	
	NSString *udid = [[NSString stringWithString:[[UIDevice currentDevice] uniqueIdentifier]] lowercaseString];
	
	NSString *verifierStr = [NSString stringWithFormat:@"%@:%@:%@:%@",
									 appID,
									 udid,
									 timeStamp,
									 keyStr];
	
	NSString *hashStr = [TapjoyConnect TJCSHA256WithString:verifierStr];    
	
	return hashStr;
}


+ (NSString*)TJCSHA256CommonParamsWithTimeStamp:(NSString*)timeStamp tapPointsAmount:(int)points guid:(NSString*)guid
{
	NSString *appID = [TapjoyConnect getAppID];
	
	NSString *keyStr = [TapjoyConnect getSecretKey];
	
	NSString *udid = [[NSString stringWithString:[[UIDevice currentDevice] uniqueIdentifier]] lowercaseString];
	
	NSString *amountStr = [NSString stringWithFormat:@"%d", points];
	
	NSString *verifierStr = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",
									 appID,
									 udid,
									 timeStamp,
									 keyStr,
									 amountStr,
									 guid];
	
	NSString *hashStr = [TapjoyConnect TJCSHA256WithString:verifierStr];    
	
	return hashStr;
}


+ (NSString*)TJCSHA256WithString:(NSString*)dataStr
{
	unsigned char SHAStr[CC_SHA256_DIGEST_LENGTH];
	
	CC_SHA256([dataStr UTF8String],
				 [dataStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
				 SHAStr);
	
	NSData *SHAData = [[NSData alloc] initWithBytes:SHAStr
														  length:sizeof(SHAStr)];
	
	//NSString *result = [HMAC TJCBase64EncodedString];
	NSString *result = [[SHAData description] stringByReplacingOccurrencesOfString:@" " withString:@""];
	result = [result substringWithRange:NSMakeRange(1, [result length] - 2)];
	
	[SHAData release];
	
	return result;
}


+ (NSString*)generateUUID
{
	// Create a new UUID
   CFUUIDRef uuidObj = CFUUIDCreate(nil);
   
	// Get the string representation of the UUID, making it lower-case.
   NSString	*uuidString = [[NSString stringWithString:(NSString*)CFUUIDCreateString(nil, uuidObj)] lowercaseString];
   
	CFRelease(uuidObj);
	
   return [uuidString autorelease];
}


- (void)dealloc 
{
	[appID_ release];
	[secretKey_ release];
	[userID_ release];
	[sharedInstance_ release];
	[data_ release];
	[connection_ release];
	
	[super dealloc];
}







#pragma mark delegate methods for asynchronous requests

- (void)connection:(NSURLConnection*) myConnection didReceiveResponse:(NSURLResponse*) myResponse;
{
	
}


- (void)connection:(NSURLConnection*) myConnection didReceiveData:(NSData*) myData;
{   
	if (data_) 
	{
		if (![data_ isKindOfClass: [NSMutableData class]]) 
		{
			data_ = [data_ mutableCopy];
			[data_ release];
		}
		
		[(NSMutableData *) data_ appendData: myData];
	}
	else 
	{
		data_ = [myData mutableCopy];
	}
}


- (void)connection:(NSURLConnection*) myConnection didFailWithError:(NSError*) myError;
{
	[connection_ release];
	connection_ = nil;
	
	if (connectAttempts_ >=2)
	{	
		[[NSNotificationCenter defaultCenter] postNotificationName:TJC_CONNECT_FAILED object:nil];
		return;
	}
	
	if(connectAttempts_ < 2)
	{	
		orignalRequest = TJC_SERVICE_URL_ALTERNATE;
		[[TapjoyConnect sharedTapjoyConnect] connectWithParam:[[TapjoyConnect sharedTapjoyConnect] genericParameters]];
	}
}


- (void)connectionDidFinishLoading:(NSURLConnection*) myConnection;
{
	[connection_ release];
	connection_ = nil;
	[self startParsing:data_];
	
}


- (void)startParsing:(NSData*) myData 
{
	NSData *xmlData = myData;//(Get XML as NSData)
	NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:xmlData] autorelease];
	[parser setDelegate:self];
	[parser parse];
}


- (void)parser:(NSXMLParser*)parser 
didStartElement:(NSString*)elementName 
  namespaceURI:(NSString*)namespaceURI 
 qualifiedName:(NSString*)qualifiedName 
    attributes:(NSDictionary*)attributeDict 
{
	currentXMLElement_ = elementName;
	if ([elementName isEqualToString:@"ErrorMessage"])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:TJC_CONNECT_FAILED object:nil];
	}
}


- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string
{
	if([currentXMLElement_ isEqualToString:@"Success"] && [string isEqualToString:@"true"])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:TJC_CONNECT_SUCCESS object:nil];
	}
}


- (void) parser:(NSXMLParser*)parser 
  didEndElement:(NSString*)elementName
   namespaceURI:(NSString*)namespaceURI 
  qualifiedName:(NSString*)qName
{
	
}


@end