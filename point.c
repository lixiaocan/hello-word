#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>

unsigned char buf[] = {0x10,0x00,0x30};

int main(void)
{
	int i=0;
	char *sizep =buf;
	char *p = buf;
	while(*p != '\0')
	{
		printf("p[%d]=%x\n",i++,*p++);
	}
	return 0;
}
