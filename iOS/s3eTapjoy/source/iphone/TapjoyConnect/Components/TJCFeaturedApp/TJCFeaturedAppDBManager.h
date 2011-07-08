//
//  TJCFeaturedAppDBManager.h
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TJC_FEATURE_APP_DB_NAME @"featured_app.sql"

@class TJCFeaturedAppModel;

/*!	\interface TJCFeaturedAppDBManager
 *	\brief The Tapjoy Connect Featured App Database Manager class.
 *
 */
@interface TJCFeaturedAppDBManager : NSObject 
{
	NSString *currentDBPath_;
}

+ (TJCFeaturedAppDBManager*) sharedTJCFeaturedAppDBManager;

/*!	\fn addApp:(TJCFeaturedAppModel*) anAppObj
 *	\brief Stores the store id and the maximum number of times the application can be displayed into the sql database.
 *
 *	\param anAppObj The #TJCFeaturedAppModel contains the data to be store in the sql database.
 *	\return TRUE if the operation completed successfully, FALSE otherwise.
 */
-(BOOL) addApp:(TJCFeaturedAppModel*) anAppObj;

/*!	\fn getDisplayedCountForStoreID:(NSString*) aStoreID
 *	\brief Retrieves the number of times an application has been displayed.
 *
 *	\param aStoreID The store identifier is used to retrieve the number of times an application has been displayed.
 *	\return The number of times an application has been displayed.
 */
-(int) getDisplayedCountForStoreID:(NSString*) aStoreID;

/*!	\fn incrementDisplayedCountForStoreID:(NSString*) aStoreID
 *	\brief Increments the display count of an application.
 *
 *	\param aStoreID The display count is incremented for the application with this store identifier.
 *	\return TRUE if the operation completed successfully, FALSE otherwise.
 */
-(BOOL) incrementDisplayedCountForStoreID:(NSString*) aStoreID ;

@end
