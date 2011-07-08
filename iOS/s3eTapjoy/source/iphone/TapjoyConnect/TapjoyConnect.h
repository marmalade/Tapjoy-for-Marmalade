//
//  TapjoyConnect.h
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.


/*! \mainpage Tapjoy iOS SDK
 *
 * The Tapjoy iOS SDK.
 */


#import <Foundation/Foundation.h>

#define TJC_SERVICE_URL							@"https://ws.tapjoyads.com/"
#define TJC_SERVICE_URL_ALTERNATE			@"https://ws1.tapjoyads.com/"
#define TJC_TAPJOY_HOST_NAME					@"ws.tapjoyads.com"
#define TJC_TAPJOY_ALT_HOST_NAME				@"ws1.tapjoyads.com"
#define TJC_LINKSHARE_HOST_NAME				@"click.linksynergy.com"

#define TJC_UDID									@"udid"					/*!< The unique device identifier. */
#define TJC_DEVICE_NAME							@"device_name"			/*!< This is the specific device name ("iPhone1,1", "iPod1,1"...) */
#define TJC_DEVICE_TYPE_NAME					@"device_type"			/*!< The model name of the device. This is less descriptive than the device name. */
#define TJC_DEVICE_OS_VERSION_NAME			@"os_version"			/*!< The device system version. */
#define TJC_DEVICE_COUNTRY_CODE				@"country_code"		/*!< The country code is retrieved from the locale object, from user data (not device). */
#define TJC_DEVICE_LANGUAGE					@"language_code"		/*!< The language is retrieved from the locale object, from user data (not device). */
#define TJC_DEVICE_LAD							@"lad"					/*!< Little Alien Dude. */
#define TJC_APP_ID_NAME							@"app_id"				/*!< The application id is set by the developer, and is a unique id provided by Tapjoy. */
#define TJC_APP_VERSION_NAME					@"app_version"			/*!< The application version is retrieved from the application plist file, from the bundle version. */
#define TJC_CONNECT_LIBRARY_VERSION_NAME	@"library_version"	/*!< The library version is the SDK version number. */	
#define TJC_LIBRARY_VERSION_NUMBER			@"8.0.0"					/*!< The SDK version number. */
#define TJC_VERIFIER								@"verifier"				/*!< A hashed value that is verified on the server to confirm a valid connect. */
#define TJC_TIMESTAMP							@"timestamp"			/*!< The time in seconds when a connect call is made. */
#define TJC_GUID									@"guid"					/*!< Used as part of the verifier. */



/*!	\interface TapjoyConnect
 *	\brief The Tapjoy Connect Main class.
 *
 */
@interface TapjoyConnect :  NSObject
#if __IPHONE_4_0
<NSXMLParserDelegate>
#endif
{
@private
	NSString *appID_;						/*!< The application ID unique to this app. */
	NSString *secretKey_;				/*!< The Tapjoy secret key for this applicaiton. */
	NSString *userID_;					/*!< The user ID, used to display ads. This is the UDID by default. */
	NSData *data_;							/*!< Holds data for any data that comes back from a URL request. */
	NSURLConnection *connection_;		/*!< Used to provide support to perform the loading of a URL request. Delegate methods are defined to handle when a response is recieve with associated data. This is used for asynchronous requests only. */
	NSString *currentXMLElement_;		/*!< Contains @"Success when a connection is successfully made, nil otherwise. */
	int connectAttempts_;				/*!< The connect attempts is used to determine whether the alternate URL will be used. */
	BOOL isInitialConnect_;				/*!< Used to keep track of an initial connect call to prevent multiple repeated calls. */
}

@property (nonatomic,copy) NSString* appID;
@property (nonatomic,copy) NSString* secretKey;
@property (nonatomic,copy) NSString* userID;
@property (nonatomic) BOOL isInitialConnect;


/*!	\fn requestTapjoyConnect:secretKey:(NSString *appID, NSString *secretKey)
 *	\brief This method is called to initialize the TapjoyConnect system.
 *
 * This method should be called upon app delegate initialization in the applicationDidFinishLaunching method.
 *	\param appID The application ID. Retrieved from the app dashboard in your Tapjoy account.
 *  \param secretKey The application secret key. Retrieved from the app dashboard in your Tapjoy account.
 *	\return The globally accessible #TapjoyConnect object.
 */
+ (TapjoyConnect*)requestTapjoyConnect:(NSString*)appID secretKey:(NSString*)secretKey;

/*!	\fn actionComplete:(NSString*)actionID
 *	\brief This is called when an action is completed.
 *
 * Actions are much like connects, except that this method is only called when a user completes an in-game action.
 *	\param actionID The action ID.
 *	\return The globally accessible #TapjoyConnect object.
 */
+ (TapjoyConnect*)actionComplete:(NSString*)actionID;

