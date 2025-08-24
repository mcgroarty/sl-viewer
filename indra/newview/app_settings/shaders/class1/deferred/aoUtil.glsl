/**
 * @file class1/deferred/aoUtil.glsl
 *
 * $LicenseInfo:firstyear=2007&license=viewerlgpl$
 * Second Life Viewer Source Code
 * Copyright (C) 2007, Linden Research, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation;
 * version 2.1 of the License only.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Linden Research, Inc., 945 Battery Street, San Francisco, CA  94111  USA
 * $/LicenseInfo$
 */

uniform sampler2D   noiseMap;
uniform sampler2D   depthMap;

uniform float ssao_radius;
uniform float ssao_max_radius;
uniform float ssao_factor;
uniform float ssao_factor_inv;

uniform mat4 inv_proj;
uniform vec2 screen_res;

vec2 getScreenCoordinateAo(vec2 screenpos)
{
    vec2 sc = screenpos.xy * 2.0;
    return sc - vec2(1.0, 1.0);
}

float getDepthAo(vec2 pos_screen)
{
    float depth = texture(depthMap, pos_screen).r;
    return depth;
}

vec4 getPositionAo(vec2 pos_screen)
{
    float depth = getDepthAo(pos_screen);
    vec2 sc = getScreenCoordinateAo(pos_screen);
    vec4 ndc = vec4(sc.x, sc.y, 2.0*depth-1.0, 1.0);
    vec4 pos = inv_proj * ndc;
    pos /= pos.w;
    pos.w = 1.0;
    return pos;
}

vec2 getKern(int i)
{
    // Pre-computed kernel values for better performance
    // exponentially (^2) distant occlusion samples spread around origin
    if (i == 0) return vec2(-0.015625, 0.0) / screen_res;       // vec2(-1.0, 0.0) * 0.125*0.125
    if (i == 1) return vec2(0.0625, 0.0) / screen_res;          // vec2(1.0, 0.0) * 0.250*0.250  
    if (i == 2) return vec2(0.0, 0.140625) / screen_res;        // vec2(0.0, 1.0) * 0.375*0.375
    if (i == 3) return vec2(0.0, -0.25) / screen_res;           // vec2(0.0, -1.0) * 0.500*0.500
    if (i == 4) return vec2(0.276211, 0.276211) / screen_res;   // vec2(0.7071, 0.7071) * 0.625*0.625
    if (i == 5) return vec2(-0.397744, -0.397744) / screen_res; // vec2(-0.7071, -0.7071) * 0.750*0.750
    if (i == 6) return vec2(-0.541373, 0.541373) / screen_res;  // vec2(-0.7071, 0.7071) * 0.875*0.875
    if (i == 7) return vec2(0.7071, -0.7071) / screen_res;      // vec2(0.7071, -0.7071) * 1.000*1.000
    return vec2(0.0); // fallback
}

//calculate decreases in ambient lighting when crowded out (SSAO)
float calcAmbientOcclusion(vec4 pos, vec3 norm, vec2 pos_screen)
{
    float ret = 1.0;
    vec3 pos_world = pos.xyz;
    vec2 noise_reflect = texture(noiseMap, pos_screen.xy * (screen_res / 128)).xy;

    float angle_hidden = 0.0;
    float points = 0;

    float scale = min(ssao_radius / -pos_world.z, ssao_max_radius);

    // it was found that keeping # of samples a constant was the fastest, probably due to compiler optimizations (unrolling?)
    for (int i = 0; i < 8; i++)
    {
        vec2 samppos_screen = pos_screen + scale * reflect(getKern(i), noise_reflect);
        vec3 samppos_world = getPositionAo(samppos_screen).xyz;

        vec3 diff = pos_world - samppos_world;
        float dist2 = dot(diff, diff);

        // assume each sample corresponds to an occluding sphere with constant radius, constant x-sectional area
        // --> solid angle shrinking by the square of distance
        //radius is somewhat arbitrary, can approx with just some constant k * 1 / dist^2
        //(k should vary inversely with # of samples, but this is taken care of later)

        float funky_val = step(0.0, dot((samppos_world - 0.05*norm - pos_world), norm));
        angle_hidden = angle_hidden + funky_val * min(1.0/dist2, ssao_factor_inv);

        // 'blocked' samples (significantly closer to camera relative to pos_world) are "no data", not "no occlusion"
        float diffz_val = step(-1.0, diff.z);
        points = points + diffz_val;
    }

    angle_hidden = min(ssao_factor*angle_hidden/points, 1.0);

    float points_val = step(0.0001, points); // More efficient than points > 0.0
    ret = (1.0 - (points_val * angle_hidden));

    ret = max(ret, 0.0);
    return min(ret, 1.0);
}

