//
//  TJCCoreFetcher.m
//
//  Created by Tapjoy 4/30/2010
//  Copyright 2010 Tapjoy.com All rights reserved.
//

#import "TJCCoreFetcher.h"

@implementation TJCCoreFetcher

@synthesize hasFetched = hasFetched_;
@synthesize baseURL = baseURL_;
@synthesize alternateURL = alternateURL_;
@synthesize bindings = bindings_;
@synthesize error = error_;
@synthesize data = data_;
@synthesize POSTdata = POSTdata_;
@synthesize response = response_;
@synthesize requestTimeout = requestTimeout_;
@synthesize connection = connection_;
@synthesize invocation = invocation_;
@synthesize requestMethod = requestMethod_;
@synthesize postParameters = postParameters_;
@synthesize retryCount = retryCount_;
@synthesize requestTag = requestTag_;
@synthesize fetcherDelegate = fetcherDelegate_;


// overridden superclass functionality
- (void) dealloc
{
	fetcherDelegate_ = nil;
	
	[baseURL_ release];
	[alternateURL_ release];
	[bindings_ release];
	[error_ release];
	[data_ release];
	if (response_)
	{
		[response_ release];
		response_ = nil;
	}
	[connection_ release];
	if(invocation_)
	{
		[invocation_ release];
		invocation_ = nil;
	}
	[requestMethod_ release];
	[postParameters_ release];
	[super dealloc];
}


- (id) init
{
	if (!(self = [super init])) 
	{
		return nil;
	}
	response_ = nil;
	retryCount_ = 0;
	requestMethod_ = [[NSString alloc] initWithString:@"GET"];
	
	return self;
}


-(void) setFetcherDelegate:(id) aDeleg_
{
	fetcherDelegate_ = aDeleg_;
}


- (void) fetchSynchronously
{
	@try 
	{
		NSURL * myURL = [NSURL URLWithString: [self requestURL]];
		
		NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL: myURL
																					cachePolicy: NSURLRequestUseProtocolCachePolicy
																			  timeoutInterval: requestTimeout_];
		
		[myRequest setHTTPMethod:requestMethod_];
		
		// synchronously request url and save resulting data, response, and error (if applicable)
		self.data = [NSURLConnection sendSynchronousRequest: myRequest
													 returningResponse: &response_
																	 error: &error_];
		[response_ retain];
	}
	@catch (NSException * exception) 
	{
		[TJCLog logWithLevel:LOG_DEBUG format:@"Exception: %@", [exception description]];
		
	}
	@finally
	{
		hasFetched_ = YES;
	}
}


- (void) fetchAsynchronouslyWithCompletionInvocation: (NSInvocation *) myInvocation
{
	@try
	{
		self.invocation = myInvocation;
		NSURL *myURL;      
		NSMutableURLRequest *urlRequest;
		
		[TJCLog logWithLevel:LOG_DEBUG format:@"Final URL = %@ ",[self requestURL]];
		
		myURL = [[NSURL alloc] initWithString:[self requestURL]];  // allocing url 2nd
		
		urlRequest = [NSMutableURLRequest requestWithURL: myURL
														 cachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData
													timeoutInterval: requestTimeout_];
		
		[urlRequest setHTTPMethod:requestMethod_];
		
		if (POSTdata_)
		{
			[urlRequest setHTTPBody:POSTdata_];
		}
		
		[myURL release];
		
		connection_ = [[NSURLConnection alloc] initWithRequest: urlRequest delegate: self];
	}
	@catch (NSException * exception) 
	{
		[TJCLog logWithLevel:LOG_DEBUG format:@"Exception: %@", [exception description]];
	}
}


- (NSCachedURLResponse *) connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse 
{
	// Returning nil will ensure that no cached response will be stored for the connection.
	// This is in case the cache is being used by something else.
	return nil;
}


