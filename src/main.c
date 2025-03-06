#include <stdint.h>

// Vector table entries
#define STACK_TOP 0x20008000

// UART registers
#define UART0_BASE 0x4000C000
#define UART0_DR   (*((volatile uint32_t *)(UART0_BASE + 0x000)))
#define UART0_FR   (*((volatile uint32_t *)(UART0_BASE + 0x018)))
#define UART0_IBRD (*((volatile uint32_t *)(UART0_BASE + 0x024)))
#define UART0_FBRD (*((volatile uint32_t *)(UART0_BASE + 0x028)))
#define UART0_LCRH (*((volatile uint32_t *)(UART0_BASE + 0x02C)))
#define UART0_CTL  (*((volatile uint32_t *)(UART0_BASE + 0x030)))

// GPIO registers
#define GPIO_PORTF_BASE 0x40025000
#define GPIO_PORTF_DATA (*((volatile uint32_t *)(GPIO_PORTF_BASE + 0x3FC)))
#define GPIO_PORTF_DIR  (*((volatile uint32_t *)(GPIO_PORTF_BASE + 0x400)))
#define GPIO_PORTF_DEN  (*((volatile uint32_t *)(GPIO_PORTF_BASE + 0x51C)))

// System control
#define SYSCTL_BASE     0x400FE000
#define SYSCTL_RCGC2    (*((volatile uint32_t *)(SYSCTL_BASE + 0x108)))

// Function declarations
void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *s);
void delay(int count);
void main(void);

// Vector table
__attribute__ ((section(".vectors")))
void (* const vector_table[])(void) = {
    (void (*)(void))STACK_TOP,  // Initial stack pointer
    main                        // Reset handler
};

// Main entry point
void main(void) {
    // Enable UART0 and GPIO Port F
    SYSCTL_RCGC2 |= 0x21;  // Enable UART0 and GPIO Port F clocks
    
    // Small delay to ensure the clocks are stable
    delay(10000);
    
    // Configure UART
    uart_init();
    
    // Configure LED (PF0)
    GPIO_PORTF_DIR |= 0x01;  // Set PF0 as output
    GPIO_PORTF_DEN |= 0x01;  // Enable digital function on PF0
    
    uart_puts("LED Blinking Program Started\r\n");
    uart_puts("---------------------------\r\n");
    
    // Blink LED forever
    while (1) {
        // Turn LED on
        GPIO_PORTF_DATA |= 0x01;
        uart_puts("LED ON\r\n");
        delay(2000000);
        
        // Turn LED off
        GPIO_PORTF_DATA &= ~0x01;
        uart_puts("LED OFF\r\n");
        delay(2000000);
    }
}

// Initialize UART
void uart_init(void) {
    // Disable UART while configuring
    UART0_CTL = 0;
    
    // Configure baud rate (115200)
    UART0_IBRD = 8;
    UART0_FBRD = 44;
    
    // 8 bits, no parity, 1 stop bit, FIFOs enabled
    UART0_LCRH = 0x70;
    
    // Enable UART, TX, and RX
    UART0_CTL = 0x301;
}

// Send character to UART
void uart_putc(char c) {
    // Wait until there's space in the FIFO
    while (UART0_FR & 0x20);
    
    // Write the character
    UART0_DR = c;
}

// Send string to UART
void uart_puts(const char *s) {
    while (*s) {
        uart_putc(*s++);
    }
}

// Simple delay
void delay(int count) {
    while (count--);
}