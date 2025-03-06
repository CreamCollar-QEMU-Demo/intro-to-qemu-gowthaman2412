MEMORY
{
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = ___
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = ___
}

SECTIONS
{
    .vectors :
    {
        *(.vectors)
    } > FLASH

    .text :
    {
        *(.text*)
        *(.rodata*)
    } > FLASH

    .data :
    {
        *(.data*)
    } > SRAM AT > FLASH

    .bss :
    {
        *(.bss*)
        *(COMMON)
    } > SRAM
}
