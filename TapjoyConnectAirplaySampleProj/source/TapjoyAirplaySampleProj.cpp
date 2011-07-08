#include "s3e.h"
#include "s3eTapjoy.h"
#include <memory.h>
#include <string.h>
#include <stdio.h>
#include "ExamplesMain.h"

//Simple structure to track touches
struct CTouch
{
	int32 x; // position x
	int32 y; // position y
	bool active; // is touch active (currently down)
	int32 id; // touch's unique identifier
};


bool g_UseMultiTouch = false;
char g_TouchEventMsg[128] = {0};
#define MAX_TOUCHES 10


Button* showOffersBtn = 0;
Button* showFeaturedAppBtn = 0;
Button* getTapPointsBtn = 0;
Button* awardTapPointsBtn = 0;
Button* spendTapPointsBtn = 0;


bool isPointInButton(s3ePointerEvent* event, Button* button)
{
	if (event->m_x < button->m_XPos)
		return false;
	
	if (event->m_x > button->m_XPos + button->m_Width)
		return false;
	
	if (event->m_y < button->m_YPos)
		return false;
	
	if (event->m_y > button->m_YPos + button->m_Height)
		return false;
	
	return true;
}


static int32 GetTapPointsCB(TapjoyGetTapPointsResult* result, void* userData)
{
	int tapPoints = result->m_PointTotal;
	
	sprintf(g_TouchEventMsg, "`x666666Tap Points: %d", tapPoints);
	
	s3eDebugTracePrintf("GetTapPointsCB called with amount: %d", tapPoints);
	
	return tapPoints;
}


static int32 GetFeaturedAppCB(TapjoyGetFeaturedAppResult* result, void* userData)
{
	s3eDebugTracePrintf("Featured App callback");

//	if (result != NULL)
//	{
//		TapjoyFeaturedAppObject featuredApp = result->m_FeaturedAppObject;
//		s3eDebugTracePrintf("Featured App Name: %s, Cost: %s, Description: %s", featuredApp.m_Name, featuredApp.m_Cost, featuredApp.m_Description);
//		s3eDebugTracePrintf("Featured App Image URL %s ", featuredApp.m_IconURL);
//	}

	TapjoyShowFeaturedAppFullScreenAd();
	
	return 0;
}


void SingleTouchButtonCB(s3ePointerEvent* event)
{
	// Don't register press events, actions will occur on release.
	if (event->m_Pressed)
	{
		return;
	}
	
	if (isPointInButton(event, showOffersBtn))
	{
		TapjoyShowOffers();
	}
	
	if (isPointInButton(event, showFeaturedAppBtn))
	{
		s3eDebugTracePrintf("showFeaturedApp");
		TapjoyGetFeaturedApp((TapjoyGetFeaturedAppCallbackFn)GetFeaturedAppCB, NULL);
	}
	
	if (isPointInButton(event, getTapPointsBtn))
	{
		sprintf(g_TouchEventMsg, "`x666666Tap Points: Updating...");
        TapjoyGetTapPoints((TapjoyGetTapPointsCallbackFn)GetTapPointsCB, NULL);
		//TapjoyGetTapPoints((TapjoyGetTapPointsCallbackFn)GetTapPointsCB, NULL);
	}
	
	if (isPointInButton(event, awardTapPointsBtn))
	{
		sprintf(g_TouchEventMsg, "`x666666Tap Points: Updating...");
		TapjoyAwardTapPoints(5, (TapjoyAwardTapPointsCallbackFn)GetTapPointsCB, NULL);
	}
	
	if (isPointInButton(event, spendTapPointsBtn))
	{
		sprintf(g_TouchEventMsg, "`x666666Tap Points: Updating...");
		TapjoySpendTapPoints(5, (TapjoySpendTapPointsCallbackFn)GetTapPointsCB, NULL);
	}
}


void SingleTouchMotionCB(s3ePointerMotionEvent* event)
{

}

//--------------------------------------------------------------------------
void ExampleInit()
{
	sprintf(g_TouchEventMsg, "`x666666Tap Points: Updating...");
	
	// This MUST be called first and foremost. Initializes the Tapjoy Connect system.
	TapjoyRequestConnect("bba49f11-b87f-4c0f-9632-21aa810dd6f1", "yiQIURFEeKm0zbOggubu");
	
	// Set Tapjoy ui bottom-to-top transition effect.
	//TapjoySetTransitionEffect(0);
	
	// Query Tap Points.
	//TapjoyGetTapPoints((TapjoyGetTapPointsCallbackFn)GetTapPointsCB, NULL);
	
	// Query featured ad.
	//TapjoyGetFeaturedApp((TapjoyGetFeaturedAppCallbackFn)GetFeaturedAppCB, NULL);
	
	// Set banner on the bottom of the screen.
	TapjoySetDisplayAdView(0, 430, 320, 50);
	
	// Initialize Tapjoy banner ads.
	TapjoyGetDisplayAd("320x50", true, NULL, NULL);
	
	//Register for standard pointer events
	s3ePointerRegister(S3E_POINTER_BUTTON_EVENT, (s3eCallback)SingleTouchButtonCB, NULL);
	s3ePointerRegister(S3E_POINTER_MOTION_EVENT, (s3eCallback)SingleTouchMotionCB, NULL);
	
	// Init buttons.
	showOffersBtn = NewButton("Show Offers");
	showFeaturedAppBtn = NewButton("Show Featured App");
	getTapPointsBtn = NewButton("Get Tap Points");
	awardTapPointsBtn = NewButton("Award Tap Points");
	spendTapPointsBtn = NewButton("Spend Tap Points");
	
	SetButtonScale(3);
}


//--------------------------------------------------------------------------
void ExampleShutDown()
{
	s3ePointerUnRegister(S3E_POINTER_BUTTON_EVENT, (s3eCallback)SingleTouchButtonCB);
	s3ePointerUnRegister(S3E_POINTER_MOTION_EVENT, (s3eCallback)SingleTouchMotionCB);
	
	DeleteButtons();
}


//--------------------------------------------------------------------------
bool ExampleUpdate()
{
	s3ePointerRegister(S3E_POINTER_BUTTON_EVENT, (s3eCallback)SingleTouchButtonCB, NULL);
	s3ePointerRegister(S3E_POINTER_MOTION_EVENT, (s3eCallback)SingleTouchMotionCB, NULL);

	return true;
}


//--------------------------------------------------------------------------
// The following function clears the screen and outputs the
// phrase "Hello World". It uses The s3eDebugPrint() function
// to print the phrase.
//--------------------------------------------------------------------------
void ExampleRender()
{
	// Get pointer to the screen surface
	// (pixel depth is 2 bytes by default)
	uint16* screen = (uint16*)s3eSurfacePtr();
	int height = s3eSurfaceGetInt(S3E_SURFACE_HEIGHT);
	int width = s3eSurfaceGetInt(S3E_SURFACE_WIDTH);
	int pitch = s3eSurfaceGetInt(S3E_SURFACE_PITCH);
	
	// Clear screen to white
	for (int i=0; i < height; i++)
	{
		memset((char*)screen + pitch * i, 255, (width * 2));
	}
	
	// This was causing an error to pop up.
	s3ePointerUpdate();
	
	ButtonsRender();
	
	s3eDebugPrint(20, 20, g_TouchEventMsg, 1);
}