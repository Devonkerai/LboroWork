#include "ports.h"
#include "classes.h"

// Toggles the state of buzzer.
// Arguments: None
// Returns: Void
void Buzzer::ToggleBuzzer()
{
	CODRPort ^= buzzerPort;   // toggle PC6 buzzer
}
