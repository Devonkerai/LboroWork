/**
  *************************************************************************************
  * @file    main.cpp
  * @author  DK, ST, GW
  * @version 1.0
  * @date    5 Feb 2015
  * @brief   Application layer - Code to test the full range of the washing machine. 
  *************************************************************************************
  */
  
#include "main.h"
#include "ports.h"
#include "classes.h"

/*
Tasks to complete for Task 3:
- Check code consistency with our UML diagrams - make appropriate changes
- Write Report
*/

int main(void)
{
  // STM32F3 Discovery Board initialization

  // Pre-requisites
  board_startup();
	
	ProcessController myController;
	myController.Run();
	return 0;
}
