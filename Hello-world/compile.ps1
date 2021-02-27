ml64 /nologo prog.asm /c
link /nologo /entry:start /nodefaultlib /subsystem:windows /machine:x64 prog.obj kernel32.lib user32.lib
