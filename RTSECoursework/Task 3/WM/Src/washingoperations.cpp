#include "ports.h"
#include "classes.h"


// The Washing Machine Operation - Empty.
// Arguments: None
// Returns: Void
void WashingOperations::Empty()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 1;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Fill.
// Arguments: None
// Returns: Void
void WashingOperations::Fill()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 2;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Heat.
// Arguments: None
// Returns: Void
void WashingOperations::Heat()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 3;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Wash.
// Arguments: None
// Returns: Void
void WashingOperations::Wash()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 4;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Rinse.
// Arguments: None
// Returns: Void
void WashingOperations::Rinse()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 5;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Spin.
// Arguments: None
// Returns: Void
void WashingOperations::Spin()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 6;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Dry.
// Arguments: None
// Returns: Void
void WashingOperations::Dry()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 7;
		myDisplay.SevenSegController(numberDisplay);
	}
// The Washing Machine Operation - Complete.
// Arguments: None
// Returns: Void
void WashingOperations::Complete()
	{
		myDisplay.SevenSegTurnOff();
		int numberDisplay = 8;
		myDisplay.SevenSegController(numberDisplay);
	}
