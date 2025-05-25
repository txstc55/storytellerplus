//
//  BackgroundShader.metal
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

#include <metal_stdlib>
using namespace metal;

half4 lerpColor(half4 c1, half4 c2, float a){
  return mix(c1, c2, (half)clamp(a, 0.0f, 1.0f));
}


// this shader creates dots in the background, give the user a dynamic feeling
[[stitchable]] half4 dotPatternShader(float2 pos,
                                      half4 currentColor,
                                      const float spaceBetween,
                                      const float radius,
                                      float time
                                      )
{
  
  float2 gridPos0 = fmod(pos, spaceBetween);
  float2 gridPos1 = fmod(pos + float2(spaceBetween / 2.0, spaceBetween / 2.0), spaceBetween);
  
  // We want dots centered at spacing/2, so shift by half
  float2 offset0 = gridPos0 - (spaceBetween * 0.5);
  float2 offset1 = gridPos1 - (spaceBetween * 0.5);
  
  // Distance from the dot center
  float dist0 = length(offset0);
  float dist1 = length(offset1);
  
  float scaledTime = time / 20.0;
  
  half4 bgColor = half4(242.0 / 253.0, 238.0 / 255.0, 225.0 / 255.0, 1);
  half4 dotColor = half4(17.0 / 255.0, 19.0 / 255.0, 23.0 / 255.0, 1);
  
  // for the first dots
  if (dist0 >= radius && dist1 >= radius){
    return bgColor;
  }else if (dist0 < radius){
    return lerpColor(bgColor, dotColor, (0.5 - fabs(fmod(scaledTime, 1.0) - 0.5)) * 2.0);
  }else{
    return lerpColor(bgColor, dotColor, (0.5 - fabs(fmod(scaledTime + 0.5, 1.0) - 0.5)) * 2.0);
  }
}

