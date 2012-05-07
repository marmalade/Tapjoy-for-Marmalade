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
char g_AltMsg[128] = {0};
#define MAX_TOUCHES 10

bool exit = false;
int bannerY = 0;

Button* showOffersBtn = 0;

Button* getTapPointsBtn = 0;
Button* awardTapPointsBtn = 0;
Button* spendTapPointsBtn = 0;

Button* showFeaturedAppBtn = 0;
Button* showBannerAdBtn = 0;
Button* hideBannerAdBtn = 0;
Button* bannerPlus = 0;
Button* bannerMinus = 0;
Button* exitBtn = 0;

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
	int error = result->m_Error;
    int tapPoints = result->m_PointTotal;
	s3eDebugTracePrintf("GetTapPointsCB callback: %d", error);
	
	switch (error)
	{
		case TAPJOY_ERROR_NONE:
			sprintf(g_TouchEventMsg, "`x666666Tap Points: %d", tapPoints);
			s3eDebugTracePrintf("GetTapPointsCB called with amount: %d", tapPoints);
			break;
		case TAPJOY_ERROR_NETWORK_ERROR:
			sprintf(g_TouchEventMsg, "`x666666GetTapPointsCB Callback Error");
			break;
	}
	return 0;
}

static int32 GetVideoStatusCB(TapjoyVideoStatusResult* result, void* userData)
{
	int error = result->m_Error;
    int status = result->m_statusCode;
	s3eDebugTracePrintf("GetVideoStatusCB callback: %d", error);
	
	switch (error)
	{
		case TAPJOY_ERROR_NONE:
            sprintf(g_AltMsg, "`x666666Video Status: %d", status);
			break;
		case TAPJOY_ERROR_NETWORK_ERROR:
			sprintf(g_AltMsg, "`x666666Video Callback Error");
			break;
	}
	return 0;
}

static int32 GetEarnedTapPointsCB(TapjoyEarnedTapPointsResult* result, void* userData)
{
	int error = result->m_Error;
    int earned = result->m_Amount;
	s3eDebugTracePrintf("GetEarnedTapPointsCB callback: %d", error);
	
	switch (error)
	{
		case TAPJOY_ERROR_NONE:
			sprintf(g_AltMsg, "`x666666Just Earned: %d", earned);
			s3eDebugTracePrintf("GetEarnedTapPointsCB called with amount: %d", earned);
			break;
		case TAPJOY_ERROR_NETWORK_ERROR:
			sprintf(g_AltMsg, "`x666666GetEarnedTapPointsCB Callback Error");
			break;
	}
	return 0;
}

static int32 GetFeaturedAppCB(TapjoyGetFeaturedAppResult* result, void* userData)
{
	int error = result->m_Error;
	s3eDebugTracePrintf("Full Screen Ad callback: %d", error);
	
	switch (error)
	{
		case TAPJOY_ERROR_NONE:
			sprintf(g_AltMsg, "`x666666Full Screen Ad success");
			TapjoyShowFeaturedAppFullScreenAd();
			break;
		case TAPJOY_ERROR_NETWORK_ERROR:
			sprintf(g_AltMsg, "`x666666Full Screen Ad Network Error");
			break;
		case TAPJOY_ERROR_NO_CONTENT:
			sprintf(g_AltMsg, "`x666666Full Screen Ad No Content");
			break;
	}
	return 0;
}

