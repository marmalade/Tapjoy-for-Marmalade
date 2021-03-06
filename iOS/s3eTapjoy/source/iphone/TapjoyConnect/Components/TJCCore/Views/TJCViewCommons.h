//
//  TJCViewCommons.h
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapjoyConnect.h"
#import "TJCConstants.h"


/*!	\enum TJCTransitionEnum
 *	\brief Enumeration of the different ways the View can animate.
 */
typedef enum TJCTransitionEnum
{
	TransitionBottomToTop = 0,		/*!< View animates from the bottom to the top of the screen. */
	TransitionTopToBottom,			/*!< View animates from the top to the bottom of the screen. */
	TransitionLeftToRight,			/*!< View animates from the left to the right of the screen. */
	TransitionRightToLeft,			/*!< View animates from the right to the left of the screen. */
	TransitionFadeEffect,			/*!< View fades into visibility. */
	TransitionNormalToBottom,		/*!< View animates off screen downwards. */
	TransitionNormalToTop,			/*!< View animates off screen upwards. */
	TransitionNormalToLeft,			/*!< View animates off screen to the left. */
	TransitionNormalToRight,		/*!< View animates off screen to the right. */
	TransitionFadeEffectReverse,	/*!< View fades out of visibility. */
	TransitionNoEffect = -1			/*!< No animation effect. */
} TJCTransitionEnum;


/*!	\enum TJCViewsIntegrationType
 *	\brief Enumeration of the different ways the View should be loaded.
 */
typedef enum TJCViewsIntegrationType 
{
	viewsIntegrationTypePlain = 0,							/*!< Used for navigation controller based applications. */
	viewsIntegrationTypeLibraryHandledVisibility = 1	/*!< Used for openGL based applications. */
} TJCViewsIntegrationType;


/*!	\interface TJCViewCommons
 *	\brief The Tapjoy Common View class.
 *
 * This class contains commonly used view related functions.
 */
@interface TJCViewCommons : NSObject 
{
	TJCTransitionEnum currentTransitionEffect_;		/*!< The current Transition Effect mentioned by End Application. */
	TJCTransitionEnum reverseTransitionEffect_;		/*!< The reverse effect of currentTransitionEffect_. */
	TJCViewsIntegrationType viewsIntegrationType_;	/*!< Specifies what type of application is currently running (navigation based or openGL). */
	int primaryColorCode_;									/*!< The integer value of the color tint of the naviation bar. */
	UIColor *userDefinedColor_;							/*!< The UIColor of the navigation bar. */
	float transitionDelay_;								/*!< The delay in seconds before views come in or go out of visibility. */
}

+ (TJCViewCommons*)sharedObject; /*!< The globally accessible #TJCViewCommons object. */

/*!	\fn animateTJCView:withTJCTransition:withDelay:(UIView* viewRef, TJCTransitionEnum transEffect, float delay)
 *	\brief Set a preset animation for transitioning the main view in and out of visibility.
 *  
 *	\param viewRef The UIView to transition in and out of view.
 *	\param transEffect The transition effect to use. Enumerated by #TJCTransitionEnum.
 *	\param delay The duration for the animation measured with 1.0f as one second.
 *  \return n/a
 */
+ (void)animateTJCView:(UIView*)viewRef withTJCTransition:(TJCTransitionEnum)transEffect withDelay:(float)delay ;

/*!	\fn setUserdefinedColorWithIntValue:(int) colorValue
 *	\brief Sets the navigation bar color to the given int color value.
 *  
 *	\param colorValue The integer color value.
 *  \return n/a
 */
- (void)setUserdefinedColorWithIntValue:(int) colorValue;

/*!	\fn setUserDefinedColorWithRed:WithGreen:WithBlue:(int red, int green, int blue)
 *	\brief Sets the navigation bar color to the given int color values.
 *  
 *	\param red The red integer color component.
 *	\param green The green integer color component.
 *	\param blue The blue integer color component.
 *  \return n/a
 */
- (void)setUserDefinedColorWithRed:(int)red WithGreen:(int)green WithBlue:(int)blue;

- (int)getUserDefinedColorCode;

/*!	\fn getUserDefinedColor
 *	\brief Retrieves #userDefinedColor_.
 *  
 *	\param n/a
 *  \return The user defined color for the navigation bar, #userDefinedColor_.
 */
