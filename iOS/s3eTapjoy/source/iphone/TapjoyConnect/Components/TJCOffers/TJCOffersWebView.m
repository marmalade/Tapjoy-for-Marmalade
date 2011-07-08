//
//  TJCOffersWebView.m
//  TapjoyConnect
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
//

#import "TJCOffersWebView.h"
#import "TJCConstants.h"
#import "TJCUINavigationBarView.h"
#import "TapjoyConnect.h"
#import "TJCLog.h"
#import "TJCUtil.h"
#import "TJCViewCommons.h"

static TJCOffersWebView *sharedTJCOffersWebView_ = nil;
static NSString *currentServiceURL = nil;


@implementation TJCOffersWebView

@synthesize publisherUserID_, parentVController_, isViewVisible_, currencyID_, isSelectorVisible_;
@synthesize navBar = navBar_;


+ (TJCOffersWebView*) sharedTJCOffersWebView
{
	if (!sharedTJCOffersWebView_) 
	{
		sharedTJCOffersWebView_ = [[super alloc] init];
		// Init here in case access to local variables is needed. For instance, if a custom bg image is set before the view is actually shown.
		[sharedTJCOffersWebView_ initWithFrame:[[UIScreen mainScreen] bounds] enableNavBar:YES];
	}
	return sharedTJCOffersWebView_;
}


- (id)initWithFrame:(CGRect)frame enableNavBar:(BOOL)enableNavigationBar
{
	[self refreshWithFrame:frame enableNavBar:enableNavigationBar];
	return self;
}


- (void)refreshWithFrame:(CGRect)frame enableNavBar:(BOOL)enableNavigationBar
{
	if ((self = [super initWithFrame:frame]))
	{
		currentServiceURL = [self setUpOffersURLWithServiceURL:TJC_WEBOFFERS_SERVICE_URL];
		
		cWebView_.scalesPageToFit = TRUE;
		cWebView_.autoresizesSubviews = YES;
		// Touch is not yet enabled for the webview and will not be until the page has loaded.
		[cWebView_ setUserInteractionEnabled:NO];
		
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
		 UIViewAutoresizingFlexibleTopMargin |
		 UIViewAutoresizingFlexibleBottomMargin |
		 UIViewAutoresizingFlexibleLeftMargin |
		 UIViewAutoresizingFlexibleRightMargin];
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
		
		if(enableNavigationBar)
		{
			if (!navBar_)
			{
				navBar_ = [[TJCUINavigationBarView alloc] initWithTitle:@"" withFrame:frame AtY:0];
				
				[navBar_ setNavBarLeftBtnWithTitle:@"Back"];
				[navBar_ addLeftButtonTarget:self action:@selector(backtoGameAction:) forControlEvents:UIControlEventTouchUpInside];
			}
			
			[self addSubview:navBar_];
		}
		enableNavBar = enableNavigationBar;
	}
}


- (void)setCustomNavBarImage:(UIImage*)image
{
	[navBar_ setCustomBackgroundImage:image];
}


- (NSString*)setUpOffersURLWithServiceURL:(NSString*)serviceURL
{
	NSString *result = [self appendGenericParamsWithURL:serviceURL];
	
	result = [NSString stringWithFormat:
				 @"%@&%@=%@",
				 result,
				 TJC_URL_PARAM_USER_ID,
				 publisherUserID_];
	
	if ([currencyID_ length] > 0)
	{
		result = [NSString stringWithFormat:@"%@&%@", result, currencyID_];
	}
	
	if ([isSelectorVisible_ length] > 0)
	{
		result = [NSString stringWithFormat:@"%@&%@", result, isSelectorVisible_];
	}
	
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
			currentServiceURL = [self setUpOffersURLWithServiceURL:TJC_WEBOFFERS_SERVICE_URL];
		}
		else
		{
			// Check for valid url.
			if ([NSURL URLWithString:lastURL_])
			{
				// Valid URL, proceed.
				currentServiceURL = [NSString stringWithString:lastURL_];
				//NSLog(@"Retry URL: %@", lastURL_);
				[TJCLog logWithLevel: LOG_DEBUG
								  format: @"%s: %d; %s; Retry URL:%@", __FILE__, __LINE__, __PRETTY_FUNCTION__, lastURL_];
			}
			else
			{
				// Invalid URL, use default one.
				currentServiceURL = [self setUpOffersURLWithServiceURL:TJC_WEBOFFERS_SERVICE_URL];
			}
			
			[lastURL_ release];
			lastURL_ = nil;
		}
		
		
		[self loadView]; 
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
	}
}


