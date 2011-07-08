//
//  TJCCoreFetcher.h
//
//  Created by Tapjoy 4/30/2010
//  Copyright 2010 Tapjoy.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJCLog.h"

static NSString * const BOUNDRY = @"0xKhTmLbOuNdArY";


/*!	\interface TJCCoreFetcher
 *	\brief The Tapjoy Connect Core Fetcher class.
 *
 */
@interface TJCCoreFetcher : NSObject 
{
	
	int				requestTag_;		/*!< Used for distinguishing the web request and its response. */
	int				retryCount_;		/*!< Keeps track of the retry count for the NSURLConnection requests. */
	id				fetcherDelegate_;	/*!< The fetcher delegate. This is used to recieve messages sent by the NSInvocation after #makeGenericRequestWithURL() is called. */	
	NSURLResponse	*response_;			/*!< This contains status codes after the NSURLConnection request is made, which is used to handle any error that may have occured. */
	NSTimeInterval	requestTimeout_;	/*!< The time out time in seconds for an NSURLConnection request. */
	NSURLConnection *connection_;		/*!< Used to provide support to perform the loading of a URL request. Delegate methods are defined to handle when a response is recieve with associated data. This is used for asynchronous requests only. */
	NSInvocation	*invocation_;		/*!< Used to invoke a NSURLConnection request, specifically after a Tap Point is received. This is used for asynchronous requests only. */
	NSString		*requestMethod_;	/*!< Used to set NSMutableURLRequest setHTTPMethod. Values can be "GET", "POST", etc... */
	NSDictionary	*postParameters_;	/*!< Holds the parameter list when a NSURLConnection request is made. */
	BOOL			hasFetched_;		/*!< Indicates whether data has been fetched from calling NSURLConnection. */
	NSString		*baseURL_;			/*!< Holds the NSString of the base URL used to do the web fetch. */
	NSString		*alternateURL_;		/*!< Holds the NSString of the alternate URL used to do the web fetch. */
	NSDictionary	*bindings_;			/*!< Holds the parameter list when a NSURLConnection request is made. */
	NSError			*error_;			/*!< Used to store error information if an error occured with the NSURLConnection request. */
	NSData			*data_;				/*!< Used to store the data received from the NSURLConnection request. */
	NSData          *POSTdata_;         /*!< Used to hold the data to be sent to the server. */
}

@property int requestTag;
@property (nonatomic,assign) id fetcherDelegate;
@property (nonatomic, readonly) int retryCount;

@property (nonatomic, retain) NSInvocation *invocation;
@property (nonatomic, retain) NSString *requestMethod;
@property (nonatomic, retain) NSDictionary *postParameters;
@property (nonatomic) BOOL hasFetched;
@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) NSString *alternateURL;
@property (nonatomic, retain) NSDictionary *bindings;
@property (nonatomic, retain) NSError *error;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSData *POSTdata;
@property (nonatomic, retain) NSURLResponse *response;
@property (nonatomic) NSTimeInterval requestTimeout;
@property (nonatomic, retain) NSURLConnection * connection;


/*!	\fn fetchSynchronously
 *	\brief Fetches data synchronously.
 *
 * Synchronously request url and save resulting data, response, and error (if applicable).
 *	\param n/a
 *	\return n/a
 */
- (void) fetchSynchronously;

/*!	\fn fetchAsynchronouslyWithCompletionInvocation: (NSInvocation *) myInvocation
 *	\brief Fetches data asynchronously.
 *
 * Delegate methods for #connection are invoked when a response is received.
 *	\param myInvocation The NSInvocation when a response is received.
 *	\return n/a
 */
- (void) fetchAsynchronouslyWithCompletionInvocation: (NSInvocation *) myInvocation;

/*!	\fn retry
 *	\brief Initiates an asynchonous URL request and increments the retry counter.
 *
 *	\param n/a
 *	\return n/a
 */
- (void) retry;

/*!	\fn requestURL
 *	\brief Retrieves the #baseURL if the retry count is zero, or the #alternateURL otherwise.
 *
 *	\param n/a
 *	\return The #baseURL or #alternateURL depending on retry count.
 */
- (NSString *) requestURL;

/*!	\fn urlEncodedBindings
 *	\brief Retrieves the parameter list when a URL request is made.
 *
 *	\param n/a
 *	\return An NSString of all the URL parameters.
 */
- (NSString *) urlEncodedBindings;

/*!	\fn hasError
 *	\brief Indicates whether an error has occured with the URL request.
 *
 *	\param n/a
 *	\return TRUE is an error has occured, FALSE otherwise.
 */
- (BOOL) hasError;

/*!	\fn responseStatusCode
 *	\brief Retrieves the response code for HTTP requests.
 *
 *	\param n/a
 *	\return The HTTP response code.
 */
- (NSInteger) responseStatusCode;

/*!	\fn responseStatusCodeString
 *	\brief Retrieves the response code string for HTTP requests.
 *
 *	\param n/a
 *	\return The HTTP response code string.
 */
- (NSString *) responseStatusCodeString;
@end
