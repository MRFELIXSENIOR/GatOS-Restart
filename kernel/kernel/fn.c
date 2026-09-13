#include "fn.h"

void gatOS_strrev(char *str, int len) {
    int start = 0;
    int end = len - 1;
    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        start++;
        end--;
    }
}

char* gatOS_itoa(int num, char *str, int base) {
    int i = 0;
    int is_negative = 0;

    // Handle 0 explicitly
    if (num == 0) {
        str[i++] = '0';
        str[i] = '\0';
        return str;
    }

    // Standard itoa handles standard bases between 2 and 36
    if (base < 2 || base > 36) {
        str[0] = '\0';
        return str;
    }

    // Negative numbers are only handled for base 10 in standard implementations
    if (num < 0 && base == 10) {
        is_negative = 1;
        num = -num;
    }

    // Process individual digits
    while (num != 0) {
        int rem = num % base;
        str[i++] = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
        num = num / base;
    }

    // Append negative sign for base 10
    if (is_negative) {
        str[i++] = '-';
    }

    str[i] = '\0';

    // Reverse the string to get the correct order
    gatOS_strrev(str, i);

    return str;
}

size_t strlen(const char* str) {
    size_t len = 0;
    while (str[len])
        len++;
    return len;
}
