#include "mult.hpp"
#include <cstring>

uint32_t floatABits ( float x ) {
    uint32_t u ;
    memcpy ( &u , &x , 4 ) ;
    return u ;
}

float bitsAFloat ( uint32_t u ) {
    float x ;
    memcpy ( &x , &u , 4 ) ;
    return x ;
}

bool esNaN ( uint32_t e , uint32_t f ) { return e == 0xFF && f != 0 ; }
bool esInf ( uint32_t e , uint32_t f ) { return e == 0xFF && f == 0 ; }
bool esCero ( uint32_t e , uint32_t f ) { return e == 0 && f == 0 ; }

void prepararMantisa ( uint32_t exp , uint32_t frac , uint32_t &m , int &e ) {
    int bias = 127 ;
    if ( exp == 0 ) {
        m = frac ;
        e = 1 - bias ;
    } else {
        m = ( 1 << 23 ) | frac ;
        e = exp - bias ;
    }
}

uint32_t armarResultado ( uint32_t s , int e , uint32_t m ) {
    int bias = 127 ;
    uint32_t expFinal = e + bias ;
    uint32_t fracFinal = m & 0x7FFFFF ;
    return ( s << 31 ) | ( expFinal << 23 ) | fracFinal ;
}

uint32_t multiplicar ( float a , float b ) {
    uint32_t ua = floatABits ( a ) ;
    uint32_t ub = floatABits ( b ) ;

    uint32_t sa = ua >> 31 , sb = ub >> 31 ;
    uint32_t ea = ( ua >> 23 ) & 0xFF , eb = ( ub >> 23 ) & 0xFF ;
    uint32_t fa = ua & 0x7FFFFF , fb = ub & 0x7FFFFF ;

    if ( esNaN ( ea , fa ) || esNaN ( eb , fb ) )
        return ( 0xFF << 23 ) | 1 ;

    if ( esInf ( ea , fa ) || esInf ( eb , fb ) ) {
        if ( ( esInf ( ea , fa ) && esCero ( eb , fb ) ) || ( esInf ( eb , fb ) && esCero ( ea , fa ) ) )
            return ( 0xFF << 23 ) | 1 ;
        return ( ( sa ^ sb ) << 31 ) | ( 0xFF << 23 ) ;
    }

    if ( esCero ( ea , fa ) || esCero ( eb , fb ) )
        return ( sa ^ sb ) << 31 ;

    uint32_t mA , mB ;
    int eA , eB ;
    prepararMantisa ( ea , fa , mA , eA ) ;
    prepararMantisa ( eb , fb , mB , eB ) ;

    uint32_t s = sa ^ sb ;
    int e = eA + eB ;

    uint64_t prod = ( uint64_t ) mA * ( uint64_t ) mB ;

    int k = ( prod >> 47 ) ? 47 : 46 ;
    int shift = k - 23 ;

    uint32_t m = ( uint32_t ) ( prod >> shift ) ;
    uint64_t resto = prod & ( ( 1ULL << shift ) - 1 ) ;

    bool guard = ( resto >> ( shift - 1 ) ) & 1ULL ;
    bool sticky = ( shift > 1 ) && ( resto & ( ( 1ULL << ( shift - 1 ) ) - 1 ) ) ;

    if ( guard && ( sticky || ( m & 1 ) ) ) {
        m ++ ;
        if ( m == ( 1 << 24 ) ) {
            m >>= 1 ;
            e ++ ;
        }
    }

    e += k - 46 ;

    if ( e > 127 )
        return ( s << 31 ) | ( 0xFF << 23 ) ;

    if ( e < -126 )
        return s << 31 ;

    return armarResultado ( s , e , m ) ;
}
