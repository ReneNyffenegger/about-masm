;
; Declare external symbols (function names):
;
EXTRN __imp_ExitProcess:PROC
EXTRN __imp_MessageBoxA:PROC

;
; Start data segment that contains the data
; in our program:
;
_DATA SEGMENT

;
; Symbol for zero (00H) terminated string.
;
  $HELLO DB 'Hello...', 00H

;
; Align text on 16-bit boundaries. Therfore
; the location counter is increased by;
; 7 bytes ('Hello...\0' has 9 bytes, 9+7 =16)
;
  ORG $+7

;
; Another Symbol for zero terminated string.
;
  $WORLD DB '...world', 00H

_DATA ENDS


;
; Start the text segment that contains the
; machine code in our program:
;
_TEXT SEGMENT

;
; «Our» function. The name is start. When
; linking, we pass that name as entry point.
; This is the function that Window's loader
; calls after the exe is loaded.
;
start PROC

;
; The following commented command would
; move (save) the passed value (pointer to
; the PEB) on the (shadow?) part of the
; stack.
; Since I have no use for this value in this
; hello world program, I don't do that:
;
;    mov QWORD PTR [rsp+8], rcx

;
; We're going to call functions, so
; we reserve 'Shadow space' (aka 'spill
; space' or 'home space' for the callee
; (see https://stackoverflow.com/a/30194393/180275):
;

    sub rsp, 40         ; 00000028H

;
; Preparing four parameters for MessageBox
; before calling it:
;
;   First parameter is passed in rcx or ecx.
;   Value is HWND which is 32-bit. Therefore
;   using ecx (rather than 64-bit rcx).
;     xor register, register
;   sets value of register to 0:

    xor ecx   , ecx

;
;   Second parameter is passed in rdx/edx.
;   We pass a pointer to a string. Pointers
;   are 64-bit, so we use rdx (rather than
;   edx)
;
    lea rdx   , OFFSET $WORLD

;
;   The third parameter (passed in r8/r8d)
;   is also a pointer to a string.
;
    lea r8    , OFFSET $HELLO

;
;   Setting the fourth parameter
;   to 0:
;
    xor r9d   , r9d

;
; With the parameter values put into the
; respective function, we can finally
; call the WinAPI function:
;
  call  QWORD PTR __imp_MessageBoxA

;
; Preparing the (only) parameter for the next
; call: ecx (the first paramter) is set to 0.
;
;   (If this is necessary, I am not sure because
;    ecx was already set to 0 in the previous
;    call. I don't know if the callee is allowed
;    to change the value of the register)
;
;
  xor ecx, ecx

;
; Call ExitProcess(0)
;
  call  QWORD PTR __imp_ExitProcess

;
; Recover Home space (that was allocated
; earlier in this function):
;
  add rsp, 40
  ret 0

;
; End of function:
;
start ENDP

;
; End of segment:
;
_TEXT ENDS

;
; End of the module:
;
END
