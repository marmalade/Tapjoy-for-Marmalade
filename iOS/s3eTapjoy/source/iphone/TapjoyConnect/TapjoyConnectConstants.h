#define TJC_CONNECT_SUCCESS				@"TJC_Connect_Success"
#define TJC_CONNECT_FAILED					@"TJC_Connect_Failed"
#define TJC_OFFERS_SDK

// This notification is fired after getTapPoints has been called, and indicates that user currency amount has been received from the server.
#define TJC_TAP_POINTS_RESPONSE_NOTIFICATION					@"TJC_TAP_POINTS_RESPONSE_NOTIFICATION"
// This notification is fired after spendTapPoints has been called, and indicates that the user has successfully spent currency.
#define TJC_SPEND_TAP_POINTS_RESPONSE_NOTIFICATION			@"TJC_SPEND_TAP_POINTS_RESPONSE_NOTIFICATION"
// This notification is fired after awardTapPoints has been called, and indicates that the user has successfully been awarded currency.
#define TJC_AWARD_TAP_POINTS_RESPONSE_NOTIFICATION			@"TJC_AWARD_TAP_POINTS_RESPONSE_NOTIFICATION"

// Error notification for getTapPoints.
#define TJC_TAP_POINTS_RESPONSE_NOTIFICATION_ERROR			@"TJC_TAP_POINTS_RESPONSE_NOTIFICATION_ERROR"
// Error notification for spendTapPoints
#define TJC_SPEND_TAP_POINTS_RESPONSE_NOTIFICATION_ERROR	@"TJC_SPEND_TAP_POINTS_RESPONSE_NOTIFICATION_ERROR"
// Error notification for awardTapPoints
#define TJC_AWARD_TAP_POINTS_RESPONSE_NOTIFICATION_ERROR	@"TJC_AWARD_TAP_POINTS_RESPONSE_NOTIFICATION_ERROR"

// Featured App notification is fired after featured app ad data is recieved from the server.
#define TJC_FEATURED_APP_RESPONSE_NOTIFICATION				@"TJC_FEATURED_APP_RESPONSE_NOTIFICATION"

// Notification that a user has just successfully completed an offer and earned currency. This only fires on init/resume.
#define TJC_TAPPOINTS_EARNED_NOTIFICATION						@"TJC_TAPPOINTS_EARNED_NOTIFICATION"


#import "TJCViewCommons.h"
#import "TJCOffersViewHandler.h"
#import "TJCUserAccountManager.h"
#import "TJCAdView.h"
#import "TJCAdDelegateProtocol.h"
#import "TJCFeaturedAppModel.h"
#import "TJCFeaturedAppViewHandler.h"
#import "TJCConstants.h"
#import "TJCLog.h"
#import "TJCFeaturedAppManager.h"
#import "TJCOffersWebView.h"
#import "TJCFeaturedAppView.h"
#import "TJCHardwareUtil.h"
#import "TJCCallsWrapper.h"