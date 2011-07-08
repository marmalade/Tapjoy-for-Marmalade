//--------------------------------------------------------------------------
// TapjoyAirplaySampleProj main file
//--------------------------------------------------------------------------

#include "s3e.h"

// Externs for functions which examples must implement
void ExampleInit();
void ExampleShutDown();
void ExampleRender();
bool ExampleUpdate();

//--------------------------------------------------------------------------
// Main global function
//--------------------------------------------------------------------------
S3E_MAIN_DECL void IwMain()
{
#ifdef EXAMPLE_DEBUG_ONLY
	// Test for Debug only examples
#endif
	
	// Example main loop
	ExampleInit();
	while (1)
	{
		s3eDeviceYield(0);
		s3eKeyboardUpdate();
		bool result = ExampleUpdate();
		if (
			 (result == false) ||
			 (s3eKeyboardGetState(s3eKeyEsc) & S3E_KEY_STATE_DOWN)
			 ||
			 (s3eKeyboardGetState(s3eKeyLSK) & S3E_KEY_STATE_DOWN)
			 ||
			 (s3eDeviceCheckQuitRequest())
			 )
			break;
		ExampleRender();
		s3eSurfaceShow();
	}
	ExampleShutDown();
}