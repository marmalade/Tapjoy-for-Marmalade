//
//  TJCFeaturedAppModel.h
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"



/*!	\interface TJCFeaturedAppModel
 *	\brief The Tapjoy Connect Featured App Model class.
 *
 * The #TJCFeaturedAppModel represents a featured app object and is initialized when 
 * the server responds to the URL request for getting the feature app data is completed.
 */
@interface TJCFeaturedAppModel : NSObject 
{
	NSString *cost_;				/*!< The cost of the featured app. */
	NSString *storeID_;			/*!< The store id of the featured app. */
	NSString *name_;				/*!< The name of the featured app. */
	NSString *description_;		/*!< The description for the featured app. */
	int amount_;					/*!< The amount of virtual currency the user gets if they complete the featured app offer. */
	NSString *iconURL_;			/*!< The URL to the location of the icon for the featured app. */
	NSString *largeIconURL_;	/*!< The URL to the location of the large icon for featured app. */
	NSString *redirectURL_;		/*!< The redirect URL for the featured app. */
	int	maxTimesToDisplayThisApp_;	/*!< The maximum number of times this feature app may appear. */
	
	NSString *fullScreenAdURL_;		/*!< The URL to the full screen Ad. This is used when the Tapjoy Full Screen Ad web view is used to display the featured app. */
}

@property (nonatomic, retain) NSString* cost;
@property (nonatomic, retain) NSString* storeID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* iconURL;
@property (nonatomic, retain) NSString* largeIconURL;
@property (nonatomic, retain) NSString* redirectURL;
@property (nonatomic, assign) int amount;
@property (nonatomic, assign) int maxTimesToDisplayThisApp;
@property (nonatomic, retain) NSString* fullScreenAdURL;

/*!	\fn initWithTBXML:(TBXMLElement*) aXMLElement
 *	\brief Initializes the #TJCFeaturedAppModel object with the given xml data.
 *
 *	\param aXMLElement The xml element contains all the relevant #TJCFeaturedAppModel object data.
 *	\return The #TJCFeaturedAppModel object.
 */
- (id) initWithTBXML:(TBXMLElement*) aXMLElement;


@end
