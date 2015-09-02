#include "ports.h"
#include "classes.h"

// Turns the motor on.
// Arguments: None
// Returns: Void
void Motor::MotorOn()
{
	DODRPort |= motorPort;  // PD12 motor control - on
}
// Turns the motor off.
// Arguments: None
// Returns: Void
void Motor::MotorOff()
{
	DODRPort &= ~motorPort;  // PD12 motor control - off
}
// Turns the motor clockwise.
// Arguments: None
// Returns: Void
void Motor::TurnMotorClockwise()
{
	DODRPort &= ~motorDirectionPort;  // PD15 motor direction - clockwise
}
// Turns the motor anti-clockwise.
// Arguments: None
// Returns: Void
void Motor::TurnMotorAntiClockwise()
{
	DODRPort |= motorDirectionPort;  // PD15 motor direction - anticlockwise
}
// Spins the motor at different speeds
// Arguments: 
// (1) Total time to spin motor for (seconds)
// (2) Total time high for (milliseconds)
// (3) Total time low for (milliseconds)
// Returns: Void
void Motor::MotorSpeed(int pauseTime, int mark, int space)
{
	pauseTime=pauseTime*1000; // puts length into milliseconds
	while (pauseTime > 0)
	{		
		MotorOn();
		myTimer.Pause(mark);
		MotorOff();
		myTimer.Pause(space);
		pauseTime = pauseTime - (mark + space);
	}
}
