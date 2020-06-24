#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" float4 SimpleKernel (coreimage::sample_t s, coreimage::destination dest)
{
    return s;
}


