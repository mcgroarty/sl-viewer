# Test Plan for GLTF Material Preview Manager Fix

## Issue Description
Mesh objects sometimes do not appear until the user right-clicks on them. This happens when material preview functionality is enabled and rendering material previews interferes with the main scene rendering pipeline.

## Root Cause
The material preview rendering code was manipulating the global exposure map state (`gPipeline.mExposureMap`) which affected the exposure calculations for the main scene, causing objects to become invisible until they were explicitly picked.

## Fix Applied
Modified `LLGLTFPreviewTexture::render()` in `llgltfmaterialpreviewmgr.cpp` to skip exposure generation during material preview rendering. This prevents interference with the main scene's exposure calculations while still producing correct material previews.

## Test Cases

### Test Case 1: Basic Material Preview
**Prerequisites:** 
- Enable material preview in advanced settings: "UIPreviewMaterial" = True
- Load a region with mesh objects

**Steps:**
1. Right-click a mesh object and select "Edit item"
2. Go to Texture tab and select "PBR Metallic Roughness" from dropdown
3. Click the button to select material from inventory
4. Ensure "Apply now" is checked in the inventory selection floater
5. Alternate between different materials from the inventory selection floater

**Expected Result:**
- Material preview should display correctly in the UI
- Mesh objects in the world should remain visible throughout the process
- No objects should disappear and then reappear when clicked

### Test Case 2: Mesh Visibility After Login/Teleport
**Steps:**
1. Login to a region with many mesh objects or teleport to such a region
2. Wait for objects to load
3. Look around the world

**Expected Result:**
- All mesh objects within view distance should be visible immediately
- No mesh objects should require right-clicking to become visible

### Test Case 3: Dynamic Exposure Still Works
**Steps:**
1. Move between different lighting environments (bright/dark areas)
2. Change environment settings (e.g., Midnight, Sunset, Default Midday)

**Expected Result:**
- Exposure should fade gradually between high and low exposure as needed
- No sudden flashing or exposure jumps should occur
- Material preview should not affect main scene exposure

## Regression Testing
- Verify material preview swatches still look correct with different materials
- Ensure material preview performance is acceptable on different systems
- Check that no other rendering features are broken