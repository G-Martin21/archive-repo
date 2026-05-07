#include "circular_buffer.h"

struct circular_buffer_t {
	buffer_value_t* buffer;
	size_t head;
	size_t tail;
	size_t capacity;
	bool full;
};

void clear_buffer(circular_buffer_t* buffer)
{
	buffer->head = 0;
	buffer->tail = 0;
	buffer->full = false;
}

circular_buffer_t* new_circular_buffer(size_t capacity)
{
    circular_buffer_t * cbuffer  = malloc(1 * sizeof(circular_buffer_t));
    cbuffer->capacity = capacity;      
    cbuffer->buffer = calloc(capacity, sizeof(buffer_value_t));
    clear_buffer(cbuffer);
    return cbuffer;
}

void delete_buffer(circular_buffer_t* cbuffer)
{
    free(cbuffer->buffer);
    free(cbuffer);
}

static void advance_pointer(circular_buffer_t* cbuffer)
{
	if(cbuffer->full)
   	{
		cbuffer->tail = (cbuffer->tail + 1) % cbuffer->capacity;
	}

	cbuffer->head = (cbuffer->head + 1) % cbuffer->capacity;
	cbuffer->full = (cbuffer->head == cbuffer->tail);   
}

static void retreat_pointer(circular_buffer_t* cbuffer)
{
	cbuffer->full = false;
	if (++(cbuffer->tail) == cbuffer->capacity) 
	{ 
		cbuffer->tail = 0;
	}
}

static bool circular_buf_empty(circular_buffer_t* cbuffer)
{
	return (!cbuffer->full && (cbuffer->head == cbuffer->tail));
}

int16_t write(circular_buffer_t* cbuffer, buffer_value_t value)
{
    cbuffer->buffer[cbuffer->head] = value;
    if(cbuffer->full)
    {
        errno = ENOBUFS;
        return EXIT_FAILURE;
    }
    advance_pointer(cbuffer);
    return EXIT_SUCCESS;
}

int16_t overwrite(circular_buffer_t* cbuffer, buffer_value_t value)
{
    cbuffer->buffer[cbuffer->head] = value;
    advance_pointer(cbuffer);
    return EXIT_SUCCESS;
}

int16_t read(circular_buffer_t* cbuffer, buffer_value_t* value)
{
    int r = EXIT_FAILURE;
    errno = ENODATA;
    
    if(!circular_buf_empty(cbuffer))
    {
        *value = cbuffer->buffer[cbuffer->tail];
        retreat_pointer(cbuffer);

        r = EXIT_SUCCESS;
    }

    return r;
}




#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <errno.h>

typedef unsigned long int size_t;   
typedef uint16_t buffer_value_t;
typedef struct circular_buffer_t circular_buffer_t;

circular_buffer_t* new_circular_buffer(size_t capacity);
int16_t write(circular_buffer_t* cbuffer, buffer_value_t value);
int16_t overwrite(circular_buffer_t* cbuffer, buffer_value_t value);
int16_t read(circular_buffer_t* cbuffer, buffer_value_t* value);
void delete_buffer(circular_buffer_t* cbuffer);
void clear_buffer(circular_buffer_t* buffer);
#endif