- (NSString *) requestURL
{
	NSString * result = nil;
	NSString *requestURL;
	if (retryCount_ == 0)
	{
		requestURL = baseURL_;
	}
	else
	{
		requestURL = alternateURL_;
	}
	NSAssert3([requestURL length], @"%s: %d; %s; Precondition violated - [baseURL length] == 0",  __FILE__, __LINE__, __PRETTY_FUNCTION__);
	
	if (!bindings_) 
	{
		result = requestURL;
	} 
	else 
	{
		result = [NSString stringWithFormat: @"%@?%@", requestURL, [self urlEncodedBindings]];
	}
	
	result = [result stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	return result;
}


- (NSString *) urlEncodedBindings
{
	NSMutableString * result = [NSMutableString string];
	NSEnumerator * enumerator = [[bindings_ allKeys] objectEnumerator];
	NSString * bindingKey = nil;
	
	while ((bindingKey = [enumerator nextObject]))
	{
		id bindingValue = [bindings_ objectForKey: bindingKey];
		NSString * bindingString = nil;
		
		// confirm that we have a string
		if (![bindingValue isKindOfClass: [NSString class]])
		{
			if ([bindingValue respondsToSelector: @selector(stringValue)]) 
			{
				bindingValue = [bindingValue stringValue];
			} 
			else
			{
				bindingValue = [bindingValue description];
			}
		}
		
		// if we got here, we should have a string
		if (![bindingValue length]) 
		{
			bindingString = [NSString stringWithFormat: @"&%@=%@", bindingKey, bindingValue];
			[result appendString: bindingString];
			continue;
		}
		
		if ([result length]) 
		{
			// not the first binding - so prepend an &
			bindingString = [NSString stringWithFormat: @"&%@=%@", bindingKey, bindingValue];
		} 
		else 
		{
			// first binding
			bindingString = [NSString stringWithFormat: @"%@=%@", bindingKey, bindingValue];
		}
		
		if (bindingString) 
		{
			[result appendString: bindingString];
		}
		else
		{
			[TJCLog logWithLevel:LOG_DEBUG format:@"Error in URLEncodedBindings"];
		}
	}
	return result;
}


- (void) retry
{
	retryCount_++;
	if (alternateURL_ && invocation_)
	{
		[self fetchAsynchronouslyWithCompletionInvocation:invocation_];
	}
}


- (BOOL) hasError
{
	if (error_) 
	{
		return YES;
	}
	
	return NO;
}


- (NSInteger) responseStatusCode //  HTTP only
{
	if(!fetcherDelegate_) return 0;
	return [(NSHTTPURLResponse *)response_ statusCode];
}


- (NSString *) responseStatusCodeString // HTTP only
{
	if(!fetcherDelegate_) return nil;
	return [NSHTTPURLResponse localizedStringForStatusCode: [self responseStatusCode]];
}


#pragma mark delegate methods for asynchronous requests

- (void)connection:(NSURLConnection *) myConnection didReceiveResponse:(NSURLResponse *) myResponse
{
	if(!fetcherDelegate_) return;
	
	if (response_)
	{
		[response_ release];
		response_ = nil;
	}
	self.response = myResponse;
}


- (void)connection:(NSURLConnection *) myConnection didReceiveData:(NSData *) myData
{    
	if(!fetcherDelegate_) return;
	
	if (data_) 
	{
		if (![data_ isKindOfClass: [NSMutableData class]])
		{
			self.data = [data_ mutableCopy];
			[data_ release];
		}
		
		[(NSMutableData *) data_ appendData: myData];
	}
	else
	{
		data_ = [myData mutableCopy];
	}
}


- (void)connection:(NSURLConnection *) myConnection didFailWithError:(NSError *) myError
{
	if (retryCount_ < 1 && alternateURL_)
	{
		retryCount_++;
		
		//and what happens to the previous connection object ...must release it here
		[connection_ release];
		connection_ = nil;
		
		[self fetchAsynchronouslyWithCompletionInvocation:invocation_];
		return;
	}
	if(!fetcherDelegate_) return;
	
	hasFetched_ = YES;
	self.error = myError;
	[invocation_ invoke];
}

- (void)connectionDidFinishLoading:(NSURLConnection *) myConnection
{
	[connection_ release];
	connection_ = nil;
	
	if(!fetcherDelegate_) return;
	hasFetched_ = YES;
	if(invocation_!=nil)
		[invocation_ invoke];
	
}

@end
