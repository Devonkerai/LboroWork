/**
  *************************************************************************************
  * @file    classes.h
  * @author  DK, ST, GW
  * @version 1.0
  * @date    5 Feb 2015
  * @brief   Target Hardware layer - Definition of the ports and the classes. 
  *************************************************************************************
  */

#include <stdint.h>
// Timer class - Uses a HAL Delay to pause the system. This also checks to see if the buttons are pressed.
class Timer
{
	private:
		int msec;
	public:
		void Pause(int);
};
// Buzzer class - Toggles the buzzer on and off
class Buzzer
{
	public:
		void ToggleBuzzer();
};
// Seven Segment Display class - Uses member functions to write to selected ports to control the Seven Segement Display upto 8. SevenSegController() displays the integer argument passed in.
class SevenSegDisplay
{
	private:
		int numberDisplay;
	public:
		void SevenSegTurnOff();
		void SevenSegBitD(); // MSB
		void SevenSegBitC();
		void SevenSegBitB();
		void SevenSegBitA(); // LSB
		void SevenSegController(int);
};
// Door class - Check the door and sounds the buzzer for a period of time if open.
class Door
{
	private:
	  bool door;
	public:
		bool CheckDoorButton();
	
};
// Motor class - Uses mark and space for the time on and off (PWM). The motor can also be turned clockwise or anticlockwise.
class Motor
{
	private:
		Timer myTimer;
		int mark;
		int space;
		int pauseTime;
	public:
		void MotorOn();
		void MotorOff();
		void TurnMotorClockwise();
		void TurnMotorAntiClockwise();
		void MotorSpeed(int, int, int);
};
// Button Panel class - Returns status of the buttons on the washing machine. Also contains checking, latching and resetting functions for the buttons.
class ButtonPanel
{
	private:
		SevenSegDisplay myDisplay;
	  Motor myMotor;
	  
		bool acceptPort;
		bool cancelPort;
		bool prog1Port;
		bool prog2Port;
		bool prog3Port;
		bool latch;
		bool reset;
	
	public:
		bool Accept();
		bool Cancel();
		bool Prog1();
		bool Prog2();
		bool Prog3();
		bool LatchPort();
		bool ResetPort();
};
// Washing Operations class - Contains the washing stages to be called by the process controller.
class WashingOperations
{	
	private:
		SevenSegDisplay myDisplay;
		int numberDisplay;
	
	public:
		void Empty();
		void Fill();
		void Heat();
		void Wash();
		void Rinse();
		void Spin();
		void Dry();
		void Complete();
};

// Process Controller class - Base controller for the entire system. Controls the entered program and calls the washing operations in sequence. Can be used to pause and resume the system.
class ProcessController
{
	private:
		Timer myTimer;
		Buzzer myBuzzer;
		Motor myMotor;
	  Door myDoor;
	  ButtonPanel myButtons;
		WashingOperations myOperations;
		    
		int input[3]; // the operation's values (operation, speed, pause time)
		int i; // counter
		int mark;
		int space;
		int pauseTime;
	  bool skip;

	public:
		int EnteredProgramme();	
		void ProgrammeSelect(int [], int, int);
	  bool CheckACDButtons(int *, int, int);
		void PauseSystem(int *, int, int);
	  void ResumeSystem(int *, int, int);
		void Run();
};