/*!	\fn sharedTapjoyConnect
 *	\brief Retrieves the globally accessible #TapjoyConnect singleton object.
 *
 *	\param n/a
 *	\return The globally accessible #TapjoyConnect singleton object.
 */
+ (TapjoyConnect*)sharedTapjoyConnect;

/*!	\fn deviceNotificationReceived
 *	\brief This is called whenever the application returns to the foreground.
 *
 *	\param n/a
 *	\return n/a
 */
+ (void)deviceNotificationReceived;

/*!	\fn TJCSHA256CommonParamsWithTimeStamp:(NSString*)timeStamp
 *	\brief Generates a SHA-256 hash value with the given time stamp.
 *
 * The following are sent as common parameters: appID, UDID, and timestamp.
 *	\param timeStamp The time stamp to generate the hash with.
 *	\return The SHA-256 hash value.
 */
+ (NSString*)TJCSHA256CommonParamsWithTimeStamp:(NSString*)timeStamp;

/*!	\fn TJCSHA256CommonParamsWithTimeStamp:tapPointsAmount:guid:(NSString* timeStamp, int points, NSString* guid)
 *	\brief Generates a SHA-256 hash value with the time stamp and some common parameters.
 *
 * The following are sent as common parameters: appID, UDID, and timestamp.
 *	\param timeStamp The time stamp to generate the hash with.
 *	\param points The amount of tap points to award to the user.
 *	\param guid A generated GUID for this particular URL request.
 *	\return The SHA-256 hash value.
 */
+ (NSString*)TJCSHA256CommonParamsWithTimeStamp:(NSString*)timeStamp tapPointsAmount:(int)points guid:(NSString*)guid;

/*!	\fn TJCSHA256WithString:(NSString*)dataStr
 *	\brief Generates a SHA-256 hash value with the given string.
 *
 *	\param dataStr The string from which the hash value will be generated from.
 *	\return The SHA-256 hash value.
 */
+ (NSString*)TJCSHA256WithString:(NSString*)dataStr;

/*!	\fn generateUUID
 *	\brief Generates a GUID.
 *
 *	\param n/a
 *	\return A GUID.
 */
+ (NSString*)generateUUID;

/*!	\fn getAppID
 *	\brief Retrieves the Tapjoy app ID.
 *
 *	\param n/a
 *	\return The Tapjoy app ID passed into requestTapjoyConnect.
 */
+ (NSString*)getAppID;

/*!	\fn setUserID:(NSString*)theUserID
 *	\brief Sets the user ID.
 *
 * The user ID defaults to the UDID. This is only changed when NOT using Tapjoy Managed Currency.
 *	\param theUserID The user ID.
 *	\return n/a
 */
+ (void)setUserID:(NSString*)theUserID;

/*!	\fn getUserID
 *	\brief Retrieves the user ID.
 *
 *	\param n/a
 *	\return The Tapjoy user ID. The user ID defaults to the UDID.
 */
+ (NSString*)getUserID;

/*!	\fn getSecretKey
 *	\brief Retrieves the secret.
 *
 *	\param n/a
 *	\return The Tapjoy secret key for this application.
 */
+ (NSString*)getSecretKey;

/*! \fn isJailBroken
 *	\brief Simple check to detect jail broken devices/apps.
 *
 * Note that this is NOT guaranteed to be accurate! There are very likely going to be ways to circumvent this check in the future.
 *	\param n/a
 *	\return YES for indicating that the device/app has been jailbroken, NO otherwise.
 */ 
- (BOOL)isJailBroken;

/*! \fn isJailBrokenStr
 *	\brief Simple check to detect jail broken devices/apps.
 *
 * Note that this is NOT guaranteed to be accurate! There are very likely going to be ways to circumvent this check in the future.
 *	\param n/a
 *	\return A string "YES" for indicating that the device/app has been jailbroken, "NO" otherwise.
 */ 
- (NSString*)isJailBrokenStr;

/*! \fn genericParameters
 *	\brief Retrieves the dictionary of generic parameters that are sent with every URL request.
 *
 *	\param n/a
 *	\return A dictionary of generic parameters, listed at the top of this file.
 */ 
- (NSMutableDictionary*)genericParameters;

/*! \fn createQueryStringFromDict:(NSDictionary*)paramDict
 *	\brief Takes the given dictionary and contructs a legal URL string from it.
 *
 *	\param n/a
 *	\return A legal URL string constructed from the given dicionary.
 */ 
- (NSString*)createQueryStringFromDict:(NSDictionary*)paramDict;

// Declared here to prevent warnings.
#pragma mark TapjoyConnect NSXMLParser Delegate Methods
- (void)startParsing:(NSData*) myData;

@end


#import "TapjoyConnectConstants.h"