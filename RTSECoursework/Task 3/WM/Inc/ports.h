/**
  *************************************************************************************
  * @file    ports.h
  * @author  DK, ST, GW
  * @version 1.0
  * @date    5 Feb 2015
  * @brief   Target Hardware layer - Definition of the ports. 
  *************************************************************************************
  */

#include <stdint.h>

extern "C" {  // this is needed to make C++ and C work together
  #include "board_startup.h"   // you DON'T need to worry about the contents of this file
}

// port base addresses
#define GPIO_C_BASE_ADDR  0x40000000 + 0x08000000 + 0x00000800
#define GPIO_D_BASE_ADDR  0x40000000 + 0x08000000 + 0x00000C00
#define GPIO_E_BASE_ADDR  0x40000000 + 0x08000000 + 0x00001000


// port register addresses
#define GPIO_C_MODE  (GPIO_C_BASE_ADDR)
#define GPIO_C_SPEED (GPIO_C_BASE_ADDR + 0x08)
#define GPIO_C_PULL  (GPIO_C_BASE_ADDR + 0x0C)
#define GPIO_C_IDR   (GPIO_C_BASE_ADDR + 0x10)
#define GPIO_C_ODR   (GPIO_C_BASE_ADDR + 0x14)

#define GPIO_D_MODE  (GPIO_D_BASE_ADDR)
#define GPIO_D_SPEED (GPIO_D_BASE_ADDR + 0x08)
#define GPIO_D_PULL  (GPIO_D_BASE_ADDR + 0x0C)
#define GPIO_D_IDR   (GPIO_D_BASE_ADDR + 0x10)
#define GPIO_D_ODR   (GPIO_D_BASE_ADDR + 0x14)

#define GPIO_E_MODE  (GPIO_E_BASE_ADDR)
#define GPIO_E_SPEED (GPIO_E_BASE_ADDR + 0x08)
#define GPIO_E_PULL  (GPIO_E_BASE_ADDR + 0x0C)
#define GPIO_E_IDR   (GPIO_E_BASE_ADDR + 0x10)
#define GPIO_E_ODR   (GPIO_E_BASE_ADDR + 0x14)


// Defining Ports
#define DODRPort (*GPIO_D_Odr_Addr)
#define CODRPort (*GPIO_C_Odr_Addr)
#define EIDRPort (*GPIO_E_Idr_Addr)

// Define Port Variables
#define motorPort 0x1000
#define motorDirectionPort 0x8000
#define buzzerPort 0x0040
#define allsegmentsPort 0x2D00
#define bitDsegmentPort 0x2000
#define bitCsegmentPort 0x0400
#define bitBsegmentPort 0x0800
#define bitAsegmentPort 0x0100
#define doorPort 0x0800
#define acceptButtonPort 0x1000
#define cancelButtonPort 0x2000
#define programme1Port 0x0100
#define programme2Port 0x0200
#define programme3Port 0x0400
#define resetPort 0x4000

// pointers to port registers
uint32_t * const GPIO_C_Mode_Addr = (uint32_t *) GPIO_C_MODE;
uint32_t * const GPIO_C_Speed_Addr = (uint32_t *) GPIO_C_SPEED;
uint32_t * const GPIO_C_Pull_Addr  = (uint32_t *) GPIO_C_PULL;
uint16_t * const GPIO_C_Idr_Addr   = (uint16_t *) GPIO_C_IDR;
uint16_t * const GPIO_C_Odr_Addr   = (uint16_t *) GPIO_C_ODR;

uint32_t * const GPIO_D_Mode_Addr  = (uint32_t *) GPIO_D_MODE;
uint32_t * const GPIO_D_Speed_Addr = (uint32_t *) GPIO_D_SPEED;
uint32_t * const GPIO_D_Pull_Addr  = (uint32_t *) GPIO_D_PULL;
uint16_t * const GPIO_D_Idr_Addr   = (uint16_t *) GPIO_D_IDR;
uint16_t * const GPIO_D_Odr_Addr   = (uint16_t *) GPIO_D_ODR;

uint32_t * const GPIO_E_Mode_Addr  = (uint32_t *) GPIO_E_MODE;
uint32_t * const GPIO_E_Speed_Addr = (uint32_t *) GPIO_E_SPEED;
uint32_t * const GPIO_E_Pull_Addr  = (uint32_t *) GPIO_E_PULL;
uint16_t * const GPIO_E_Idr_Addr   = (uint16_t *) GPIO_E_IDR;
uint16_t * const GPIO_E_Odr_Addr   = (uint16_t *) GPIO_E_ODR;

// port C - set to output
extern uint32_t GPIO_C_Mode;
extern uint32_t GPIO_C_Speed;
extern uint32_t GPIO_C_Pull;

// port D - set to output
extern uint32_t GPIO_D_Mode;
extern uint32_t GPIO_D_Speed;
extern uint32_t GPIO_D_Pull;

// port E - set to input
extern uint32_t GPIO_E_Mode;
extern uint32_t GPIO_E_Pull;


void ConfigurePortsOnBoard();
