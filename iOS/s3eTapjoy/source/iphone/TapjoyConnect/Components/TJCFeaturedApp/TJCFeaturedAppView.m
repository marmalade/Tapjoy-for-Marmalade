//
//  TJCUIWebPageAdView.m
//
//  Created by Tapjoy on 10/20/10.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import "TJCFeaturedAppView.h"
#import "TapjoyConnect.h"
#import "TJCConstants.h"
#import "TJCLog.h"
#import "TJCOffersViewHandler.h"


static NSString *currentServiceURL = nil;
static TJCFeaturedAppView *sharedTJCFeaturedAppView_ = nil;

@implementation TJCFeaturedAppView

@synthesize publisherUserID_;

+ (TJCFeaturedAppView*) sharedTJCFeaturedAppView
{
	if (!sharedTJCFeaturedAppView_) 
	{
		sharedTJCFeaturedAppView_ = [[super alloc] init];
	}
	
	return sharedTJCFeaturedAppView_;
}


- (id)initWithFrame:(CGRect)frame
{
	[self refreshWithFrame:frame];
	return self;
}


- (void)refreshWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		currentServiceURL = [self setUpFeaturedAdURLWithServiceURL:TJC_FEATURED_FULLSCREEN_SERVICE_URL];
		
		// Touch is not yet enabled for the webview and will not be until the page has loaded.
		[cWebView_ setUserInteractionEnabled:NO];
		[cWebView_ setScalesPageToFit:YES];
		[cWebView_ setAutoresizesSubviews: YES];
		
		if (activityIndicator_)
		{
			[activityIndicator_ release];
			activityIndicator_ = nil;
		}
		activityIndicator_ = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width - TJCUIWEBPAGE_ACTIVITY_INDICATOR_SIZE) / 2,
																												 (frame.size.height - TJCUIWEBPAGE_ACTIVITY_INDICATOR_SIZE) / 2,
																												 TJCUIWEBPAGE_ACTIVITY_INDICATOR_SIZE,
																												 TJCUIWEBPAGE_ACTIVITY_INDICATOR_SIZE)];
		// Set the resize mask for rotation.
		[activityIndicator_ setAutoresizingMask:
		 UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
		 UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
		[activityIndicator_ setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		
		if (loadingPage_)
		{
			[loadingPage_ release];
			loadingPage_ = nil;
		}
		loadingPage_ = [[UIView alloc] initWithFrame:frame];
		[loadingPage_ setBackgroundColor:[UIColor blackColor]];
		[loadingPage_ setAlpha:0.0f];
		
		loadingPage_.layer.frame = CGRectMake((frame.size.width - TJCUIWEBPAGE_ACTIVITY_RECT_SIZE) / 2,
														  (frame.size.height - TJCUIWEBPAGE_ACTIVITY_RECT_SIZE) / 2,
														  TJCUIWEBPAGE_ACTIVITY_RECT_SIZE,
														  TJCUIWEBPAGE_ACTIVITY_RECT_SIZE);
		loadingPage_.layer.cornerRadius = 16.0f;
		loadingPage_.layer.opacity = 0.0f;
		// Set the resize mask for rotation.
		[loadingPage_ setAutoresizingMask:
		 UIViewAutoresizingFlexibleTopMargin |
		 UIViewAutoresizingFlexibleBottomMargin |
		 UIViewAutoresizingFlexibleLeftMargin |
		 UIViewAutoresizingFlexibleRightMargin];
		
		// Make a label with the "loading" word in it.
		NSString *loadingStr = @"Loading...";
		float loadingStrFontSize = 14;
		
		if (loadingLbl_)
		{
			[loadingLbl_ release];
			loadingLbl_ = nil;
		}
		loadingLbl_ = [[UILabel alloc] initWithFrame:CGRectMake(0,
																				  0,
																				  [loadingStr sizeWithFont:[UIFont boldSystemFontOfSize:loadingStrFontSize]].width,
																				  [loadingStr sizeWithFont:[UIFont boldSystemFontOfSize:loadingStrFontSize]].height)];
		[loadingLbl_ setCenter:CGPointMake(TJCUIWEBPAGE_ACTIVITY_RECT_SIZE / 2, 
													  TJCUIWEBPAGE_ACTIVITY_RECT_SIZE - 
													  ([loadingStr sizeWithFont:[UIFont boldSystemFontOfSize:loadingStrFontSize]].height / 2))];
		[loadingLbl_ setText:loadingStr];
		[loadingLbl_ setFont:[UIFont boldSystemFontOfSize:loadingStrFontSize]];
		[loadingLbl_ setTextColor:[UIColor whiteColor]];
		[loadingLbl_ setBackgroundColor:[UIColor clearColor]];
		[loadingPage_ addSubview:loadingLbl_];
		
		[self addSubview:loadingPage_];
		[self addSubview:activityIndicator_];
		
		// Initialize the back button and add it to the view.
		//UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		backButton.frame = CGRectMake(frame.size.width - FULLSCREEN_AD_BORDER_SIZE - FULLSCREEN_AD_BACK_BUTTON_SIZE, 
												FULLSCREEN_AD_BORDER_SIZE, 
												FULLSCREEN_AD_BACK_BUTTON_SIZE, 
												FULLSCREEN_AD_BACK_BUTTON_SIZE);
		[backButton addTarget:self action:@selector(backtoGameAction:) forControlEvents:UIControlEventTouchUpInside];
		[backButton setBackgroundColor:[UIColor clearColor]];
		[backButton setImage:[UIImage imageNamed:@"close_button.png"] forState:UIControlStateNormal];
		[backButton setAutoresizingMask:
		 UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |
		 UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
		
		[self addSubview:backButton];
		
		self.layer.borderColor = [UIColor darkGrayColor].CGColor;
		self.layer.borderWidth = FULLSCREEN_AD_BORDER_SIZE;
		
		[self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
	}
}


- (NSString*)setUpFeaturedAdURLWithServiceURL:(NSString*)serviceURL
{
	NSString *result = [self appendGenericParamsWithURL:serviceURL];
	
	result = [NSString stringWithFormat:
				 @"%@&%@=%@",
				 result,
				 TJC_URL_PARAM_USER_ID,
				 publisherUserID_];
	
	return result;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// The retry button action.
	if(buttonIndex == 1)
	{
		[activityIndicator_ startAnimating];
		[cWebView_ stopLoading];
		
		// Load the last url that was attempted.
		if (!lastURL_)
		{
			currentServiceURL = [self setUpFeaturedAdURLWithServiceURL:TJC_FEATURED_FULLSCREEN_SERVICE_URL];
		}
		else
		{
			// Check for valid url.
			if ([NSURL URLWithString:lastURL_])
			{
				// Valid URL, proceed.
				currentServiceURL = [NSString stringWithString:lastURL_];
				//NSLog(@"Retry URL: %@", lastURL_);
			}
			else
			{
				// Invalid URL, use default one.
				currentServiceURL = [self setUpFeaturedAdURLWithServiceURL:TJC_FEATURED_FULLSCREEN_SERVICE_URL];
			}
			
			[lastURL_ release];
			lastURL_ = nil;
		}
		
		[self loadViewWithURL:currentServiceURL];
	}
	// The cancel button action.
	else if(buttonIndex == 0) 
	{
		//Stop Activity Indicator
		[activityIndicator_ stopAnimating];
		[loadingPage_ setAlpha:0.0f];
		loadingPage_.layer.opacity = 0.0f;		
		
		// Re-enable user touch interaction so that they may click on another link to try again if so desired.
		[cWebView_ setUserInteractionEnabled:YES];
		
		//re-intitialize webview
		//[self handleWebViewUI];
	}
}


- (void) loadViewWithURL:(NSString*)theURL
{
	[self setBackgroundColor:[UIColor whiteColor]];
	
	//initialize WebView UI
	[self initializeWebViewUI];
	
	[self loadURLRequest:[NSURL URLWithString:theURL] withTimeOutInterval:TJC_REQUEST_TIME_OUT];
}





#pragma mark OverRidden Connection Methods

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	if (error.code == NSURLErrorCancelled) 
	{
		return; //error 999 fast clicked the links
	}
	
	// 102 error code for slow request completion. This happens when a NSURLConnection is made for opening links externally in Safari.
	if(error.code == 102) 
	{
		return;
	}
	
	if(currentServiceURL == TJC_FEATURED_FULLSCREEN_SERVICE_URL)
	{
		currentServiceURL = [self setUpFeaturedAdURLWithServiceURL:TJC_FEATURED_FULLSCREEN_SERVICE_ALTERNATE_URL];
		[self loadViewWithURL:currentServiceURL];
	}
	else
	{
		NSString *msg = alertErrorMessage_;
		if(!msg) msg = @"Service is unreachable.\nDo you want to try again?";
		UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"" 
																			  message:msg 
																			 delegate:self 
																 cancelButtonTitle:@"Cancel" 
																 otherButtonTitles:@"Retry", nil];
		[alertview show];
		[alertview release];
		
		//Stop Activity Indicator
		[activityIndicator_ stopAnimating];
		
		[loadingPage_ setAlpha:0.0f];
		loadingPage_.layer.opacity = 0.0f;
		
		// Disable user touch interaction.
		[webView setUserInteractionEnabled:NO];
	}
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	//NSLog(@"URL host: %@", [[request URL] host]);
	
	if (!request)
	{
		return NO;
	}
	
	//NSString *requestString = [NSString stringWithContentsOfURL:[request URL] encoding:NSUTF8StringEncoding error:NULL];
	NSString *requestString = [[request URL] absoluteString];
	
	if (CFStringFind((CFStringRef)requestString, (CFStringRef)@"dismiss", kCFCompareCaseInsensitive).length > 0)
	{
		[self backtoGameAction:nil];
		return NO;
	}
	else if (CFStringFind((CFStringRef)requestString, (CFStringRef)@"showOffers", kCFCompareCaseInsensitive).length > 0)
	{
		[self addSubview:[TJCOffersViewHandler showOffersWithFrame:[self frame]]];
		return NO;
	}
	// If we see either tapjoy or linkshare host names, we won't open it externally. All other host names will open externally from the app.
	else if ((CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_TAPJOY_HOST_NAME, kCFCompareCaseInsensitive).length > 0) ||
				(CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_TAPJOY_ALT_HOST_NAME, kCFCompareCaseInsensitive).length > 0) ||
				(CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_LINKSHARE_HOST_NAME, kCFCompareCaseInsensitive).length > 0))
	{
		if (lastURL_)
		{
			[lastURL_ release];
			lastURL_ = nil;
		}
		
		// Save the address in case data connection craps out and we need to reload.
		lastURL_ = [[NSString alloc] initWithString:[[request URL] absoluteString]];
		
		return YES;
	}
	
	// Open the link externally.
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[request URL]] 
																			  delegate:self 
																	startImmediately:YES];
	[conn release];
	return NO;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[activityIndicator_ startAnimating];
	
	// Make the loading view fade in smoothly.
	[loadingPage_ setAlpha:LOADING_PAGE_END_ALPHA];
	loadingPage_.layer.opacity = LOADING_PAGE_END_ALPHA;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:LOADING_PAGE_FADE_TIME];
	[loadingPage_ setAlpha:LOADING_PAGE_START_ALPHA];
	loadingPage_.layer.opacity = LOADING_PAGE_START_ALPHA;
	[UIView commitAnimations];	
	
	// Disable user touch interaction.
	[webView setUserInteractionEnabled:NO];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	webPageRendered_ = true;
	[activityIndicator_ stopAnimating];
	
	// Make the loading view fade in smoothly.
	[loadingPage_ setAlpha:LOADING_PAGE_START_ALPHA];
	loadingPage_.layer.opacity = LOADING_PAGE_START_ALPHA;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:LOADING_PAGE_FADE_TIME];
	[loadingPage_ setAlpha:LOADING_PAGE_END_ALPHA];
	loadingPage_.layer.opacity = LOADING_PAGE_END_ALPHA;
	[UIView commitAnimations];	
	
	// Re-enable user touch interaction.
	[webView setUserInteractionEnabled:YES];
}


