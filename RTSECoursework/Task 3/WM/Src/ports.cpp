#include "ports.h"
#include "classes.h"

// port C - set to output
uint32_t GPIO_C_Mode = 0x55555555;  // 0b01010101010101010101010101010101  00 = input, 01 = output
uint32_t GPIO_C_Speed = 0xFFFFFFFF; // 0b11111111111111111111111111111111  11 - high speed output only
uint32_t GPIO_C_Pull = 0xaaaaaaaa;  // 0b10101010101010101010101010101010  00 none, 01 = pull up, 10 pull down

// port D - set to output
uint32_t GPIO_D_Mode = 0x55555555;  // 0b01010101010101010101010101010101  00 = input, 01 = output
uint32_t GPIO_D_Speed = 0xFFFFFFFF; // 0b11111111111111111111111111111111  11 - high speed output only
uint32_t GPIO_D_Pull = 0xaaaaaaaa;  // 0b10101010101010101010101010101010  00 none, 01 = pull up, 10 pull down

// port E - set to input
uint32_t GPIO_E_Mode = 0x00000000;  // 0b00000000000000000000000000000000  00 = input, 01 = output
uint32_t GPIO_E_Pull = 0x55555555;    // 0b10101010101010101010101010101010  00 none, 01 = pull up, 10 pull down

// Configures the ports
// Arguments: None
// Returns: Void
void ConfigurePortsOnBoard(){
	
  // configure port C
  *GPIO_C_Mode_Addr =  (uint32_t) GPIO_C_Mode;
  *GPIO_C_Speed_Addr = (uint32_t) GPIO_C_Speed;
  *GPIO_C_Pull_Addr =  (uint32_t) GPIO_C_Pull;

  // configure port D
  *GPIO_D_Mode_Addr =  (uint32_t) GPIO_D_Mode;
  *GPIO_D_Speed_Addr = (uint32_t) GPIO_D_Speed;
  *GPIO_D_Pull_Addr =  (uint32_t) GPIO_D_Pull;

  // configure port E
  *GPIO_E_Mode_Addr =  (uint32_t) GPIO_E_Mode;
  *GPIO_E_Pull_Addr =  (uint32_t) GPIO_E_Pull;
}
