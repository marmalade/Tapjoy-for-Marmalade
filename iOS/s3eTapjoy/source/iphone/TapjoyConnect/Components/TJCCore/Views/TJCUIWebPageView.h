//
//  TJCUIWabPageView.h
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
// // Added for all WebView Pages, handels the request intelligently

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define TJCUIWEBPAGE_ACTIVITY_INDICATOR_SIZE	60
#define TJCUIWEBPAGE_ACTIVITY_RECT_SIZE			100
#define TJCUIWEBPAGE_LOADING_TEXT_RECT_HEIGHT	20

static const float LOADING_PAGE_START_ALPHA = 0.75f;	/*!< The target alpha value when the loading rect fades in. */
static const float LOADING_PAGE_END_ALPHA = 0.0f;		/*!< The target alpha value after the loading rect fades out. */
static const float LOADING_PAGE_FADE_TIME = 0.25f;		/*!< The amount of time in seconds that the loading rect fades in and out. */

/*!	\protocol TJCUIWebPageViewProtocol
 *	\brief The Tapjoy Connect Web Page protocol.
 */
@protocol TJCUIWebPageViewProtocol<NSObject>

@required

/*!	\fn tjcUIWebPageViewwebRequestCompleted
 *	\brief When library throws this event, the user can start showing his custom Ad.
 *  
 *	\param n/a
 *  \return n/a
 */
-(void) tjcUIWebPageViewwebRequestCompleted;

/*!	\fn tjcUIWebPageViewwebRequestCanceled
 *	\brief When library throws this event, the library wants its control back to continue its rotation.
 *  
 *	\param n/a
 *  \return n/a
 */
-(void) tjcUIWebPageViewwebRequestCanceled;

@end 


/*!	\interface TJCUIWebPageView
 *	\brief The Tapjoy Connect Web Page class.
 */
@interface TJCUIWebPageView : UIView <UIWebViewDelegate>
{
	UIWebView *cWebView_;								/*!< The UIWebView is used for embedding web content in the application. */
	NSTimer *checkPageLoadCompletionTimer_;		/*!< This NSTimer is used to check for whether the web page has completed loading. A check is made every 2 seconds. */
	UIActivityIndicatorView *activityIndicator_;	/*!< The UIActivityIndicatorView is visible when a web page is being loaded and is stopped when the page has finished loading. */
	UIView *loadingPage_;								/*!< The loading page is used in conjunction with the activity indicator to dim the page while it loads. */
	UILabel *loadingLbl_;								/*!< The loading text label. */
	NSString *alertErrorMessage_;						/*!< Used to display error messages. */
	NSURLRequest *lastClickedURL_;					/*!< Holds the last URL selected. */
	id delegate_;											/*!< The delegate object is used to recieve actions by classes that implement #tjcUIWebPageViewwebRequestCompleted and #tjcUIWebPageViewwebRequestCanceled. */
	BOOL webPageRendered_;								/*!< Used to make sure the web UIView is not reinitialized needlessly. */
	NSString *lastURL_;									/*!< This is used if data connection is lost and the user presses the retry button. */
}

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSString* alertErrorMessage;
@property (nonatomic, retain) NSString *lastURL;

/*!	\fn initWithFrame:WithRequestURL:(CGRect aFrame, NSURLRequest* aRequest)
 *	\brief Initializes the #TJCUIWebPageView with the given CGRect as the frame and a NSURLRequest.
 *  
 *	\param aFrame The CGRect that represents the web page frame.
 *	\param aRequest The NSURLRequest containing the URL for the web page.
 *  \return The #TJCUIWebPageView object.
 */
-(id) initWithFrame:(CGRect)aFrame WithRequestURL:(NSURLRequest*) aRequest;

/*!	\fn setDelegate:(id)aDelegate
 *	\brief Set the #delegate_ object with the given id.
 *  
 *	\param aDelegate The #delegate_ object is set to this id.
 *  \return n/a
 */
-(void) setDelegate:(id)aDelegate;

/*!	\fn loadWebRequest:(NSURLRequest *)aRequest
 *	\brief The given NSURLRequest contains a URL that the web page will navigate to.
 *  
 *	\param aRequest The NSURLRequest containing the URL for the web page.
 *  \return n/a
 */
-(void)loadWebRequest:(NSURLRequest *)aRequest;

/*!	\fn loadURLRequest:(NSURL*)requestURL
 *	\brief The given NSURL contains a URL that the web page will navigate to.
 *  
 *	\param requestURL The NSURL containing the URL for the web page.
 *  \return n/a
 */
-(void)loadURLRequest:(NSURL*)requestURL;

/*!	\fn loadURLRequest:withTimeOutInterval:(NSURL* requestURL, int tInterval)
 *	\brief The given NSURL contains a URL that the web page will navigate to.
 *  
 *	\param requestURL The NSURL containing the URL for the web page.
 *	\param tInterval The timeout interval.
 *  \return n/a
 */
-(void)loadURLRequest:(NSURL*)requestURL withTimeOutInterval:(int)tInterval;

/*!	\fn appendGenericParamsWithURL:(NSString*)theURL
 *	\brief Appends the TJC generic parameters to the given URL.
 *  
 *	\param theURL The URL to append the generic params to.
 *  \return The URL string constructed from appending the generic parameters to the given URL.
 */
- (NSString*)appendGenericParamsWithURL:(NSString*)theURL;

@end
