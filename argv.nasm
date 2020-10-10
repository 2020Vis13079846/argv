; Based on problem: https://stackoverflow.com/questions/12678230/how-to-print-argv0-in-nasm

[bits 32]

section .data
       hello db "%s (%i args)", 10, 0

section .text

global start
extern _exit
extern _printf

start:
       pop     eax ; Store 'argc' into EAX
       pop     ebx ; Store 'argv' into EBX

       ; Align stack on a 16 bytes boundary,
       ; as we'll use C library functions
       mov     ebp,                esp
       and     esp,                0xFFFFFFF0

       ; Stack space for local variables
       ; A little more space than needed, but that will
       ; ensure the stack is still aligned
       sub     esp,                16

       ; Call 'printf': printf( hello, ebx, eax );
       mov     dword[ esp ],       hello
       mov     dword[ esp + 4 ],   ebx
       mov     dword[ esp + 8 ],   eax
       call   _printf

       ; Call 'exit': exit( 0 );
       mov     dword[ esp ],       0
       call   _exit
