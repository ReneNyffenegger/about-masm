prog.exe: main.obj add_3.obj
	cl /nologo /Feprog.exe main.obj add_3.obj 
	prog.exe

main.obj: main.c
	cl /W4 /nologo /c main.c

add_3.obj: add_3.asm
	ml /nologo /c add_3.asm
