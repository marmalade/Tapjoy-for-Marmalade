//
//  TJCViewCommons.m
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
// Pure Singleton Class for handling all Views common functionality

#import "TJCViewCommons.h"
#import "TJCLog.h"
#import "TJCOffersWebView.h"

static TJCViewCommons *sharedObject_ = nil;

@implementation TJCViewCommons

+ (TJCViewCommons*)sharedObject
{
	if (!sharedObject_) 
	{
		sharedObject_ = [[super alloc] init];
		[[NSNotificationCenter defaultCenter] addObserver:sharedObject_ 
															  selector:@selector(handleCloseBoxNotification:) 
																	name:TJC_SHOW_BOX_CLOSE_NOTIFICATION 
																 object:nil];
	}
	return sharedObject_;
}


- (id)init
{
	if ((self = [super init]))
	{
		viewsIntegrationType_ = viewsIntegrationTypePlain;
		primaryColorCode_ = TJC_DEFAULT_COLOR;
		
		if (userDefinedColor_ == nil)
		{
			userDefinedColor_ = [TJC_HEXCOLOR(TJC_DEFAULT_COLOR) retain];
		}
	}
	return self;
}


//Hanlde the current selected animation style 
+ (void)animateTJCView:(UIView*)viewRef withTJCTransition:(TJCTransitionEnum)transEffect withDelay:(float)delay 
{
	
	if(transEffect == TransitionNoEffect)
		return; // No effect requierd so return 
	
	CGRect animRect = viewRef.frame;
	
	switch (transEffect) 
	{
		case TransitionBottomToTop:
		{
			//Bottom to Top Animation
			animRect.origin.y = animRect.origin.y + animRect.size.height;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.y = animRect.origin.y - animRect.size.height;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionNormalToBottom:
		{
			//Bottom to Top Animation
			animRect.origin.y = animRect.origin.y;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.y = animRect.origin.y + animRect.size.height;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionNormalToTop:
		{
			//Bottom to Top Animation
			animRect.origin.y = animRect.origin.y;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.y = animRect.origin.y - animRect.size.height;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionTopToBottom:
		{
			//top to bottom
			animRect.origin.y = animRect.origin.y - animRect.size.height;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.y = animRect.origin.y + animRect.size.height;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionLeftToRight:
		{
			animRect.origin.x = animRect.origin.x - animRect.size.width;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.x = animRect.origin.x + animRect.size.width;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionNormalToRight:
		{
			animRect.origin.x = animRect.origin.x;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.x = animRect.origin.x + animRect.size.width;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionRightToLeft:
		{
			//top to bottom
			animRect.origin.x = animRect.origin.x + animRect.size.width;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.x = animRect.origin.x - animRect.size.width;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionNormalToLeft:
		{
			animRect.origin.x = animRect.origin.x;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.x = animRect.origin.x - animRect.size.width;
			viewRef.frame = animRect;
		}
			break;
			
		case TransitionFadeEffect:
		{
			//Fade Effect
			viewRef.alpha = 0;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			viewRef.alpha = 1;
		}
			break;
			
		case TransitionFadeEffectReverse:
		{
			viewRef.alpha = 1;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			viewRef.alpha = 0;
		}
			break;
			
		default:
		{
			animRect.origin.y = animRect.origin.y + animRect.size.height;
			viewRef.frame = animRect;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:delay];
			animRect.origin.y = animRect.origin.y - animRect.size.height;
			viewRef.frame = animRect;
		}
			break;
	}
	
	[UIView commitAnimations];
}


- (NSUInteger)retainCount
{
	return NSUIntegerMax; //denotes an object that cannot be released
}


- (id)autorelease
{
	return self;
}


- (float)getTransitionDelay
{
	return transitionDelay_;
}


- (void)setTransitionEffect:(TJCTransitionEnum) transitionEffect
{
	currentTransitionEffect_ = transitionEffect;
	if(transitionEffect == TransitionNoEffect)
	{
		reverseTransitionEffect_ = TransitionNoEffect;
		transitionDelay_ = 0;
	}
	else
	{
		transitionDelay_ = TJC_DEFAULT_TRANSITION_DELAY;
		if(transitionEffect == TransitionBottomToTop)
		{
			reverseTransitionEffect_ = TransitionNormalToBottom;
		}
		else if(transitionEffect == TransitionTopToBottom)
		{
			reverseTransitionEffect_ = TransitionNormalToTop;
		}
		else if(transitionEffect == TransitionRightToLeft)
		{
			reverseTransitionEffect_ = TransitionNormalToRight;
		}
		else if(transitionEffect == TransitionLeftToRight)
		{
			reverseTransitionEffect_ = TransitionNormalToLeft;
		}
		else if(transitionEffect == TransitionFadeEffect)
		{
			reverseTransitionEffect_ = TransitionFadeEffectReverse;
		}
		else
			reverseTransitionEffect_ = TransitionNormalToBottom;
	}
}


- (TJCTransitionEnum)getCurrentTransitionEffect
{
	return currentTransitionEffect_;
}


- (TJCTransitionEnum)getReverseTransitionEffect
{
	return reverseTransitionEffect_;
}


- (int)getUserDefinedColorCode
{
	if(primaryColorCode_ == -1)
		primaryColorCode_ = TJC_DEFAULT_COLOR; //0x0E2c4c
	
	return primaryColorCode_;
}


- (UIColor*)getUserDefinedColor
{
	if(userDefinedColor_ == nil) //set user default color
	{
		[TJCLog logWithLevel:LOG_NONFATAL_ERROR format:@"PrimaryColor Tag not properly configured, so picking default color"];
		userDefinedColor_ = [TJC_HEXCOLOR(TJC_DEFAULT_COLOR) retain];	
	}
	
	return userDefinedColor_;
}


- (void)setUserdefinedColorWithIntValue:(int)colorValue
{
	primaryColorCode_ = colorValue;
	
	int red = (primaryColorCode_ & 0x00FF0000) >> 16;
	int green = (primaryColorCode_ & 0x0000FF00) >> 8;
	int blue = (primaryColorCode_ & 0x000000FF);
	
	[userDefinedColor_ release]; //release if already assigned a value by end user
	userDefinedColor_ = [[UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:1] retain];
}


- (void)setUserDefinedColorWithRed:(int)red WithGreen:(int)green WithBlue:(int)blue
{
	if(red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255)
	{
		[TJCLog logWithLevel:LOG_NONFATAL_ERROR format:@"Invalid value of color Red/Blue/Green picking library's default"];
		primaryColorCode_ = TJC_DEFAULT_COLOR;
	}
	else
	{
		primaryColorCode_ = 256*256*red+256*green+blue;
	}	
	[userDefinedColor_ release]; //release if already assigned a value by end user
	
	userDefinedColor_ = [[UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:1] retain];
}


- (void)dealloc
{
	[userDefinedColor_ release];
	
	
	[super dealloc];
}


- (void)handleCloseBoxNotification:(id)sender
{
	//[self hideGLBaseGameView];
}

@end



@implementation TapjoyConnect (TJCViewCommons)

+ (void)setTransitionEffect:(TJCTransitionEnum) transitionEffect
{
	[[TJCViewCommons sharedObject] setTransitionEffect:transitionEffect];
}


+ (void)setUserdefinedColorWithIntValue:(int) colorValue
{
	[[TJCViewCommons sharedObject] setUserdefinedColorWithIntValue:colorValue];
}


+ (void)setUserDefinedColorWithRed:(int)red WithGreen:(int)green WithBlue:(int)blue
{
	[[TJCViewCommons sharedObject] setUserDefinedColorWithRed:red WithGreen:green WithBlue:blue];	
}


+ (void)updateViewsWithOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	[[TJCCallsWrapper sharedTJCCallsWrapper] updateViewsWithOrientation:interfaceOrientation];
}


+ (void)animateTJCView:(UIView*)viewRef withTJCTransition:(TJCTransitionEnum)transEffect withDelay:(float)delay 
{
	[TJCViewCommons animateTJCView:viewRef withTJCTransition:transEffect withDelay:delay];
}


+ (float)getTransitionDelay
{
	return [[TJCViewCommons sharedObject] getTransitionDelay];
}


+ (TJCTransitionEnum)getCurrentTransitionEffect
{
	return [[TJCViewCommons sharedObject] getCurrentTransitionEffect];
}


+ (TJCTransitionEnum)getReverseTransitionEffect
{
	return [[TJCViewCommons sharedObject] getReverseTransitionEffect];
}

@end