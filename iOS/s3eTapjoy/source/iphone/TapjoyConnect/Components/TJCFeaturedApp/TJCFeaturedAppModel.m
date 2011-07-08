//
//  TJCFeaturedAppModel.m
//  TapjoyConnect
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy. All rights reserved.
//

#import "TJCFeaturedAppModel.h"
#import "TJCFeaturedAppManager.h"
#import "TJCConstants.h"
#import "TJCLog.h"

@implementation TJCFeaturedAppModel

@synthesize cost = cost_;
@synthesize storeID = storeID_;
@synthesize name = name_;
@synthesize description = description_;
@synthesize iconURL = iconURL_;
@synthesize largeIconURL = largeIconURL_;
@synthesize redirectURL = redirectURL_;
@synthesize amount = amount_;
@synthesize maxTimesToDisplayThisApp = maxTimesToDisplayThisApp_;
@synthesize fullScreenAdURL = fullScreenAdURL_;

- (id) initWithTBXML:(TBXMLElement*) aXMLElement
{
	if ((self = [super init]))
	{
		if (!aXMLElement) 
		{
			return self;
		}
		cost_ = [[TBXML textForElement:[TBXML childElementNamed:@"Cost" parentElement:aXMLElement]] retain];
		storeID_ = [[TBXML textForElement:[TBXML childElementNamed:@"StoreID" parentElement:aXMLElement]] retain];
		name_ = [[TBXML textForElement:[TBXML childElementNamed:@"Name" parentElement:aXMLElement]] retain];
		description_ = [[TBXML textForElement:[TBXML childElementNamed:@"Description" parentElement:aXMLElement]] retain];
		iconURL_ = [[TBXML textForElement:[TBXML childElementNamed:@"IconURL" parentElement:aXMLElement]] retain];
		largeIconURL_ = [[TBXML textForElement:[TBXML childElementNamed:@"MediumIconURL" parentElement:aXMLElement]] retain];
		redirectURL_ = [[TBXML textForElement:[TBXML childElementNamed:@"RedirectURL" parentElement:aXMLElement]] retain];
		amount_ = [TBXML numberForElement:[TBXML childElementNamed:@"Amount" parentElement:aXMLElement]];
		
		if (maxTimesToDisplayThisApp_ < 0)
		{
			maxTimesToDisplayThisApp_ = TJC_FEATURED_APP_DEFAULT_MAX_DISPLAY_COUNT;
		}
		
		fullScreenAdURL_ = [[TBXML textForElement:[TBXML childElementNamed:@"FullScreenAdURL" parentElement:aXMLElement]] retain];
	}
	return self;
}


- (void) dealloc
{
	[TJCLog logWithLevel:LOG_DEBUG format:@"TJCFeaturedAppRequestHandler dealloc"];
	
	[cost_ release];
	[storeID_ release];
	[name_ release];
	[redirectURL_ release];
	[iconURL_ release];
	[largeIconURL_ release];
	[description_ release];
	
	[super dealloc];
}

@end
