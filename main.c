#include <stdio.h>

long * INTCPS_CONTROL = (long*) 0x48200048;
// register to unmask interrupt lines
long * INTCPS_MIR0 = (long*) 0x48200084;

long * GPIO1_IRQSTATUS1 = (long*) 0x48310018;

// register to control module interface clock activity
long * CM_ICLKEN_WKUP = (long*) 0x48004C10;
// register to control module functional clock activity
long * CM_FCLKEN_WKUP = (long*) 0x48004C00;
// register to control pad configuration (used setting mux mode and resistors)
long * CONTROL_PADCONF_SYS_BOOT2 = (long*) 0x48002A0C;

// register to enable interrupt on rising edge
long * GPIO1_RISINGDETECT = (long*) 0x48310048;
// register to enable interrupts
long * GPIO1_IRQENABLE1 = (long*) 0x4831001C;
// register to enable input/output
long * GPIO1_OE = (long*) 0x48310034;
// register to read from GPIO 1
long * GPIO1_DATAIN = (long*) 0x48310038;

long BTN = (1 << 4);

__interrupt void c_intIRQ() {
    // clear interrupt flag
    *INTCPS_CONTROL |= (1 << 0);
    //*GPIO1_IRQENABLE1 &= ~BTN;
    //printf("hello interrupt!\n");
    //__asm(" SUBS PC, LR, #4");
}

void main(void) {
    // unmask interrupt line 29 (GPIO 1)
    *INTCPS_MIR0 &= ~(1 << 29);

    // enable interface clock (bit 3 for GPIO 1)
    *CM_ICLKEN_WKUP |= (1 << 3);
    // enable functional clock (bit 3 for GPIO 1)
    *CM_FCLKEN_WKUP |= (1 << 3);

    // set mux mode to 4 (GPIO)
    *CONTROL_PADCONF_SYS_BOOT2 &= ~(1 << 16);
    *CONTROL_PADCONF_SYS_BOOT2 &= ~(1 << 17);
    *CONTROL_PADCONF_SYS_BOOT2 |= (1 << 18);

    // clear interrupt flag
    // *GPIO1_IRQSTATUS1 |= BTN;
    *GPIO1_RISINGDETECT |= BTN;
    *GPIO1_IRQENABLE1 |= BTN;

    // enable input on pin
    *GPIO1_OE |= BTN;

    _enable_interrupts();

    while(1) {
        if(*GPIO1_DATAIN & BTN) {
            printf("Button pressed\n");
        } else {
            printf("Button NOT pressed\n");
        }
    }
}
