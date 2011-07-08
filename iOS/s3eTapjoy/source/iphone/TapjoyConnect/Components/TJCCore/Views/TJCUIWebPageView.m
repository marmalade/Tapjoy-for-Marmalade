//
//  TJCUIWabPageView.m
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
//

#import "TJCUIWebPageView.h"
#import "TJCLog.h"
#import "TJCConstants.h"
#import "TapjoyConnect.h"

@implementation TJCUIWebPageView

@synthesize activityIndicator = activityIndicator_;
@synthesize alertErrorMessage = alertErrorMessage_;
@synthesize lastURL = lastURL_;


-(void) checkActivityIndicator:(NSTimer *)timer
{
	if(![activityIndicator_ isAnimating]) //Condition will be true when Page load is completed
	{	
		@synchronized(checkPageLoadCompletionTimer_)
		{
			[checkPageLoadCompletionTimer_ invalidate];
			checkPageLoadCompletionTimer_ = nil;
		}	
		//[TJCLog logWithLevel:LOG_DEBUG format:@"Page Load Completed"];
		
		if(delegate_)
		{
			if([delegate_ respondsToSelector:@selector(tjcUIWebPageViewwebRequestCompleted)])
			{
				[TJCLog logWithLevel:LOG_DEBUG format:@"TJC: Custom Web Request Completed over ridden"];
				[delegate_ performSelector:@selector(tjcUIWebPageViewwebRequestCompleted)];
			}	
		}
	}
}


-(id) initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		cWebView_ = [[UIWebView alloc] initWithFrame:frame];
		
		[cWebView_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		cWebView_.delegate = self;
		[self addSubview:cWebView_];
		
		checkPageLoadCompletionTimer_ = [NSTimer scheduledTimerWithTimeInterval: 2
																							  target: self
																							selector: @selector(checkActivityIndicator:)
																							userInfo: nil
																							 repeats: YES];
		alertErrorMessage_ = nil;
	}
	return self;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType 
{	
	// If we see either tapjoy or linkshare host names, we won't open it externally. All other host names will open externally from the app.
	if ((CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_TAPJOY_HOST_NAME, kCFCompareCaseInsensitive).length > 0) ||
		 (CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_TAPJOY_ALT_HOST_NAME, kCFCompareCaseInsensitive).length > 0) ||
		 (CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_LINKSHARE_HOST_NAME, kCFCompareCaseInsensitive).length > 0))
	{
		return YES;
	}
	
	// Open the link externally.
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[request URL]] 
																			  delegate:self 
																	startImmediately:YES];
	[conn release];
	return NO;
}


- (NSString*)appendGenericParamsWithURL:(NSString*)theURL
{
	NSString *result = [NSString stringWithFormat:@"%@%@", 
							  theURL, 
							  [[TapjoyConnect sharedTapjoyConnect] createQueryStringFromDict:[[TapjoyConnect sharedTapjoyConnect] genericParameters]]];
	
	return result;
}

-(id) initWithFrame:(CGRect)aFrame WithRequestURL:(NSURLRequest*) aRequest
{
	if((self = [self initWithFrame:aFrame]))
	{
		[cWebView_ loadRequest:aRequest];
		lastClickedURL_ = aRequest;
	}
	return self;
}


-(void)loadWebRequest:(NSURLRequest *)aRequest
{
	[cWebView_ loadRequest:aRequest];
	//lastClickedURL_ = [aRequest retain];
}


-(void)loadURLRequest:(NSURL*)requestURL
{
	NSURLRequest * myRequest = [NSURLRequest requestWithURL:requestURL];
	[cWebView_ loadRequest:myRequest];
	//lastClickedURL_ = [myRequest retain];
}


-(void)loadURLRequest:(NSURL*)requestURL withTimeOutInterval:(int)tInterval
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"Request URL: %@",[requestURL absoluteString]];
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:requestURL 
																				cachePolicy:NSURLRequestUseProtocolCachePolicy 
																		  timeoutInterval:tInterval];
	[cWebView_ loadRequest:myRequest];
	//lastClickedURL_ = [myRequest retain];
}


-(void) setDelegate:(id) aDelegate
{
	delegate_ = aDelegate;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
	
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[webView stringByEvaluatingJavaScriptFromString:@"document.body.setAttribute('orientation', 90);"];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	//lastClickedURL_ = [webView request];
	if (error.code == NSURLErrorCancelled) return; //error 999 fast clicked the links
	
	[TJCLog logWithLevel:LOG_DEBUG format:@"ERROR TEXT IS %@",[error description]];
	
	if(error.code == 102) return;//sum bug solved in 4.0 need to confirm
	
	NSString *msg = alertErrorMessage_;
	if(!msg) msg = @"Service is unreachable.\nDo you want to try again?";
	UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
	[alertview show];
	[alertview release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJC CUSTOM WEB Page View Alert Click Called (Net Error Case)"];
	if(buttonIndex == 1)
	{
		[cWebView_ stopLoading];
		[cWebView_ loadRequest:lastClickedURL_]; 
	}
	else if(buttonIndex == 0) 
	{
		if(delegate_)
		{
			if([delegate_ respondsToSelector:@selector(tjcUIWebPageViewwebRequestCanceled)])
			{
				[TJCLog logWithLevel:LOG_DEBUG format:@"TJC: Custom Web Request Completed over ridden"];
				[delegate_ performSelector:@selector(tjcUIWebPageViewwebRequestCanceled)];
			}
			@synchronized(checkPageLoadCompletionTimer_)
			{
				[checkPageLoadCompletionTimer_ invalidate];
				checkPageLoadCompletionTimer_ = nil;
			}
		}
	}
}


-(void) dealloc
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCUIWebPageView Dealloc"];
	delegate_ = nil; // set delegate to nil; 
	
	//stop the web view 
	[cWebView_ release];
	
	//invalidate the timer if exists 
	@synchronized(checkPageLoadCompletionTimer_)
	{
		[checkPageLoadCompletionTimer_ invalidate];
	}
	
	[activityIndicator_ release];
	[loadingPage_ release];	
	[loadingLbl_ release];
	[alertErrorMessage_ release];
	[lastURL_ release];
	[super dealloc];
}


@end
