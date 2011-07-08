//
//  TJCConstants.h
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy All rights reserved.
//

#ifndef TJC_CONSTANTS_DEC
#define TJC_CONSTANTS_DEC

#define TJC_CURRENCY_KEY_NAME			@"TJC_CURRENCY_KEY_NAME"
#define TJC_POINTS_KEY_NAME			@"TJC_POINTS_KEY_NAME"
#define TJC_POINTS_DELTA_KEY_NAME	@"TJC_POINTS_DELTA_KEY_NAME"
#define TJC_POINT_ID_KEY_NAME			@"TJC_POINT_ID_KEY_NAME"
#define TJC_TAP_POINTS_UPDATED		@"TJC_TAP_POINTS_UPDATED"

// The user ID.
#define TJC_URL_PARAM_USER_ID			@"publisher_user_id"

// Multiple currency parameters.
#define TJC_URL_PARAM_CURRENCY_ID	@"currency_id"
#define TJC_URL_PARAM_SELECTOR_ID	@"currency_selector"

// Tap Points APIs.
#define TJC_URL_PARAM_SPEND_TAP_POINTS	@"points/spend"
#define TJC_URL_PARAM_AWARD_TAP_POINTS	@"points/award"
#define TJC_URL_PARAM_TAP_POINTS			@"tap_points"
#define TJC_URL_PARAM_VG_ITEMS_USER		@"get_vg_store_items/user_account"

// Virtual Good APIs.
#define TJC_URL_PARAM_PURCHASE_VG			@"points/purchase_vg"
#define TJC_URL_PARAM_VG_ID					@"virtual_good_id"
#define TJC_URL_PARAM_VG_ITEMS_ALL			@"get_vg_store_items/all"
#define TJC_URL_PARAM_VG_ITEMS_PURCHASED	@"get_vg_store_items/purchased"
#define TJC_URL_PARAM_VG_ITEMS_START		@"start"
#define TJC_URL_PARAM_VG_ITEMS_MAX			@"max"

// Featured App APIs.
#define TJC_FEATURED_FULLSCREEN_URL_NAME		@"get_offers/fullscreenad?"
#define TJC_FEATURED_URL_NAME						@"get_offers/featured"
#define TJC_FEATURED_FULLSCREEN_SERVICE_URL					[NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL, TJC_FEATURED_FULLSCREEN_URL_NAME]
#define TJC_FEATURED_FULLSCREEN_SERVICE_ALTERNATE_URL		[NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL_ALTERNATE, TJC_FEATURED_FULLSCREEN_URL_NAME]

// Offers APIs.
#define TJC_WEB_OFFERS_URL_NAME					@"get_offers/webpage?"
#define TJC_WEBOFFERS_SERVICE_URL				[NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL,TJC_WEB_OFFERS_URL_NAME]
#define TJC_WEBOFFERS_SERVICE_ALTERNATE_URL	[NSString stringWithFormat:@"%@%@", TJC_SERVICE_URL_ALTERNATE, TJC_WEB_OFFERS_URL_NAME]

// Display Ad parameters.
#define TJC_URL_PARAM_DISPLAY_AD_SIZE	@"size"

#define TJC_REQUEST_TIME_OUT 35

#define TJC_URL_PARAM_VG_MAX_INDEX		999
#define TJC_URL_PARAM_VG_PAGE_INDEX		999

// Used for featured app.
#define TJC_FEATURED_APP_DEFAULT_MAX_DISPLAY_COUNT	4
#define TJC_FEATURED_COUNT_INF		-1


//Custom HEXColor function
#define TJC_HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0f \
green:((c>>16)&0xFF)/255.0f \
blue:((c>>8)&0xFF)/255.0f \
alpha:((c)&0xFF)/255.0f]

#define TJC_SHOW_BOX_CLOSE_NOTIFICATION @"TJC_SHOW_BOX_NOTIFICATION"
#define TJC_DEFAULT_TRANSITION_DELAY (0.5f)

#define TJC_DEFAULT_COLOR   0x0E2C4CFF	//928844


#endif
