.model  flat

; PUBLIC  _add_3

_TEXT  SEGMENT

_add_3  PROC

    push  ebp
    mov   ebp, esp

    mov   eax, DWORD PTR  8[ebp]  ;  The 1st argument is ebp +  8
    add   eax, DWORD PTR 12[ebp]  ;  The 2nd argument is ebp + 12
    add   eax, DWORD PTR 16[ebp]  ;  The 3rd argument is ebp + 16


    pop   ebp
    ret   0

_add_3 ENDP

_TEXT  ENDS

END          ; END directive required at end of file
