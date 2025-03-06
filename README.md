# Trainer Repository

## Overview
Welcome to the Trainer Repository! This repository contains the necessary files and configurations for managing memory allocation in our embedded system project. This README provides an overview of the memory configuration tasks specifically related to the FLASH and SRAM sections of the linker file.

Github: ```https://github.com/Aruvi-B/Trainer_repo.git```

## Task Description

### Memory Part: Flash and SRAM
This task focuses on updating the memory allocation for FLASH and SRAM in the linker file to meet the requirements of our project. The specific allocations are as follows:

#### FLASH Memory Allocation
- **ORIGIN:** `0x00000000`
- **LENGTH:** Specify a new LENGTH as per project requirements

#### SRAM Memory Allocation
- **ORIGIN:** `0x20000000`
- **LENGTH:** Specify a new LENGTH as per project requirements

## Instructions

### 1. Open the Linker File
- Locate and open the appropriate linker script file in the repository.

### 2. Modify FLASH Allocation
- Find the section that defines FLASH memory.
- Update the **ORIGIN** to `0x00000000`.
- Set the **LENGTH** to the new value as specified by the project requirements.

### 3. Modify SRAM Allocation
- Locate the section that defines SRAM memory.
- Update the **ORIGIN** to `0x20000000`.
- Set the **LENGTH** to the new value as specified by the project requirements.

### 4. Save Changes
- After making the modifications, save the linker file.

### 5. Test the Configuration
- Compile the code to verify that the new memory allocations work correctly and that there are no errors.

## Contribution
If you have any suggestions or improvements regarding memory allocation or other aspects of this project, feel free to contribute or open an issue in this repository.

Use the Compilation steps:
```
arm-none-eabi-gcc -c -mcpu=cortex-m3 -mthumb -O2 -ffreestanding main.c -o main.o
arm-none-eabi-ld -T linker.ld main.o -o firmware.elf
arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
```
## Running the Program
```
qemu-system-arm -M lm3s6965evb -kernel firmware.elf
```

---

Happy coding!

