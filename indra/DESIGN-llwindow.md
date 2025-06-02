# LLWindow Subsystem Design

## Purpose

The `llwindow/` subsystem provides platform-independent window management and input handling for the Second Life Viewer. It solves the problem of cross-platform compatibility by abstracting operating system-specific windowing APIs, OpenGL context management, and input device handling. This subsystem enables the viewer to run consistently across Windows, macOS, and Linux while supporting diverse input methods including mouse, keyboard, touch, and accessibility devices.

## Key Concepts

- **Platform Abstraction**: Unified interface hiding OS-specific windowing implementation details
- **OpenGL Context Management**: Cross-platform OpenGL context creation and configuration
- **Input Event Handling**: Keyboard, mouse, and special input device event processing and routing
- **Window Lifecycle**: Complete window creation, management, and destruction coordination
- **Display Management**: Multi-monitor support with resolution and refresh rate detection
- **Accessibility Integration**: Screen reader and alternative input method support
- **Drag-and-Drop**: File and object drag-and-drop operations from external applications
- **Cursor Management**: Custom cursor shapes and visibility control for user feedback
- **Input Method Editing**: Text input composition for international keyboard layouts
- **Fullscreen Support**: Seamless transitions between windowed and fullscreen modes

## Main Components

### Core Window Interface
- **`llwindow.cpp/.h`** - Abstract window base class defining platform-independent interface
- **`llwindowcallbacks.cpp/.h`** - Callback interface for window events and input handling

### Platform-Specific Implementations
- **`llwindowwin32.cpp/.h`** - Windows-specific window implementation using Win32 APIs
- **`llwindowmacosx.cpp/.h`** - macOS-specific window implementation using Cocoa framework
- **`llwindowsdl.cpp/.h`** - Linux/SDL-specific window implementation for cross-platform support
- **`llwindowheadless.cpp/.h`** - Headless implementation for server applications and testing
- **`llwindowmesaheadless.cpp/.h`** - Mesa-based headless rendering for automated testing

### Platform-Specific Integration
- **`llwindowmacosx-objc.h/.mm`** - Objective-C integration for macOS native functionality
- **`llopenglview-objc.h/.mm`** - macOS OpenGL view implementation in Objective-C
- **`llappdelegate-objc.h`** - macOS application delegate for system integration

### Input Handling
- **`llkeyboard.cpp/.h`** - Abstract keyboard input handling with key mapping and modifiers
- **`llkeyboardwin32.cpp/.h`** - Windows-specific keyboard implementation
- **`llkeyboardmacosx.cpp/.h`** - macOS-specific keyboard implementation with Unicode support
- **`llkeyboardsdl.cpp/.h`** - SDL-based keyboard implementation for Linux
- **`llkeyboardheadless.cpp/.h`** - Headless keyboard implementation for testing

### Mouse and Pointer Input
- **`llmousehandler.cpp/.h`** - Mouse event handling and coordinate transformation
- **`llcursortypes.cpp/.h`** - Cursor shape definitions and management

### Specialized Platform Features
- **`lldragdropwin32.cpp/.h`** - Windows drag-and-drop implementation using OLE interfaces
- **`lldxhardware.cpp/.h`** - DirectX hardware detection for Windows graphics capabilities

### Text Input Support
- **`llpreeditor.h`** - Pre-editor interface for complex text input methods (Asian languages)

## How It Works

### Window Creation and Initialization
1. **Platform Detection**: Runtime detection of operating system and available APIs
2. **Context Creation**: OpenGL context created with appropriate pixel format and features
3. **Window Setup**: Window created with specified size, position, and display properties
4. **Input Registration**: Input devices registered and event handlers established
5. **Callback Registration**: Application callback functions registered for event notifications
6. **Resource Allocation**: Platform-specific resources allocated and initialized

### Event Processing Loop
1. **System Event Polling**: Platform-specific event polling or message pump operation
2. **Event Translation**: OS-specific events translated to platform-independent format
3. **Event Filtering**: Input events filtered and validated for application consumption
4. **Callback Invocation**: Appropriate application callbacks invoked with event data
5. **State Management**: Window and input state updated to reflect current conditions

