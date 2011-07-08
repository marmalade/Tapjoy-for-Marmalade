//
//  TJCAdView.m
//
//  Created by Tapjoy on 9/28/10.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import "TJCAdView.h"
#import "TJCAdRequestHandler.h"
#import "SynthesizeSingleton.h"
#import "TapjoyConnect.h"
#import "TJCUtil.h"

static TJCAdView *sharedTJCAdView_ = nil;

@implementation TJCAdView


@synthesize clickURL = clickURL_;
@synthesize imageDataStr = imageDataStr_;
@synthesize imageView = imageView_;
@synthesize previousImageView = previousImageView_;
@synthesize contentSizeStr = contentSizeStr_;
@synthesize adViewOverlay = adViewOverlay_;
@synthesize adHandlerObj = adHandlerObj_;
@synthesize adDelegate = adDelegate_;


+ (TJCAdView*) sharedTJCAdView
{
	if(!sharedTJCAdView_)
	{
		sharedTJCAdView_ = [[super alloc] init];
	}
	
	return sharedTJCAdView_;
}

- (id) init
{
	if ((self = [super init]))
	{
		if (!adHandlerObj_)
		{
			adHandlerObj_ = [[TJCAdRequestHandler alloc] initRequestWithDelegate:self andRequestTag:0];
		}
		
		if (!adViewOverlay_)
		{
			adViewOverlay_ = [[UIView alloc] init];
			[adViewOverlay_ setAlpha:0.0f];
			[adViewOverlay_ setBackgroundColor:[UIColor blackColor]];
		}
	}
	return self;
}


+ (id) getAdWithDelegate:(id<TJCAdDelegate>)deleg
{
	if(!sharedTJCAdView_)
	{
		sharedTJCAdView_ = [[super alloc] init];
	}
	
	if (![sharedTJCAdView_ adHandlerObj])
	{
		sharedTJCAdView_.adHandlerObj = [[TJCAdRequestHandler alloc] initRequestWithDelegate:sharedTJCAdView_ andRequestTag:0];
	}
	
	if (![sharedTJCAdView_ adViewOverlay])
	{
		sharedTJCAdView_.adViewOverlay = [[UIView alloc] init];
		[[sharedTJCAdView_ adViewOverlay] setAlpha:0.0f];
		[[sharedTJCAdView_ adViewOverlay] setBackgroundColor:[UIColor blackColor]];
	}
	
	// Set the ad delegate. The didRecieveAd method will be called when we get a response from the server.
	sharedTJCAdView_.adDelegate = deleg;
	
	// Set the view size here, retrieved from the protocol method.
	sharedTJCAdView_.contentSizeStr = [[sharedTJCAdView_ adDelegate] adContentSize];
	
	if ([[sharedTJCAdView_ contentSizeStr] isEqual:TJC_AD_BANNERSIZE_320X50])
	{
		[sharedTJCAdView_ setFrame:CGRectMake(0, 0, 320, 50)];
	}
	else if ([[sharedTJCAdView_ contentSizeStr] isEqual:TJC_AD_BANNERSIZE_640X100])
	{
		[sharedTJCAdView_ setFrame:CGRectMake(0, 0, 640, 100)];
	}
	else if ([[sharedTJCAdView_ contentSizeStr] isEqual:TJC_AD_BANNERSIZE_768X90])
	{
		[sharedTJCAdView_ setFrame:CGRectMake(0, 0, 768, 90)];
	}
	
	// The ad view overlay should go directly over the ad view.
	[[sharedTJCAdView_ adViewOverlay] setFrame:sharedTJCAdView_.frame];
	
	[[sharedTJCAdView_ adHandlerObj] requestAdWithSize:[sharedTJCAdView_ contentSizeStr]];
	
	// This is used so that when the image view is made transparent during a touch, it'll look dimmed.
	[sharedTJCAdView_ setBackgroundColor:[UIColor blackColor]];
	
	return sharedTJCAdView_;
}


- (void) refreshAd
{
	[TJCAdView refreshAd];
}


+ (void) refreshAd
{
	if (![sharedTJCAdView_ adDelegate])
	{
		[TJCLog logWithLevel:LOG_NONFATAL_ERROR format:@"Ad delegate not set, getAdWithDelegate must first be called"];
		return;
	}
	
	if (![sharedTJCAdView_ adHandlerObj])
	{
		[TJCLog logWithLevel:LOG_NONFATAL_ERROR format:@"Ad handler object not set, getAdWithDelegate must first be called"];
		
		sharedTJCAdView_.adHandlerObj = [[TJCAdRequestHandler alloc] initRequestWithDelegate:sharedTJCAdView_ andRequestTag:0];
	}
	
	sharedTJCAdView_.contentSizeStr = [[sharedTJCAdView_ adDelegate] adContentSize];
	
	if (![sharedTJCAdView_ contentSizeStr])
	{
		[TJCLog logWithLevel:LOG_NONFATAL_ERROR format:@"Content size not set, adContentSize is not properly implemented"];
		return;
	}
	
	[[sharedTJCAdView_ adHandlerObj] requestAdWithSize:[sharedTJCAdView_ contentSizeStr]];
}


