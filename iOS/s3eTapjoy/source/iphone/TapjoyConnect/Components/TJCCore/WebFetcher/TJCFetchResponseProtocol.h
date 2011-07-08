//
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.
//

/*!	\enum TJCResponseError
 *	\brief Tapjoy Connect response error codes.
 */
typedef enum TJCResponseError
{
	kTJCInternetFailure = 0,
	kTJCStatusNotOK = 1,
	kTJCRequestTimeOut = 2
} TJCResponseError;

/*!	\protocol TJCFetchResponseDelegate
 *	\brief The Tapjoy fetch response protocol. 
 */
@protocol TJCFetchResponseDelegate <NSObject>
@required

/*!	\fn fetchResponseSuccessWithData:withRequestTag:(void* dict, int aTag)
 *	\brief Called when a request succeeds.
 *
 *	\param dataObj
 *	\param aTag
 *	\return n/a
 */
-(void)fetchResponseSuccessWithData:(void*)dataObj withRequestTag:(int)aTag;

/*!	\fn fetchResponseError:errorDescription:requestTag:(TJCResponseError errorType, id errorDescObj, int aTag)
 *	\brief Called when an error occurs.
 *
 *	\param errorType
 *	\param errorDescObj
 *	\param aTag
 *	\return n/a
 */
-(void)fetchResponseError:(TJCResponseError)errorType errorDescription:(id)errorDescObj requestTag:(int) aTag;
@end

