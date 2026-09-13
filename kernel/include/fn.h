#ifndef __GATOS_FN_H__
#define __GATOS_FN_H__

#include <stddef.h>
#include <stdint.h>

void gatOS_strrev(char* str, int len);
char* gatOS_itoa(int n, char* str, int base);

size_t strlen(const char*);

#endif