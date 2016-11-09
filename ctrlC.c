#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	int i = 0;
	printf("%s\n",__FUNCTION__);
	while(1)
	{
		printf("num %d\n",i);
		i++;
		printf("\33[4m\033[35m\33[40mhello word\n\33[0m");
		sleep(1);
		if(i>5)
		{
			printf("\33[0m");
			exit(0);

		}
	}
	
	return 0;
}
