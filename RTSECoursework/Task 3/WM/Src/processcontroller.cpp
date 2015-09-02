#include "ports.h"
#include "classes.h"

// Checks what programme was entered.
// Arguments: None
// Returns: Programme number
int ProcessController::EnteredProgramme()
	{
		int programmeEntered;

		// should bring down into one member function of mySelectProg?
		if (!myButtons.Prog1() && !myButtons.Prog2() && !myButtons.Prog3() && myButtons.Accept()) // 000 - 0
		{
			programmeEntered = 0;
		}
		else if (myButtons.Prog1() && !myButtons.Prog2() && !myButtons.Prog3() && myButtons.Accept()) // 001 - 1
		{
			programmeEntered = 1;
		}
		else if (!myButtons.Prog1() && myButtons.Prog2() && !myButtons.Prog3() && myButtons.Accept()) // 010 - 2
		{
			programmeEntered = 2;
		}
		else if (myButtons.Prog1() && myButtons.Prog2() && !myButtons.Prog3() && myButtons.Accept()) // 011 - 3
		{
			programmeEntered = 3;
		}
		else if (!myButtons.Prog1() && !myButtons.Prog2() && myButtons.Prog3() && myButtons.Accept()) // 100 - 4
		{
			programmeEntered = 4;
		}
		else if (myButtons.Prog1() && !myButtons.Prog2() && myButtons.Prog3() && myButtons.Accept()) // 101 - 5
		{
			programmeEntered = 5;
		}
		else if (!myButtons.Prog1() && myButtons.Prog2() && myButtons.Prog3() && myButtons.Accept()) // 110 - 6
		{
			programmeEntered = 6;
		}
		else if (myButtons.Prog1() && myButtons.Prog2() && myButtons.Prog3() && myButtons.Accept()) // 111 - 7
		{
			programmeEntered = 7;
		}
		else
		{
			programmeEntered = -1;
		}
		
		return programmeEntered;
	}
// Runs the chosen washing programme.
// Arguments:
// (1) Array defined for washing programme.
// (2) Counter when running through the washing programme.
// (3) Total time to pause
// Returns: Void
void ProcessController::ProgrammeSelect(int programme[], int i=0, int pauseTime = 0)
	{

		while(programme[i] != 8) // while programme is not the last stage (complete)
		{
			if (pauseTime == 0)
			{
				pauseTime=(programme[i+2]*1000);
			}
			
			skip = false;
			CheckACDButtons(programme, i, pauseTime);
			
			// form input array
			input[0] = programme[i];
			input[1] = programme[i+1];
			input[2] = programme[i+2];
			
			// Execute washing operation
			switch (input[0])
			{
				case 1:
					myOperations.Empty();
					break;
				case 2:
					myOperations.Fill();
					break;
				case 3:
					myOperations.Heat();
					break;
				case 4:
					myOperations.Wash();
					break;
				case 5:
					myOperations.Rinse();
					break;
				case 6:
					myOperations.Spin();
					break;
				case 7:
					myOperations.Dry();
					break;
				case 8:
					myOperations.Complete();
					break;
				default:
					break;
			}
			
			myTimer.Pause(250); // This prevents pressing accept once and it enters the program and then skips the first stage
			
			// Execute operation at specified speed
			switch (input[1]) // test motor speed
			{
				case 0:
					while (pauseTime > 0 && !skip) 
					{		
						myTimer.Pause(10);
						pauseTime = pauseTime-(10);
						skip = CheckACDButtons(programme, i, pauseTime);
						if (skip)
						{
							i=i+3;
						}
					}
					break;
				case 1:
					mark = 100;
					space = 500;
					while (pauseTime > 0 && !skip)
					{		
						myMotor.MotorOn();
						myTimer.Pause(mark);
						skip = CheckACDButtons(programme, i, pauseTime);
						if (skip)
						{
							i=i+3;
						}
						myMotor.MotorOff();
						myTimer.Pause(space);
						pauseTime=pauseTime-(mark+space);
						if (pauseTime < 0)
						{
							pauseTime=0;
						}
					}
					break;
				case 2:
					mark = 100;
					space = 0;
					while (pauseTime > 0 && !skip)
					{		
						myMotor.MotorOn();
						myTimer.Pause(mark);
						skip = CheckACDButtons(programme, i, pauseTime);
						if (skip)
						{
							i=i+3;
						}
						myMotor.MotorOff();
						myTimer.Pause(space);
						pauseTime=pauseTime-(mark+space);
					}
					break;
				default:
					break;
			}

			if (input[0] != 8 && !skip) // Only continue through array if programme operation is not 8.
			{
				i=i+3;
			}
		}
		
		// Final stage of programme
		if (programme[i] == 8)
		{
			myOperations.Complete();
			myTimer.Pause(7000); // 7 seconds to end the program
			myButtons.ResetPort();
			
		}
	
	}
// Checks whether the Accept or Cancel button have been pressed.
// Arguments: 
// (1) Array defined for washing programme.
// (2) Counter when running through the washing programme.
// (3) Time left to pause
// Returns: Value of skip
bool ProcessController::CheckACDButtons(int *programme, int i, int pauseTime)
{	
	skip = false;
	
	if (myButtons.Accept())
	{
		if (programme[i] != 8)
		{
			skip = true;
		}
		
	}
	if (myButtons.Cancel())
	{
		// wait for low (so holding doesn't affect the cancelling.)
		PauseSystem(programme, i, pauseTime);
	}
	
	if (myDoor.CheckDoorButton())
	{
		myBuzzer.ToggleBuzzer();
		myTimer.Pause(250);
	  myBuzzer.ToggleBuzzer();
		PauseSystem(programme, i, pauseTime);
	}
	return skip;
}
	
