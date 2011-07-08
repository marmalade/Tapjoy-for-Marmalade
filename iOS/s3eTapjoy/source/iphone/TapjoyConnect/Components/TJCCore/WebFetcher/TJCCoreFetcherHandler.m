//
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
//

#import "TJCLog.h"
#import "TJCCoreFetcherHandler.h"
#import "TJCCoreFetcher.h"
#import "TJCUtil.h"
#import "TBXML.h"

NSString *kTJCCoreFetcherReturnObjStr = @"TapjoyConnectReturnObject";
NSString *kTJCCoreFetcherAdStr = @"TapjoyAd";


@implementation TJCCoreFetcherHandler

-(id) initRequestWithDelegate:(id<TJCFetchResponseDelegate>) aDelegate andRequestTag:(int)aTag
{
	if ((self = [super init]))
	{
		deleg_ = aDelegate;
		requestTag_ = aTag;
		myFetcher_ = nil;
	}	
	return self;
}


- (void)makeGenericRequestWithURL:(NSString *)aRequestString 
							alternateURL:(NSString*)alterURL 
									params:(NSMutableDictionary *)aParamsList 
								 selector:(SEL)aSelector
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"My Base URL is %@",myFetcher_.baseURL];
	
	if (myFetcher_)
	{
		myFetcher_.fetcherDelegate = nil;
		[myFetcher_ release];
		myFetcher_ = nil;
	}	
	
	myFetcher_ = [[TJCCoreFetcher alloc] init];
	myFetcher_.requestTag = requestTag_;
	myFetcher_.fetcherDelegate = self;
	myFetcher_.requestTimeout = 10;
	myFetcher_.requestMethod = @"GET";
	myFetcher_.postParameters = aParamsList;
	myFetcher_.baseURL = aRequestString;
	myFetcher_.alternateURL = alterURL;
	
	if(aParamsList)
		myFetcher_.bindings = aParamsList;
	
	NSInvocation *invoker = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
	[invoker setTarget:self];
	[invoker setSelector:aSelector];
	[invoker setArgument:&myFetcher_ atIndex:2];
	[myFetcher_ fetchAsynchronouslyWithCompletionInvocation:invoker];
}


- (void) makeGenericPOSTRequestWithURL:(NSString *)aRequestString 
								  alternateURL:(NSString *)alterURL
											 data:(NSData*)data
										  params:(NSMutableDictionary *)aParamsList 
										selector:(SEL)aSelector
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"My Base URL is %@",myFetcher_.baseURL];
	
	if(myFetcher_)
	{
		myFetcher_.fetcherDelegate = nil;
		[myFetcher_ release];
		myFetcher_ = nil;
	}   
	
	myFetcher_ = [[TJCCoreFetcher alloc] init];
	myFetcher_.requestTag = requestTag_;
	myFetcher_.fetcherDelegate = self;
	myFetcher_.requestTimeout = 10;
	myFetcher_.requestMethod = @"POST";
	myFetcher_.postParameters = aParamsList;
	myFetcher_.baseURL = aRequestString;
	myFetcher_.alternateURL = alterURL;
	myFetcher_.POSTdata = data;
	
	NSInvocation *invoker = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
	[invoker setTarget:self];
	[invoker setSelector:aSelector];
	[invoker setArgument:&myFetcher_ atIndex:2];
	[myFetcher_ fetchAsynchronouslyWithCompletionInvocation:invoker];
}


-(void) setFetchersDelegate:(id)aDeleg
{
	//Parent delegate is set to nil
	if(aDeleg==nil)
		myFetcher_.fetcherDelegate = nil;
	
	deleg_ = aDeleg;
}


- (TBXMLElement*) parseReturnObjectAsTBXMLElement:(TJCCoreFetcher *) myFetcher;
{
	//NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
	if ([myFetcher hasError]) 
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; Error while attempting to fetch data from server: %@", 
		 __FILE__, __LINE__, __PRETTY_FUNCTION__, [[myFetcher error] description]];
		
		return nil;
	}
	
	NSUInteger statusCode = [(NSHTTPURLResponse*)[myFetcher response] statusCode];
	if (!(statusCode== 200))
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; Unexpected HTTP response status code while attempting to fetch data from server:: Status Code = %d", 
		 __FILE__, __LINE__, __PRETTY_FUNCTION__, statusCode];
		
		return nil;
	}
	
	NSData * myData = [myFetcher data];
	if (!myData) 
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch data from server.", 
		 __FILE__, __LINE__, __PRETTY_FUNCTION__];
		return nil;
	}
	
	TBXML *responseXML = [TBXML tbxmlWithXMLData:myFetcher.data];
	
	if (responseXML && [responseXML rootXMLElement])
	{
		return [responseXML rootXMLElement];
	}
	
	return nil; // No Data found
}


-(TBXMLElement*) validateResponseReturnedObject:(TJCCoreFetcher*) myFetcher
{
	TBXMLElement *returnObj = [self parseReturnObjectAsTBXMLElement:myFetcher];
	
	if(returnObj == nil)
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", 
		 __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCInternetFailure errorDescription:nil requestTag:myFetcher.requestTag];
		return nil;
	}
	
	//TBXMLElement *connectRetObj = [ret]
	
	NSString *connectReturnObj = [TBXML elementName:returnObj]; 
	
	if ((![TJCUtil caseInsenstiveCompare:connectReturnObj AndString2:kTJCCoreFetcherReturnObjStr]) &&
		 (![TJCUtil caseInsenstiveCompare:connectReturnObj AndString2:kTJCCoreFetcherAdStr]))
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", 
		 __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return nil;
	}
	
	TBXMLElement *errorElement = [TBXML childElementNamed:@"ErrorMessage" parentElement:returnObj];
	
	if(errorElement)
	{
		[TJCLog logWithLevel: LOG_NONFATAL_ERROR
						  format: @"%s: %d; %s; No data received while attempting to fetch the data from the server", 
		 __FILE__, __LINE__, __PRETTY_FUNCTION__];
		
		[deleg_ fetchResponseError:kTJCStatusNotOK errorDescription:nil requestTag:myFetcher.requestTag];
		return nil;
	}
	
	return returnObj;
}


- (void) makeRequestWithURL:(TJCCoreFetcher *)myFetcher withInvoker:(NSInvocation *)invoker
{
	myFetcher.data = nil;
	myFetcher.requestTimeout = 30;
	myFetcher.error = FALSE;
	
	[TJCLog logWithLevel:LOG_DEBUG format:@"My Base URL is %@",myFetcher.baseURL];
	
	[myFetcher fetchAsynchronouslyWithCompletionInvocation:invoker];
}


- (void)dealloc
{
	deleg_ = nil;
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCCoreFetcher dealloc"];
	
	myFetcher_.fetcherDelegate = nil;
	[myFetcher_ release];
	myFetcher_ = nil;
	
	[super dealloc];
}


@end