- (NSURLRequest*)connection:(NSURLConnection*)connection 
				willSendRequest:(NSURLRequest*)request 
			  redirectResponse:(NSURLResponse*)response
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"Featured App URL::::::%@",[[request URL]absoluteURL]];
	
	externalURL_ = [request URL];
	
	return request;
}


- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"OPENING URL NOW ::::::%@",externalURL_];
	
	[activityIndicator_ stopAnimating];
	
	[loadingPage_ setAlpha:0.0f];
	loadingPage_.layer.opacity = 0.0f;
	
	// Before we go to itunes, remove the offers view.
	[self removeFromSuperview];
	[[NSNotificationCenter defaultCenter] postNotificationName:TJC_SHOW_BOX_CLOSE_NOTIFICATION object:nil];
	
	// Open up itunes. This will effectively place this app in the background.
	[[UIApplication sharedApplication] openURL:externalURL_];
	
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSString *msg = alertErrorMessage_;
	if(!msg) msg = @"Service is unreachable.\nDo you want to try again?";
	UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"" 
																		  message:msg 
																		 delegate:self 
															 cancelButtonTitle:@"Cancel" 
															 otherButtonTitles:@"Retry", nil];
	[alertview show];
	[alertview release];
	
	//Stop Activity Indicator
	[activityIndicator_ stopAnimating];
	
	[loadingPage_ setAlpha:0.0f];
	loadingPage_.layer.opacity = 0.0f;
	
	// Disable user touch interaction.
	[cWebView_ setUserInteractionEnabled:NO];
}


