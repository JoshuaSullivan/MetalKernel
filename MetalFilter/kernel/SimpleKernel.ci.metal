#include <CoreImage/CoreImage.h>
using namespace metal;

float4 rotate(float4 sample) {
    return sample.brga;
}

extern "C" float4 SimpleKernel (coreimage::sample_t s, coreimage::destination dest)
{
    return rotate(s);
}
