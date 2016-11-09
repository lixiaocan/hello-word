#include <stdio.h>

struct A
{
	int a;
	long b;
	int c;
};

struct B
{
	int c;
	int a;
	int b;
};


int main(void)
{
	
	struct A test1;
	test1.a=1;
	test1.b=2;
	test1.c=3;	

	printf("A.a = %d,A.b = %d, A.c = %d\n",test1.a,(int)test1.b,test1.c);

	struct B *test2 = (struct B *)&test1;

	printf("B.c = %d\n",test2->b);

	
	return 0;
}