// Pauses the system.
// Arguments:
// (1) Array defined for washing programme.
// (2) Counter when running through the washing programme.
// (3) Time left to pause
// Returns: Void
void ProcessController::PauseSystem(int *programme, int i, int pauseTime)
{
		myMotor.MotorOff();
		myTimer.Pause(100);
		while (!myButtons.Accept() && !myButtons.Cancel())
			{
				myTimer.Pause(100); // stop switch bounce
				// if loop triggered on next high of cancel
					if (myButtons.Cancel())
					{
						myButtons.ResetPort();
						Run();
					}
				
					// if loop triggered on next high of accept
					// go back to current stage
					if (myButtons.Accept() && !myDoor.CheckDoorButton())
					{
						ResumeSystem(programme, i, pauseTime);
					}
			}

}
// Resumes the system.
// Arguments:
// (1) Array defined for washing programme.
// (2) Counter when running through the washing programme.
// (3) Time left to pause
// Returns: Void
void ProcessController::ResumeSystem(int *programme, int i, int pauseTime)
{
	// Continue executing the programme from where it was paused.
	ProgrammeSelect(programme, i, pauseTime);
}
// Runs the washing machine.
// Arguments: None
// Returns: Void
void ProcessController::Run()
	{
		ConfigurePortsOnBoard();
		
		// Washing programme Template: ["Operation (by number)", "Speed (0,1,2)", "Time (s)"] Speed of motor: 0 = off, 1 = slow, 2 = fast
	
		// Colour Wash
		static int colourWash[] = {
		 2, 0, 5,
		 3, 0, 2,
		 4, 1, 3,
		 1, 0, 4,
		 2, 0, 4,
		 5, 1, 4,
		 1, 0, 3,
		 6, 2, 6,
		 7, 0, 5,
		 8, 0, 5};
		
		// White Wash
		static int whiteWash[] = {
		 2, 0, 5,
		 3, 0, 6,
		 4, 1, 4,
		 1, 0, 4,
		 2, 0, 4,
		 5, 1, 5,
		 1, 0, 3,
		 6, 2, 8,
		 6, 1, 4,
		 7, 0, 5,
		 8, 0, 5};
		
		// Mixed Wash
		static int mixedWash[] = {
		 2, 0, 5,
		 3, 0, 6,
		 4, 1, 4,
		 1, 0, 4,
		 2, 0, 4,
		 5, 1, 5,
		 1, 0, 3,
		 6, 2, 8,
		 6, 1, 4,
		 7, 0, 5,
		 8, 0, 5};
		
		// Economy Wash
		static int economyWash[] = {
		 2, 0, 5,
		 3, 0, 6,
		 4, 1, 4,
		 1, 0, 4,
		 2, 0, 4,
		 5, 1, 5,
		 1, 0, 3,
		 6, 2, 8,
		 6, 1, 4,
		 7, 0, 5,
		 8, 0, 5};
		
		// programme 1
		static int program1[] = {
		 2, 0, 5,
		 3, 0, 6,
		 4, 1, 4,
		 1, 0, 4,
		 2, 0, 4,
		 5, 1, 5,
		 1, 0, 3,
		 6, 2, 8,
		 6, 1, 4,
		 7, 0, 5,
		 8, 0, 5};
		
		// programme 2
		static int program2[] = {
		 1, 0, 2,
		 2, 1, 2,
		 3, 2, 2,
		 4, 0, 2,
		 5, 2, 2,
		 6, 1, 2,
		 7, 0, 2,
		 8, 0, 5};
				

		while (myButtons.LatchPort())
		{
				// Programme 1
				if (myButtons.Prog1())
				{
					myButtons.LatchPort();
				}
				
				// Programme 2
				if (myButtons.Prog2())
				{
					myButtons.LatchPort();
				}
				
				// Programme 3
				if (myButtons.Prog3())
				{
					myButtons.LatchPort();
				}
				
				// Cancel Button
				if (myButtons.Cancel())
				{
					myButtons.ResetPort();
				}
				
				if (myButtons.Accept() && myDoor.CheckDoorButton())
				{
							myBuzzer.ToggleBuzzer(); // Buzzer on
							myTimer.Pause(300);
							myBuzzer.ToggleBuzzer(); // Buzzer off
				}
				
				// Accept Button
				if (myButtons.Accept() && !myDoor.CheckDoorButton())
				{
					switch(EnteredProgramme())
					{
						case 0:
							myButtons.ResetPort();
							ProgrammeSelect(whiteWash);
							break;
						case 1:
							myButtons.ResetPort();
							ProgrammeSelect(colourWash);
							break;
						case 2:
							myButtons.ResetPort();
							ProgrammeSelect(mixedWash);
							break;
						case 3:
							myButtons.ResetPort();
							ProgrammeSelect(economyWash);
							break;
						case 4:
							myButtons.ResetPort();
							ProgrammeSelect(program1);
							break;
						case 5:
							myButtons.ResetPort();
							ProgrammeSelect(program2);
							break;
						case 6:		
							break;
						case 7:
							break;
						default:
							break;
					}
				}
			}
	}