static int32 GetBannerAdCB(TapjoyGetDisplayAdResult* result, void* userData)
{
	s3eDebugTracePrintf("Banner Ad callback");
	int error = result->m_Error;
	s3eDebugTracePrintf("Banner Ad callback: %d", error);
	
	switch (error)
	{
		case TAPJOY_ERROR_NONE:
			sprintf(g_AltMsg, "`x666666Banner Ad success");
			TapjoyShowDisplayAd();
			break;
		case TAPJOY_ERROR_NETWORK_ERROR:
			sprintf(g_AltMsg, "`x666666Banner Ad Network Error");
			break;
		case TAPJOY_ERROR_NO_CONTENT:
			sprintf(g_AltMsg, "`x666666Banner Ad No Content");
			break;
	}
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
    
    if (isPointInButton(event, showFeaturedAppBtn))
	{
		s3eDebugTracePrintf("showFeaturedApp");
		TapjoyGetFeaturedApp((TapjoyGetFeaturedAppCallbackFn)GetFeaturedAppCB, NULL);
	}
    
    if (isPointInButton(event, showBannerAdBtn))
	{
		s3eDebugTracePrintf("showBannerAd");
		TapjoySetDisplayAdView(0, bannerY, 320, 50);
        TapjoyGetDisplayAd(TJC_AD_BANNERSIZE_320X50, true, (TapjoyGetDisplayAdCallbackFn)GetBannerAdCB, NULL);
	}
    
    if (isPointInButton(event, bannerPlus))
	{
		s3eDebugTracePrintf("bannerPlus");
        bannerY += 10;
        
        // Lower limit so it doesn't overlap buttons.
        if (bannerY >= 100)
            bannerY = 100;
        
        TapjoySetDisplayAdView(0, bannerY, 320, 50);
	}

    if (isPointInButton(event, bannerMinus))
	{
		s3eDebugTracePrintf("bannerMinus");
        bannerY -= 10;
        TapjoySetDisplayAdView(0, bannerY, 320, 50);
	}
    
    if (isPointInButton(event, hideBannerAdBtn))
	{
		s3eDebugTracePrintf("hideBannerAd");
        TapjoyEnableBannerAdAutoRefresh(false);
        TapjoyHideDisplayAd();
	}
    
    if (isPointInButton(event, exitBtn))
    {
        exit = true;
    }
}


void SingleTouchMotionCB(s3ePointerMotionEvent* event)
{

}

//--------------------------------------------------------------------------
void ExampleInit()
{
	sprintf(g_TouchEventMsg, "`x666666Tap Points: Updating...");
	
    // Enable logcat logging.
    TapjoyEnableLogging(true);
    
	// This MUST be called first and foremost. Initializes the Tapjoy Connect system.
	TapjoyRequestConnect(
                         "bba49f11-b87f-4c0f-9632-21aa810dd6f1",        // REPLACE YOUR TAPJOY APP ID HERE
                         "yiQIURFEeKm0zbOggubu");                       // REPLACE YOUR TAPJOY SECRET KEY HERE
	
	TapjoyInitVideoAd((TapjoyVideoStatusCallbackFn)GetVideoStatusCB);
	TapjoySetEarnedTapPointsNotifier((TapjoyEarnedTapPointsCallbackFn)GetEarnedTapPointsCB);
	
	//Register for standard pointer events
	s3ePointerRegister(S3E_POINTER_BUTTON_EVENT, (s3eCallback)SingleTouchButtonCB, NULL);
	s3ePointerRegister(S3E_POINTER_MOTION_EVENT, (s3eCallback)SingleTouchMotionCB, NULL);
	
    
	// Init buttons.
	showOffersBtn = NewButton("Show Offers");
	
	getTapPointsBtn = NewButton("Get Tap Points");
	awardTapPointsBtn = NewButton("Award Tap Points");
	spendTapPointsBtn = NewButton("Spend Tap Points");
	
    showFeaturedAppBtn = NewButton("Show Full Screen Ad");
    showBannerAdBtn = NewButton("Get Banner Ad");
    hideBannerAdBtn = NewButton("Hide Banner Ad");
    
    bannerPlus = NewButton("banner +");
    bannerMinus = NewButton("banner -");
    
    exitBtn = NewButton("Exit");
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

    if (exit)
        return false;
    else
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
	
	s3eDebugPrint(20, 140, g_TouchEventMsg, 1);
	s3eDebugPrint(20, 165, g_AltMsg, 1);

	ButtonsRender();
}