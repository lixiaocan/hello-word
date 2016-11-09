#include <stdio.h>

struct A
{
	int a;
	int b;
};

struct B
{
	int c;
	int a;
};


int main(void)
{
	
	struct A test1;
	test1.a=1;
	test1.b=2;

	printf("A.a = %d,A.b = %d\n",test1.a,test1.b);

	struct B test2 = (struct B )test1;

	printf("B.c = %d\n",test2.c);

	
	return 0;
}
