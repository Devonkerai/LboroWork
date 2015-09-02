#include "ports.h"
#include "classes.h"

// Checks the door is open.
// Arguments: None
// Returns: State of door
bool Door::CheckDoorButton()
{
	door = (EIDRPort) & doorPort;
	return door;
}