+ (BOOL) isAdLoaded
{
	if (![sharedTJCAdView_ adHandlerObj])
	{
		return NO;
	}
	
	return [[sharedTJCAdView_ adHandlerObj] isDataFetchSuccessful];
}


// called when request succeeeds
- (void) fetchResponseSuccessWithData:(void*)dataObj withRequestTag:(int)aTag
{
	float animDuration = 0.25f;
	
	// We want to fade out the old ad view while simultaneously fade in the new ad view.
	if ([self.subviews count] > 0)
	{
		previousImageView_ = [self.subviews objectAtIndex:0];
		// Previous ad is initially visible.
		[previousImageView_ setAlpha:1.0f];
		
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(removeOldAdEnded:finished:context:)];
		
		[UIView beginAnimations:nil context:nil];
		// The fade out animation is a bit slower to make it look better.
		[UIView setAnimationDuration:animDuration + .10];
		
		// Old ad fades out.
		[previousImageView_ setAlpha:0.0f];
		
		[UIView commitAnimations];
	}
	
	NSArray *dataArray = [NSArray arrayWithArray:dataObj];
	
	// Save the click URL.
	[clickURL_ release];
	clickURL_ = [[dataArray objectAtIndex:0] retain];
	
	// Save the image data.
	NSString *imageDataStr = [[dataArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	// JC: TODO: This should be removed when the image data is formatted correctly. For now, strip out the newline chars.
	
	UIImage *image = [[UIImage imageWithData:[TJCUtil dataWithBase64EncodedString:imageDataStr]] retain];
	imageView_ = [[UIImageView alloc] initWithImage: image];
	[image release];
	
	//[imageView_ setFrame:self.frame];
	[imageView_ setBounds:self.bounds];
	[imageView_ setCenter:CGPointMake(imageView_.bounds.size.width * 0.5f, imageView_.bounds.size.height * 0.5f)];
	
	[self addSubview:imageView_];
	[imageView_ addSubview:adViewOverlay_];
	
	// Do a fade-in animation so it looks better.
	// New ad is initially not visible.
	[imageView_ setAlpha:0.0f];
	
	// Before starting the animation, call the delegate method to notify that an Ad has just been recieved.
	[adDelegate_ didRecieveAd:self];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:animDuration];
	
	// New ad fades in.
	[imageView_ setAlpha:1.0f];
	[UIView commitAnimations];
	
	// Query delegate method to determin whether the ad should be refreshed.
	if ([adDelegate_ shouldRefreshAd])
	{
		// Now start a refresh timer to load the next ad.
		refreshTimer_ = [NSTimer scheduledTimerWithTimeInterval:TJC_AD_REFRESH_DELAY target:self selector:@selector(refreshAd) userInfo:nil repeats:NO];
	}
}


-(void)removeOldAdEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[previousImageView_ removeFromSuperview];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Darken image when it is touched.
	//[[adViewOverlay_ superview] bringSubviewToFront:adViewOverlay_];
	[adViewOverlay_ setAlpha:0.4f];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches)
	{
		CGPoint location = [touch locationInView:self];
		
		//[[adViewOverlay_ superview] sendSubviewToBack:adViewOverlay_];
		[adViewOverlay_ setAlpha:0.0f];
		
		// Do a touch-rect collision test to make sure that the user has released touch within the ad area.
		if ([self pointInside:location withEvent:event])
		{
			if (clickURL_)
			{
				// Open the URL, which will redirect to the app store.
				NSURL *redirectURL = [NSURL URLWithString:clickURL_];
				[[UIApplication sharedApplication] openURL:redirectURL];
			}
			else
			{
				[TJCLog logWithLevel:LOG_NONFATAL_ERROR format:@"Ad cannot be loaded. Check internet connection."];
			}
			
		}
	}
}

NSString *kTJCAdFailStr = @"Tapjoy Ad request failed to recieve any data.";

// raised when error occurs
- (void) fetchResponseError:(TJCResponseError)errorType errorDescription:(id)errorDescObj requestTag:(int)aTag
{
	[adDelegate_ didFailWithMessage:kTJCAdFailStr];
}


- (void) dealloc
{
	[adHandlerObj_ release];	
	adHandlerObj_ = nil;
	
	[clickURL_ release];
	[imageDataStr_ release];
	[imageView_ release];
	[previousImageView_ release];
	[adViewOverlay_ release];
	
	[super dealloc];
}

@end



@implementation TapjoyConnect (TJCAdView)

+ (id) getDisplayAdWithDelegate:(id <TJCAdDelegate>)deleg
{
	return [TJCAdView getAdWithDelegate:deleg];
}


+ (void) refreshDisplayAd
{
	[TJCAdView refreshAd];
}


+ (BOOL) isDisplayAdLoaded
{
	return [TJCAdView isAdLoaded];
}


+ (TJCAdView*) getDisplayAdView
{
	return [TJCAdView sharedTJCAdView];
}

@end