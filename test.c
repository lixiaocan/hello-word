#include <stdio.h>
#include <stdlib.h>

typedef struct bri
{
	int year;
	int day;
}time;

typedef struct student
{
	char name[5];
	time times[2];
}info;

info studs[2] = 
{
	{
		"li",
		2016,12,
		2015,11,	
	},
	{
		"yan",
		2014,10,
		2013,9,	
	},
};

info new = 
{
	.name = "li",
	
};
int main (void)
{
	printf("%s\n",new.name);
	printf("the fist student is %s,time %d,%d,\t%d,%d\n",studs[0].name,\
	studs[0].times[0].year,studs[0].times[0].day,\
	studs[0].times[1].year,studs[0].times[1].day);
	return 0;
}
