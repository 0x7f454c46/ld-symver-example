#include <stdio.h>

__asm__(".symver xyz_old,xyz@VER_1");
__asm__(".symver xyz_new,xyz@@VER_2");

void xyz_old(void)
{
	printf("I'm original xyz()\n");
}

void xyz_new(void)
{
	printf("I'm new xyz()\n");
}

void pqr(void)
{
	printf("Some new pqr()\n");
}
