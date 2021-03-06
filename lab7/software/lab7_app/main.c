// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

/*
int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x90; //make a pointer to access the PIO block

	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO |= 0x1; //set LSB
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO &= ~0x1; //clear LSB
	}
	return 1; //never gets here
}
*/
int main()
{
	int i = 0;
	unsigned char val = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x90;
	volatile unsigned int *SW_PIO = (unsigned int*)0x70;
	volatile unsigned int *ACCUMULATE_PIO = (unsigned int*)0x80;
	volatile unsigned int *RESET_PIO = (unsigned int*)0x60;

	*LED_PIO = 0;
	while (1)
	{
		if (!(*RESET_PIO)) {
			val = 0;
			*LED_PIO = val;
		}
		if (!(*ACCUMULATE_PIO)) {
			val += *SW_PIO;
			*LED_PIO = val;
			while (!(*ACCUMULATE_PIO));
		}
	}
	return 1;
}
