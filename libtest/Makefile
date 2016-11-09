CC=gcc
AR=ar

SOFlag=-fPIC -shared
AFlag=-rsc
SRC=a.c b.c
OBJ=main

default:
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.
	$(CC) -o $(OBJ) main.c -L. -lab


O:
	$(CC) -c $(SRC)

A:
	echo "	$(AR) $(AFlag)  libab.a *.o "
	$(AR) $(AFlag)  libab.a *.o 

SO:
	$(CC) $(SOFlag) -o libab.so *.o

.PHONY:clean
clean:
	rm -rf libab* main *.o
