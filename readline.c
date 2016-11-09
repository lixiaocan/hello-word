#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <readline/readline.h>
//#include <common.h>
#include <command.h>

int main()
{
	extern char console_buffer[];
	readline("please input something :");
	printf("you have input %s\n",console_buffer);
	return 0;
}
