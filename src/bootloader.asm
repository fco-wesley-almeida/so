; The code sets the CPU to 16-bit mode and defines the start address as 0x7C00.

; It prints the character 'A' to the screen using a BIOS interrupt.

; It then disables interrupts and halts the CPU to prevent further execution.

; It pads the bootloader to 512 bytes and adds the boot signature 0xAA55 to signal 
; to the BIOS that this is a valid bootable sector.

[BITS 16] ; This directive tells the assembler (NASM) that the code that follows is 16-bit. 
         ; This is necessary because when the BIOS loads the bootloader, the CPU is in real mode, 
         ; which uses 16-bit addressing.

[ORG 0x7C00] ; This directive sets the origin (starting address) for the code. 
             ; In real mode, the BIOS loads the bootloader to memory address 0x7C00. 
             ; This informs the assembler that the code will start executing from this address.

start:
    mov ah, 0x0E ; This instruction moves the value 0x0E into the AH register. 
                 ; In this context, AH is part of the AX register, and it sets up the function number 
                 ; for the BIOS interrupt call. Here, 0x0E is the BIOS teletype function, 
                 ; which prints a character on the screen.
    
    mov al, 'A' ; This instruction moves the ASCII value of the character 'A' into the AL register. 
                ; The AL register will hold the character to be printed.
    int 0x10 ; This instruction triggers BIOS interrupt 0x10, which is responsible for video services. 
             ; When combined with AH set to 0x0E, it tells the BIOS to print the character in AL ('A') 
             ; to the screen.

    ; Loop forever
    cli ; his instruction clears the interrupt flag, effectively disabling interrupts.
        ; It ensures that no interrupts will disturb the execution of the next instruction.
    
    hlt ; This instruction halts the CPU. The CPU stops executing instructions and 
        ; will remain in this halted state until it is reset. 
        ; This creates an infinite loop as the bootloader has completed its task and there 
        ; is nothing more to do.

times 510-($-$$) db 0 ; This is a NASM directive to fill the remaining space in the sector with zeros. 
                      ; A sector is 512 bytes, and this directive ensures that the bootloader is exactly 
                      ; 512 bytes long. ($-$$) gives the current offset in the file, so 510-($-$$) 
                      ; calculates the number of bytes needed to pad the file to 510 bytes. 
                      ; The db 0 part means to fill these bytes with zeros.

dw 0xAA55 ; This instruction writes the boot signature 0xAA55 (or 55AA in little-endian format) at 
          ; the end of the boot sector. The BIOS checks for this signature to confirm that a 
          ; valid bootloader is present.
