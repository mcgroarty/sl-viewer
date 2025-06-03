# LLWindow Subsystem Design

## Purpose

The `llwindow/` subsystem provides cross-platform window management and input handling for the Second Life Viewer. It serves as the abstraction layer between the viewer application and the underlying operating system's window and input systems. This subsystem manages window creation, event handling, keyboard input, mouse interaction, and drag-and-drop functionality across Windows, macOS, and Linux platforms.

## Key Concepts

- **Platform Abstraction**: Unified interface hiding platform-specific window management differences
- **Window Lifecycle**: Creation, display, resizing, and destruction of application windows
- **Input Event Handling**: Processing of keyboard, mouse, and other input device events
- **OpenGL Context Management**: Creation and management of OpenGL rendering contexts
- **Drag and Drop Support**: Cross-platform file and data transfer functionality
- **Headless Rendering**: Support for server-side and automated testing without display
- **Cursor Management**: Custom cursor shapes and states for different interaction modes
- **Multi-Monitor Support**: Handling of multiple display configurations and window placement

## Main Components

### Core Window Framework
- **`llwindow.cpp/.h`** - Abstract base window class providing unified interface across platforms
- **`llwindowcallbacks.cpp/.h`** - Event callback system for window and input event handling
- **`llmousehandler.cpp/.h`** - Mouse event processing and interaction management

### Platform-Specific Implementations

#### Windows Platform
- **`llwindowwin32.cpp/.h`** - Windows-specific window implementation using Win32 API
- **`lldragdropwin32.cpp/.h`** - Windows drag-and-drop functionality implementation
- **`lldxhardware.cpp/.h`** - DirectX hardware detection and graphics capability enumeration

#### macOS Platform
- **`llwindowmacosx.cpp/.h`** - macOS-specific window implementation using Cocoa framework
- **`llwindowmacosx-objc.h/.mm`** - Objective-C bridge for macOS native functionality
- **`llopenglview-objc.h/.mm`** - OpenGL view implementation for macOS rendering
- **`llappdelegate-objc.h`** - Application delegate for macOS application lifecycle

#### Linux Platform
- **`llwindowsdl.cpp/.h`** - SDL-based window implementation for Linux and cross-platform support

#### Headless Rendering
- **`llwindowheadless.cpp/.h`** - Headless window implementation for server environments
- **`llwindowmesaheadless.cpp/.h`** - Mesa software rendering for headless environments

### Input Management System

#### Keyboard Input
- **`llkeyboard.cpp/.h`** - Abstract base class for keyboard input handling
- **`llkeyboardwin32.cpp/.h`** - Windows-specific keyboard implementation
- **`llkeyboardmacosx.cpp/.h`** - macOS-specific keyboard handling with international support
- **`llkeyboardsdl.cpp/.h`** - SDL-based keyboard implementation for Linux
- **`llkeyboardheadless.cpp/.h`** - Headless keyboard simulation for testing

#### Text Input and Internationalization
- **`llpreeditor.h`** - Pre-editing support for international text input methods

### User Interface Elements
- **`llcursortypes.cpp/.h`** - Cursor shape definitions and management for different interaction states

## How It Works

### Window Creation and Management Flow
1. **Platform Detection**: System determines the appropriate platform-specific window implementation
2. **Window Creation**: Platform-specific window is created with OpenGL context
3. **Event Loop Setup**: Input event handling and callback system is initialized
4. **Rendering Context**: OpenGL rendering context is established and configured
5. **Event Processing**: Continuous processing of window and input events
6. **State Management**: Window state (position, size, focus) is maintained and synchronized
7. **Cleanup**: Proper resource cleanup and window destruction on application exit

### Input Event Processing
Input events from the operating system are captured by platform-specific implementations, normalized to a common format, and dispatched through the callback system to appropriate handlers within the viewer application.

### Cross-Platform Abstraction Strategy
The subsystem uses polymorphism and platform-specific compilation to provide a unified interface while leveraging native platform capabilities. This allows the same high-level code to work across all supported platforms.

### OpenGL Context Management
Each platform implementation manages OpenGL context creation, configuration, and maintenance to ensure consistent rendering capabilities across different operating systems and graphics hardware.

## Interfaces and Integration

### Public APIs
- **Window Interface**: Methods for window creation, configuration, and management
- **Input Event API**: Interface for registering input event handlers and callbacks
- **Cursor Management**: API for setting and managing cursor appearance and behavior
- **OpenGL Context Control**: Methods for managing rendering context state
- **Drag and Drop**: Interface for handling file and data transfer operations

### Event Types Handled
- **Window Events**: Resize, move, focus, minimize, maximize, close
- **Keyboard Events**: Key press, key release, character input, modifier states
- **Mouse Events**: Click, movement, wheel, enter/leave window area
- **System Events**: Display configuration changes, power management, system notifications

### Data Formats Consumed
- **Configuration Data**: Window size, position, and display preferences
- **Input Mappings**: Keyboard layouts and input method configurations
- **Cursor Resources**: Custom cursor image data and hotspot information
- **Display Settings**: Monitor configuration and resolution information