- (UIColor*)getUserDefinedColor;

/*!	\fn getCurrentTransitionEffect
 *	\brief Gets the currently set transition effect enumerated value #TJCTransitionEnum.
 *  
 *	\param n/a
 *  \return The currently set transition effect.
 */
- (TJCTransitionEnum)getCurrentTransitionEffect;

/*!	\fn setTransitionEffect:(TJCTransitionEnum) transitionEffect
 *	\brief Sets the transition effect.
 *  
 *	\param transitionEffect The transition effect enumerated by #TJCTransitionEnum will determine the active animation style of the view.
 *  \return n/a
 */
- (void)setTransitionEffect:(TJCTransitionEnum) transitionEffect;

/*!	\fn getTransitionDelay
 *	\brief Gets the transition delay.
 *  
 *	\param n/a
 *  \return The transition delay.
 */
- (float)getTransitionDelay;

/*!	\fn getReverseTransitionEffect
 *	\brief Gets the currently set reverse transition effect enumerated value #TJCTransitionEnum.
 *  
 *	\param n/a
 *  \return The currently set reverse transition effect.
 */
- (TJCTransitionEnum)getReverseTransitionEffect;

@end


@interface TapjoyConnect (TJCViewCommons)

/*!	\fn setTransitionEffect:(TJCTransitionEnum) transitionEffect
 *	\brief Sets a transition effect for the Tapjoy UIViews.
 *
 *	\param transitionEffect The transition effect to set, enumerated by #TJCTransitionEnum.
 *	\return n/a
 */
+ (void)setTransitionEffect:(TJCTransitionEnum) transitionEffect;

/*!	\fn setUserdefinedColorWithIntValue:(int) colorValue
 *	\brief Sets the navigation bar color with the given color value.
 *
 *	\param colorValue The color to set the navigation bar to.
 *	\return n/a
 */
+ (void)setUserdefinedColorWithIntValue:(int) colorValue;

/*!	\fn setUserDefinedColorWithRed:WithGreen:WithBlue:(int red, int green, int blue)
 *	\brief Sets the navigation bar color with the given color values.
 *
 *	\param red The red color component.
 *	\param green The green color component.
 *	\param blue The blue color component.
 *	\return n/a
 */
+ (void)setUserDefinedColorWithRed:(int)red WithGreen:(int)green WithBlue:(int)blue;

/*!	\fn updateViewsWithOrientation:(UIInterfaceOrientation)interfaceOrientation
 *	\brief Some Tapjoy controlled views rely on the orientation being updated when the view is part of an external view controller.
 *
 *	\param orientation The new orientation of the view.
 *	\return n/a
 */
+ (void)updateViewsWithOrientation:(UIInterfaceOrientation)interfaceOrientation;

/*!	\fn animateTJCView:withTJCTransition:withDelay:(UIView* viewRef, TJCTransitionEnum transEffect, float delay)
 *	\brief Set a preset animation for transitioning the main view in and out of visibility.
 *  
 *	\param viewRef The UIView to transition in and out of view.
 *	\param transEffect The transition effect to use. Enumerated by #TJCTransitionEnum.
 *	\param delay The duration for the animation measured with 1.0f as one second.
 *  \return n/a
 */
+ (void)animateTJCView:(UIView*)viewRef withTJCTransition:(TJCTransitionEnum)transEffect withDelay:(float)delay;

/*!	\fn getTransitionDelay
 *	\brief Gets the transition delay.
 *  
 *	\param n/a
 *  \return The transition delay.
 */
+ (float)getTransitionDelay;

/*!	\fn getCurrentTransitionEffect
 *	\brief Gets the currently set transition effect enumerated value #TJCTransitionEnum.
 *  
 *	\param n/a
 *  \return The currently set transition effect.
 */
+ (TJCTransitionEnum)getCurrentTransitionEffect;

/*!	\fn getReverseTransitionEffect
 *	\brief Gets the currently set reverse transition effect enumerated value #TJCTransitionEnum.
 *  
 *	\param n/a
 *  \return The currently set reverse transition effect.
 */
+ (TJCTransitionEnum)getReverseTransitionEffect;

@end