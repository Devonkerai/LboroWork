#include "ports.h"
#include "classes.h"

// Creates a delay (in milliseconds).
// Arguments:
// (1) Time to pause in milliseconds
// Returns: Void
void Timer::Pause(int msec)
{
	while (msec > 0)
	{		
		HAL_Delay(10);
		msec=msec-(10);
	}
}
