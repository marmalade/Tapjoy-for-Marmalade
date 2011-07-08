//
//  TJCTapPointModel.h
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"


/*!	\interface TJCUserAccountModel
 *	\brief The Tapjoy Connect User Account Model class.
 *
 * The user account model object contains the user data which includes currency name and amount, among other things.
 */
@interface TJCUserAccountModel : NSObject 
{
@private  
	int tapPoints_;						/*!< The currency amount of the current account. */
	NSString * pointsID_;				/*!< The points id of the current account. */
	NSString * currencyName_;			/*!< The current name of the current account. */
}

@property (nonatomic) int tapPoints;
@property (nonatomic, retain) NSString * pointsID;
@property (nonatomic, retain) NSString * currencyName;


/*!	\fn initWithTBXML:(TBXMLElement*)aXMLElement
 *	\brief Initializes the user account model object with the given xml data.
 *
 *	\param aXMLElement The XML data includes information such as currency name, id, and amount.
 *	\return n/a
 */
- (id)initWithTBXML:(TBXMLElement*)aXMLElement;

/*!	\fn updateWithTBXML:(TBXMLElement*)aXMLElement;
 *	\brief Updates the user account model object with the given xml data.
 *
 *	\param aXMLElement The XML data includes information such as currency name, id, and amount.
 *	\param checkEarnedPoints Indicates whether earned points and notification should be checked. This is specifically to prevent a bug where the earned alert pops up after a virtual good is purchased.
 *	\return n/a
 */
- (void)updateWithTBXML:(TBXMLElement*)aXMLElement shouldCheckEarnedPoints:(BOOL)checkEarnedPoints;

@end