### Input Event Routing
1. **Raw Input Capture**: Low-level input events captured from operating system
2. **Coordinate Transformation**: Mouse coordinates transformed to window client area
3. **Key Mapping**: Keyboard scancodes mapped to logical key identifiers
4. **Modifier Processing**: Shift, control, alt, and other modifier keys processed
5. **Event Dispatch**: Processed events dispatched to appropriate application handlers

### OpenGL Context Management
1. **Pixel Format Selection**: Optimal pixel format chosen based on requirements and capabilities
2. **Context Creation**: OpenGL context created with appropriate version and features
3. **Extension Loading**: OpenGL extensions detected and function pointers resolved
4. **State Initialization**: Initial OpenGL state configured for application use
5. **Context Switching**: Context made current for rendering operations

## Interfaces and Integration

### Public APIs
- **LLWindow interface**: Platform-independent window creation and management
- **Event callbacks**: Mouse, keyboard, resize, and system event notifications
- **OpenGL context**: Context creation, management, and buffer swapping
- **Input state queries**: Current mouse position, key states, and modifier status
- **Window properties**: Size, position, fullscreen state, and display characteristics

### Platform Integration
- **Operating system events**: Window messages, notifications, and system events
- **Graphics drivers**: OpenGL driver interface and hardware capability detection
- **Input devices**: Keyboard, mouse, touch, and accessibility device integration
- **File system**: Drag-and-drop file operations and clipboard integration

### Application Integration
- **Rendering system**: OpenGL context provided to rendering subsystem
- **UI system**: Input events routed to user interface event handlers
- **Main application**: Window lifecycle events coordinated with application startup/shutdown

### Hardware Integration
- **Display hardware**: Multi-monitor support with resolution and refresh rate detection
- **Input hardware**: Support for various keyboard layouts and mouse configurations
- **Graphics hardware**: GPU capability detection and driver feature support

## Configuration

### Window Settings
- **`WindowWidth`/`WindowHeight`**: Default window dimensions for startup
- **`WindowPosX`/`WindowPosY`**: Initial window position on desktop
- **`FullScreen`**: Fullscreen mode enable/disable
- **`WindowBorderless`**: Borderless window mode for immersive display

### OpenGL Configuration
- **`OpenGLVersion`**: Minimum required OpenGL version
- **`AntiAliasing`**: Multisampling antialiasing configuration
- **`VSync`**: Vertical synchronization enable/disable
- **`PixelFormat`**: Color depth and buffer configuration

### Input Settings
- **`KeyRepeatRate`**: Keyboard key repeat timing configuration
- **`MouseSensitivity`**: Mouse movement sensitivity scaling
- **`InvertMouse`**: Mouse Y-axis inversion option
- **`DisableMouseAcceleration`**: Raw mouse input for precise control

### Platform-Specific Settings
- **Windows**: DPI awareness, Windows version compatibility
- **macOS**: Retina display support, system integration preferences
- **Linux**: X11 vs Wayland support, desktop environment integration

## Testing

### Test Locations
- **Integration tests**: Window creation and OpenGL context validation
- **Input simulation**: Automated input event generation and verification
- **Cross-platform testing**: Behavior validation across all supported platforms

### Testing Strategy
- **Window lifecycle testing**: Creation, resize, minimize, maximize, and destruction
- **Input event testing**: Keyboard and mouse event accuracy and timing
- **OpenGL context testing**: Context creation and feature availability validation
- **Multi-monitor testing**: Behavior validation across different display configurations
- **Platform integration testing**: OS-specific feature verification

### Coverage Areas
- **Event handling**: All input event types processed correctly
- **Window management**: Proper window state transitions and property updates
- **OpenGL context**: Context creation successful across different hardware
- **Platform features**: Drag-and-drop, accessibility, and system integration
- **Error handling**: Graceful handling of hardware and driver limitations