### Integration Points
- **Rendering System**: Provides OpenGL context for graphics rendering
- **User Interface**: Supplies input events for UI interaction handling
- **Application Core**: Provides window lifecycle events for application management
- **Asset System**: Handles drag-and-drop file operations for content import

## Configuration

### Window Settings
- **Default window size and position** for initial application startup
- **Multi-monitor behavior** and display preference configuration
- **Window decoration and style** options for different usage modes
- **OpenGL context parameters** for rendering capability requirements

### Input Configuration
- **Keyboard layout and international** input method support
- **Mouse sensitivity and acceleration** settings for different user preferences
- **Custom key bindings** and input mapping customization
- **Accessibility options** for users with special input needs

### Platform-Specific Options
- **Windows-specific** DirectX detection and hardware enumeration settings
- **macOS-specific** Cocoa integration and native behavior options
- **Linux-specific** SDL configuration and window manager integration
- **Headless rendering** parameters for server and testing environments

## Testing

### Test Locations
- **Unit tests**: Platform-specific input handling and window management
- **Integration tests**: Cross-platform compatibility and event handling
- **Manual testing**: User interaction and window behavior validation

### Testing Strategy
- **Automated Tests**: Input event simulation and window state validation
- **Platform Tests**: Verification of platform-specific functionality
- **Performance Tests**: Input latency and window operation timing
- **Compatibility Tests**: Testing across different operating system versions
- **Headless Tests**: Automated testing using headless rendering modes

### Coverage Areas
- **Window Lifecycle**: Creation, resizing, and destruction across all platforms
- **Input Processing**: Keyboard and mouse event handling accuracy
- **OpenGL Context**: Rendering context creation and management
- **Drag and Drop**: File transfer functionality validation
- **Multi-Monitor**: Multiple display configuration handling

### Known Testing Limitations
- **Platform Dependencies**: Some tests require specific operating system features
- **Graphics Hardware**: OpenGL testing requires compatible graphics drivers
- **User Interaction**: Some input testing requires simulated or actual user interaction
- **Timing Sensitivity**: Input timing tests may be affected by system performance

## Performance and Constraints

### Performance Considerations
- **Event Processing Overhead**: Efficient handling of high-frequency input events
- **Window Update Frequency**: Balance between responsiveness and CPU usage
- **OpenGL Context Switching**: Minimizing expensive context operations
- **Platform API Efficiency**: Optimal use of native platform capabilities

### Resource Constraints
- **Memory Usage**: Window and input buffer memory requirements
- **Graphics Resources**: OpenGL context and surface memory allocation
- **System Resources**: Platform-specific window and input system resources
- **Thread Safety**: Coordination between main thread and platform event threads

### Optimization Strategies
- **Event Batching**: Efficient processing of multiple input events
- **Resource Pooling**: Reuse of window and input resources where possible
- **Lazy Initialization**: On-demand creation of platform-specific components
- **Efficient Callbacks**: Minimal overhead event callback mechanisms

## Dependencies

### External Libraries
- **Platform APIs**: Win32, Cocoa, SDL for native window management
- **OpenGL**: Graphics context creation and management
- **DirectX**: Windows hardware detection and capability enumeration

### Internal Dependencies
- **llcommon**: Basic utilities, smart pointers, and platform abstraction
- **llmath**: Mathematical utilities for coordinate transformations
- **llrender**: OpenGL context coordination and rendering state management

### Platform Dependencies
- **Windows**: Win32 API, DirectX for hardware detection
- **macOS**: Cocoa framework, OpenGL framework
- **Linux**: SDL library, X11 or Wayland display systems

## Known Issues / TODOs

### Design Weaknesses
- **Platform Code Duplication**: Similar functionality implemented separately for each platform
- **Complex Event Handling**: Event callback system could be more streamlined
- **Limited Headless Testing**: Headless mode doesn't fully simulate all platform behaviors
- **Inconsistent Input Handling**: Platform differences in input event behavior

### Performance Issues
- **Input Event Latency**: Some platforms experience higher input processing delays
- **Window Resize Performance**: Large window resize operations can be expensive
- **Multi-Monitor Overhead**: Complex display configurations impact performance
- **Context Switching Cost**: OpenGL context operations on some platforms are expensive

### Platform-Specific Issues
- **Windows DPI Scaling**: High-DPI display handling could be improved
- **macOS Retina Support**: Retina display rendering has some optimization opportunities
- **Linux Window Managers**: Inconsistent behavior across different window managers
- **Cross-Platform Cursors**: Custom cursor support varies between platforms

### Future Improvements
- **Modern Platform APIs**: Adoption of newer platform-specific APIs for better performance
- **Unified Input System**: More consistent input handling across all platforms
- **Vulkan Support**: Addition of Vulkan rendering context management
- **Touch Input**: Support for touch and gesture input on capable platforms
- **VR/AR Integration**: Window and input support for virtual and augmented reality

### Code Quality Issues
- **Documentation**: Platform-specific code lacks comprehensive documentation
- **Error Handling**: Platform API errors could be more gracefully handled
- **Code Organization**: Some platform implementations have overlapping responsibilities
- **API Consistency**: Different platforms expose slightly different interfaces

*Note: The window subsystem is critical for all user interaction with the viewer. Changes should be carefully tested across all supported platforms to ensure consistent behavior and performance.*