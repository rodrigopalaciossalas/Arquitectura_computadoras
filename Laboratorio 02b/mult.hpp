#ifndef MULT_HPP
#define MULT_HPP

#include <cstdint>

uint32_t floatABits ( float x ) ;
float bitsAFloat ( uint32_t u ) ;

bool esNaN ( uint32_t e , uint32_t f ) ;
bool esInf ( uint32_t e , uint32_t f ) ;
bool esCero ( uint32_t e , uint32_t f ) ;

uint32_t multiplicar ( float a , float b ) ;

#endif