-(void) backtoGameAction:(id) sender
{
	//stop the timers it has started
	@synchronized(checkPageLoadCompletionTimer_)
	{
		[checkPageLoadCompletionTimer_ invalidate];
		checkPageLoadCompletionTimer_ = nil;
	}
	[[self class] cancelPreviousPerformRequestsWithTarget:self];
	[TJCViewCommons animateTJCView:self 
					 withTJCTransition:[[TJCViewCommons sharedObject]getReverseTransitionEffect] 
								withDelay:[[TJCViewCommons sharedObject]getTransitionDelay]];
	[self performSelector:@selector(giveBackNotification) withObject:nil afterDelay:[[TJCViewCommons sharedObject]getTransitionDelay]];
}


-(void) giveBackNotification
{	
	[self removeFromSuperview];
	[[NSNotificationCenter defaultCenter] postNotificationName:TJC_SHOW_BOX_CLOSE_NOTIFICATION object:nil];
}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[cWebView_ stringByEvaluatingJavaScriptFromString:@"window.onorientationchange();"];
}



#pragma mark UIHandling

-(void) handleWebViewUI
{
	[self initializeWebViewUI];
	[[self class]cancelPreviousPerformRequestsWithTarget:self];
}


- (void) initializeWebViewUI
{
	if(webPageRendered_) 
		return; 
	
	//[cWebView_ setAlpha:0];
	
	//[cWebView_ setFrame:CGRectMake(0, yShift, 0, 0)]; //intial size set to zero..does the tweak if initialized from landscape
}


- (void)dealloc 
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCOffersView Dealloc"];
	[publisherUserID_ release];
	[externalURL_ release];
	[super dealloc];
}


@end
