#include "ports.h"
#include "classes.h"

// Returns the status when the Accept button is pressed.
// Arguments: None
// Returns: State of accept
bool ButtonPanel::Accept()
{
	acceptPort = (EIDRPort) & acceptButtonPort;
	return acceptPort;
}
// Returns the status when the Cancel button is pressed.
// Arguments: None
// Returns: State of cancel
bool ButtonPanel::Cancel()
{
	cancelPort = (EIDRPort) & cancelButtonPort;
	return cancelPort;
}
// Returns the status when the Programme 1 button is pressed.
// Arguments: None
// Returns: State of programme button 1
bool ButtonPanel::Prog1()
{
	prog1Port = (EIDRPort) & programme1Port;
	return prog1Port;
}
// Returns the status when the Programme 2 button is pressed.
// Arguments: None
// Returns: State of programme button 2
bool ButtonPanel::Prog2()
{
	prog2Port = (EIDRPort) & programme2Port;
	return prog2Port;
}
// Returns the status when the Programme 3 button is pressed.
// Arguments: None
// Returns: State of programme button 3
bool ButtonPanel::Prog3()
{
	prog3Port = (EIDRPort) & programme3Port;
	return prog3Port;
}
// Latches the LED when a button is pressed.
// Arguments: None
// Returns: State of latch port
bool ButtonPanel::LatchPort()
{
	latch = DODRPort |= resetPort;  // PD14 HIGH accept switch input
	return latch;
}
// Resets the LEDs and turns off the motor and seven segment display.
// Arguments: None
// Returns: State of reset port
bool ButtonPanel::ResetPort()
{
	myMotor.MotorOff();
	myDisplay.SevenSegTurnOff();
	reset = DODRPort &= ~resetPort;  // PD14 LOW reset switches
	return reset;
}
