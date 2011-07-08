//
//  TJCUIWebPageAdView.h
//
//  Created by Tapjoy on 10/20/10.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJCUIWebPageView.h"
#import "TapjoyConnect.h"


static const float FULLSCREEN_AD_BACK_BUTTON_SIZE = 30.0f;
static const float FULLSCREEN_AD_BORDER_SIZE = 3.0f;


/*!	\interface TJCFeaturedAppView
 *	\brief The Tapjoy Connect Featured App View class.
 *
 */
@interface TJCFeaturedAppView : TJCUIWebPageView 
{
	NSString *publisherUserID_;		/*!< The publisher ID. */
	NSURL *externalURL_;					/*!< URL to be opened externally from the app. */
}


@property (nonatomic, retain) NSString *publisherUserID_;

+ (TJCFeaturedAppView*) sharedTJCFeaturedAppView;

/*!	\fn refreshWithFrame:(CGRect)frame
 *	\brief Refreshes the #TJCFeaturedAppView with the given GCRect frame.
 *
 *	\param frame The frame properties are used to define the location and boundaries to initialize the #TJCFeaturedAppView in.
 *	\return n/a
 */
- (void)refreshWithFrame:(CGRect)frame;

/*!	\fn loadViewWithURL:(NSString*)theURL
 *	\brief Loads the web view with the given URL.
 *
 *	\param theURL The URL to load the web view with.
 *	\return n/a
 */
- (void) loadViewWithURL:(NSString*)theURL;

/*!	\fn setUpFeaturedAdURLWithServiceURL:(NSString*)serviceURL
 *	\brief Sets up the featured ad URL with the given service portion of the URL.
 *
 * The generic parameters and the user id is appended to the given URL and the result is returned.
 *	\param serviceURL The service portion of the URL.
 *	\return The result URL.
 */
- (NSString*)setUpFeaturedAdURLWithServiceURL:(NSString*)serviceURL;

/*!	\fn initializeWebViewUI
 *	\brief Initializes the web page view.
 *
 *	\param n/a
 *	\return n/a
 */
- (void) initializeWebViewUI;

- (void) backtoGameAction:(id) sender;

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;

@end
