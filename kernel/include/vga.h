#ifndef __GATOS_VGA_H__
#define __GATOS_VGA_H__

#define VGA_WIDTH   80
#define VGA_HEIGHT  25
//#define VGA_MEMORY 0xB8000 
#define VGA_MEMORY  0xC03FF000

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

void terminal_initialize(void);

void terminal_putchar(char);
void kputs(const char*);

#define kernel_puts(a) _Generic((a),        \
    const char*: kputs,                     \
    char*: kputs,                           \
    char:  terminal_putchar,                \
    int: terminal_putchar                   \
)(a)

#endif