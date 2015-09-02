#include "ports.h"
#include "classes.h"

// Displays a zero on the display.
// Arguments: None
// Returns: Void
void SevenSegDisplay::SevenSegTurnOff()
{
	DODRPort &= ~allsegmentsPort;
}
// Displays the value of the most significant bit (bit D).
// Arguments: None
// Returns: Void
void SevenSegDisplay::SevenSegBitD()
{
	DODRPort |= bitDsegmentPort;
}
// Displays the value of bit C.
// Arguments: None
// Returns: Void
void SevenSegDisplay::SevenSegBitC()
{
	DODRPort |= bitCsegmentPort;
}
// Displays the value of bit B.
// Arguments: None
// Returns: Void
void SevenSegDisplay::SevenSegBitB()
{
	DODRPort |= bitBsegmentPort;
}
// Displays the value of the least significant bit (bit A).
// Arguments: None
// Returns: Void
void SevenSegDisplay::SevenSegBitA()
{
	DODRPort |= bitAsegmentPort;
}
// Displays the value on the seven segment display when a number is passed in.
// Arguments: Number to show on the seven segment display
// Returns: Void
void SevenSegDisplay::SevenSegController(int numberDisplay)
{
	SevenSegTurnOff();
	
	if (numberDisplay == 0)
	{
		SevenSegTurnOff();
	}
	if (numberDisplay == 1)
	{
		SevenSegBitA();
	}
	if (numberDisplay == 2)
	{
		SevenSegBitB();
	}
	if (numberDisplay == 3)
	{
		SevenSegBitB();
		SevenSegBitA();
	}
	if (numberDisplay == 4)
	{
		SevenSegBitC();
	}
	if (numberDisplay == 5)
	{
		SevenSegBitC();
		SevenSegBitA();
	}
	if (numberDisplay == 6)
	{
		SevenSegBitC();
		SevenSegBitB();
	}
	if (numberDisplay == 7)
	{
		SevenSegBitA();
		SevenSegBitB();
		SevenSegBitC();
	}
	if (numberDisplay == 8)
	{
		SevenSegBitD();
	}
}
