#include <stdio.h>
#include <unistd.h>

int main(int argc,char *argv[])
{
//	if(access("./1",F_OK)==0)
//		printf("file of\n");

	int i=0;
	i=atoi(argv[1]);
	if(!i)
	{
		printf("(!i) =%d\n ",!i);
	}
	else
	{
		printf("else\n");
	}
	
	return 0;
}
////