- (void) loadView
{
	//initialize WebView UI
	int shiftVal = 0;
	
	// Set the shift amount depending on whether there is a navigation bar or not.
	if (enableNavBar)
	{
		shiftVal = TJC_NAV_BAR_HEIGHT;
	}
	
	if (parentVController_)
	{
		[navBar_ setFrame:CGRectMake(navBar_.frame.origin.x, navBar_.frame.origin.y, parentVController_.view.bounds.size.width, navBar_.frame.size.height)];
		[cWebView_ setFrame:CGRectMake(0, shiftVal, parentVController_.view.bounds.size.width, parentVController_.view.bounds.size.height - shiftVal)];
	}
	else
	{
		[navBar_ setFrame:CGRectMake(navBar_.frame.origin.x, navBar_.frame.origin.y, self.bounds.size.width, navBar_.frame.size.height)];
		[cWebView_ setFrame:CGRectMake(0, shiftVal, self.bounds.size.width, self.bounds.size.height - shiftVal)];
	}
	
	[self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
	
	[self loadURLRequest:[NSURL URLWithString:currentServiceURL] withTimeOutInterval:TJC_REQUEST_TIME_OUT];
}



- (void) refreshWebView
{
	NSString * offersURL = [self setUpOffersURLWithServiceURL:TJC_WEBOFFERS_SERVICE_URL];
	
	[self loadURLRequest:[NSURL URLWithString:offersURL] withTimeOutInterval:TJC_REQUEST_TIME_OUT];
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
	
	// Something failed with the default URL, try the alternate one.
	if(currentServiceURL == TJC_WEBOFFERS_SERVICE_URL)
	{
		currentServiceURL = [self setUpOffersURLWithServiceURL:TJC_WEBOFFERS_SERVICE_ALTERNATE_URL];		
		[self loadView];
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
	
	// If we see either tapjoy or linkshare host names, we won't open it externally. All other host names will open externally from the app.
	if ((CFStringFind((CFStringRef)[[request URL] host], (CFStringRef)TJC_TAPJOY_HOST_NAME, kCFCompareCaseInsensitive).length > 0) ||
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
	isViewVisible_ = YES;
	
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
	
	// Pull the title for the Offers view from the html title tag.
	[[navBar_ navBarTitle] setTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
	
	// Make it fade in smoothly.
	[[navBar_ navBarTitle] titleView].alpha = 0.0f;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[[navBar_ navBarTitle] titleView].alpha = 1.0f;
	[UIView commitAnimations];	
}


- (NSURLRequest*)connection:(NSURLConnection*)connection 
				willSendRequest:(NSURLRequest*)request 
			  redirectResponse:(NSURLResponse*)response
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"Offers URL::::::%@",[[request URL]absoluteURL]];
	
	externalURL_ = [request URL];
	
	return request;
}


- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
	// If the view has been dismissed, then don't open the link.
	if (!isViewVisible_)
	{
		[connection cancel];
		return;
	}
	
	[TJCLog logWithLevel:LOG_DEBUG format:@"OPENING URL NOW ::::::%@",externalURL_];
	
	[activityIndicator_ stopAnimating];
	
	[loadingPage_ setAlpha:0.0f];
	loadingPage_.layer.opacity = 0.0f;
	
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
	isViewVisible_ = NO;
	
	[self removeFromSuperview];
	[[NSNotificationCenter defaultCenter] postNotificationName:TJC_SHOW_BOX_CLOSE_NOTIFICATION object:nil];
}


- (void)dealloc 
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCOffersView Dealloc"];
	[publisherUserID_ release];
	[navBar_ release];
	[externalURL_ release];
	[super dealloc];
}


@end