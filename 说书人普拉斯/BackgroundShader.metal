#include <metal_stdlib>
using namespace metal;

// Helper: simple linear interpolation between two colors
// (same as your original `lerpColor` but inlined here for clarity)
inline half4 lerpColor(half4 c1, half4 c2, float a) {
    return mix(c1, c2, (half)clamp(a, 0.0f, 1.0f));
}

// Optimized dot‐pattern shader:
//  • Replaces `fmod(pos, spaceBetween)` with `fract(pos / spaceBetween) * spaceBetween`
//  • Replaces `length(offset)` with dot(offset, offset) < radius²
//  • Precomputes radius² only once
//  • Computes two pulse values (phase‐shifted by 0.5) using `fract` and a simple triangular wave.
//  • Minimizes branching to a single `mixFactor` selection at the end.
[[stitchable]] half4 dotPatternShader(
    float2 pos,               // current pixel location (in whatever coordinate space SwiftUI provides)
    half4  currentColor,      // (ignored in this implementation—left here so signature matches your call)
    const float spaceBetween, // distance between dot centers
    const float radius,       // dot radius
    float time                // elapsed time (in seconds)
) {
    // 1. Precompute half‐spacing and squared radius
    float halfSpace = spaceBetween * 0.5;
    float radiusSq   = radius * radius;

    // 2. Compute grid positions in a cheaper way:
    //    fract(pos / spaceBetween) gives a value in [0, 1) for each axis,
    //    multiplying by spaceBetween yields the same as `fmod(pos, spaceBetween)`.
    float2 gridPos0 = fract(pos / spaceBetween) * spaceBetween;
    float2 gridPos1 = fract((pos + float2(halfSpace)) / spaceBetween) * spaceBetween;

    // 3. Shift so that each “cell” is centered at (spaceBetween/2, spaceBetween/2)
    float2 offset0 = gridPos0 - float2(halfSpace);
    float2 offset1 = gridPos1 - float2(halfSpace);

    // 4. Compute squared distances (avoid sqrt)
    float distSq0 = dot(offset0, offset0);
    float distSq1 = dot(offset1, offset1);

    // 5. Create two “pulse” values that oscillate between 0 → 1 → 0 over a 1.0‐second period:
    //    • t0 goes from 0 → 1 as time/20 runs, then fract() repeats it every 1.0 unit.
    //    • fade0 = abs(t0 – 0.5) * 2.0 produces a triangular wave:
    //          0.0 at t0=0.0, up to 1.0 at t0=0.5, down to 0.0 at t0=1.0.
    //    • We do a second phase (t1 = t0 + 0.5), so dots on the “checkerboard” flip‐flop.
    float t0    = fract(time / 20.0);
    float fade0 = abs(t0 - 0.5) * 2.0;

    float t1    = fract(t0 + 0.5);
    float fade1 = abs(t1 - 0.5) * 2.0;

    // 6. Predefine your two colors
    //    (these match the original color values you used, just normalized to [0,1])
    half4 bgColor  = half4(0.0/253.0, 0.0/255.0, 0.0/255.0, 1.0);
    half4 dotColor = half4(255.0/255.0,   255.0/255.0,  255.0/255.0,  1.0);

    // 7. Check which grid cell this pixel belongs to (dot0 vs. dot1)
    bool inDot0 = (distSq0 < radiusSq);
    bool inDot1 = (distSq1 < radiusSq);

    // 8. Determine the final mix factor:
    //    • If the pixel is inside the “dot0” circle → use fade0
    //    • Else if the pixel is inside the “dot1” circle → use fade1
    //    • Otherwise → 0.0 (completely bgColor)
    float mix0 = inDot0 ? fade0 : 0.0;
    float mix1 = inDot1 ? fade1 : 0.0;
    float mixFactor = max(mix0, mix1);

    // 9. Linearly interpolate between bgColor and dotColor
    return lerpColor(bgColor, dotColor, mixFactor);
}

