#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int agrc , char *argv[])
{
	unsigned int ip1, ip2, ip3, ip4;
	if(agrc!=2)
	{
		printf("Input error\n");
		exit(-1);
	}
	
	if((strncmp("255.255.255.0", argv[1],11)==0) || (strncmp("255.255.0.0", argv[1],9)==0))
	{
		printf("set 255.255.255.0 or 255.255.0.0 invalid\n");
		printf("%s\n",argv[1]);
	}
	else
	{
		printf("set ok\n");
	}
   	 sscanf(argv[1] , "%d.%d.%d.%d", &ip1, &ip2, &ip3, &ip4);
   	 if (ip3 == 0 || ip3 == 255)
    	{
        	printf("sscanf error\n");
    	}
}
