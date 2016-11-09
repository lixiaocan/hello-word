#include <stdio.h>
#include <stdlib.h>

int main(int agrc, char *agrv[])
{
	if(agrc!=2)
		printf("input error\n");
	int flag = atoi(agrv[1]);

	if(!flag)
		printf("!flag\n");
	else
		printf("flag\n");
}