### Known Testing Limitations
- **Hardware dependency**: Testing limited by available graphics hardware configurations
- **Platform availability**: Full testing requires access to all target operating systems
- **Driver variations**: Graphics driver differences affect test results and coverage
- **User interaction**: Some features require manual testing with actual user input

## Performance and Constraints

### Performance Characteristics
- **Low-latency input**: Minimal delay between hardware input and application response
- **Efficient event processing**: Optimized event polling and dispatch mechanisms
- **Context switching**: Fast OpenGL context operations for rendering efficiency
- **Resource management**: Efficient allocation and cleanup of platform resources

### Platform Constraints
- **OS limitations**: Platform-specific restrictions on window behavior and capabilities
- **Graphics driver limits**: Hardware and driver capabilities affect available features
- **Display constraints**: Monitor resolution, refresh rate, and multi-monitor configuration limits
- **Input device limits**: Keyboard layout variations and mouse hardware differences

### Memory Constraints
- **Window resources**: Platform-specific window and graphics context memory usage
- **Input buffers**: Event queue and input state storage requirements
- **OpenGL resources**: Graphics context and associated resource memory consumption

### Timing Constraints
- **Input responsiveness**: Real-time requirements for interactive input handling
- **Frame synchronization**: VSync and display refresh rate coordination
- **Event processing**: Bounded event processing time to maintain application responsiveness

## Dependencies

### External Libraries
- **OpenGL**: Graphics context creation and management across platforms
- **SDL2**: Cross-platform windowing and input on Linux systems
- **Platform APIs**: Win32 (Windows), Cocoa (macOS), X11/Wayland (Linux)

### Internal Module Dependencies
- **llcommon**: Basic utilities and cross-platform abstraction (critical dependency)
- **llmath**: Coordinate transformations and mathematical operations

### Platform Dependencies
- **Windows**: Win32 API, DirectX for hardware detection, OLE for drag-and-drop
- **macOS**: Cocoa framework, Objective-C runtime, Core Graphics
- **Linux**: X11 or Wayland, SDL2, OpenGL drivers

## Known Issues / TODOs

### Platform Compatibility Issues
- **Driver compatibility**: Graphics driver variations cause inconsistent behavior
- **OS version differences**: Newer OS features not always available on older versions
- **Hardware support**: Legacy hardware may lack required OpenGL features
- **Multi-monitor behavior**: Inconsistent behavior across different display configurations

### Input Handling Issues
- **International keyboards**: Complex input method support incomplete for some languages
- **Touch input**: Limited touch and gesture support for touch-enabled displays
- **Accessibility**: Screen reader and alternative input support needs improvement
- **Raw input**: High-precision input for gaming and professional applications

### Performance Issues
- **Context switching overhead**: OpenGL context operations can impact performance
- **Event processing latency**: Complex event processing may introduce input lag
- **Memory usage**: Window and context resources may consume significant memory
- **Fullscreen transitions**: Mode switching can cause temporary performance hitches

### Future Improvements
- **Vulkan support**: Modern graphics API support for improved performance
- **High-DPI improvements**: Better support for high-resolution displays and scaling
- **Multi-window support**: Multiple viewer windows for enhanced productivity
- **VR/AR integration**: Virtual and augmented reality headset support
- **Modern input methods**: Enhanced touch, gesture, and voice input support

### Code Quality Issues
- **Platform abstraction leaks**: OS-specific code sometimes leaks into common interfaces
- **Error handling inconsistency**: Different error handling patterns across platforms
- **Documentation gaps**: Platform-specific implementation details poorly documented
- **Test coverage**: Limited automated testing for platform-specific functionality

### Security Considerations
- **Input validation**: Insufficient validation of external input events
- **File access**: Drag-and-drop operations may expose sensitive file information
- **Process isolation**: Window system integration may expose application to external processes

*Note: The window subsystem is fundamental to viewer operation and platform compatibility. Changes must be thoroughly tested across all supported operating systems and hardware configurations.*