# LLPlugin Subsystem Design

## Purpose

The `llplugin/` subsystem provides a comprehensive plugin architecture for the Second Life Viewer, enabling secure and isolated execution of external code for media playback, web content rendering, and other extensible functionality. It serves as the foundation for integrating third-party libraries and services while maintaining application stability through process isolation and controlled communication.

## Key Concepts

- **Process Isolation**: Plugins run in separate processes to prevent crashes from affecting the main viewer
- **Inter-Process Communication**: Secure message passing between viewer and plugin processes
- **Media Plugin Architecture**: Specialized framework for media playback and web content rendering
- **Shared Memory**: Efficient data sharing for large media content like video frames and audio
- **Plugin Lifecycle Management**: Creation, monitoring, and cleanup of plugin processes
- **Message Protocol**: Standardized communication protocol for plugin coordination
- **Resource Management**: Memory and CPU resource monitoring and control for plugin processes
- **Security Sandboxing**: Isolated execution environment to limit plugin access to system resources

## Main Components

### Core Plugin Framework
- **`llplugininstance.cpp/.h`** - Individual plugin instance management and lifecycle control
- **`llpluginmessage.cpp/.h`** - Message structure and serialization for inter-process communication
- **`llpluginmessageclasses.h`** - Standardized message type definitions and protocols

### Process Management System
- **`llpluginprocessparent.cpp/.h`** - Parent process controller managing plugin process lifecycle
- **`llpluginprocesschild.cpp/.h`** - Child process framework for plugin implementation
- **`llpluginsharedmemory.cpp/.h`** - Shared memory management for efficient data transfer

### Communication Infrastructure
- **`llpluginmessagepipe.cpp/.h`** - Message pipe implementation for reliable inter-process communication

### Media-Specific Plugin Support
- **`llpluginclassmedia.cpp/.h`** - Media plugin base class providing media playback functionality
- **`llpluginclassmediaowner.h`** - Owner interface for media plugin lifecycle and event handling

### Plugin Executables
- **`slplugin/`** - Directory containing plugin executable implementations and support files

## How It Works

### Plugin Lifecycle Management
1. **Plugin Discovery**: Available plugins are identified from configured directories
2. **Process Creation**: Plugin processes are spawned with appropriate security constraints
3. **Communication Setup**: Message pipes and shared memory regions are established
4. **Initialization**: Plugin receives initialization parameters and configuration
5. **Operation**: Plugin performs requested operations while communicating with parent
6. **Monitoring**: Parent process monitors plugin health and resource usage
7. **Cleanup**: Plugin process is properly terminated and resources are cleaned up

### Inter-Process Communication Flow
The system uses a message-based protocol where the parent viewer process sends commands and receives responses from plugin processes. Critical data like video frames is transferred through shared memory for efficiency.

### Media Plugin Integration
Media plugins handle video playback, web content rendering, and audio processing. They receive media URLs or data through the messaging system and provide rendered content back to the viewer for display.

### Security and Isolation
Plugins run in isolated processes with limited system access, preventing plugin failures or security vulnerabilities from compromising the main viewer application.

## Interfaces and Integration

### Public APIs
- **Plugin Management**: Interface for loading, configuring, and controlling plugin instances
- **Media Plugin API**: Specialized interface for media playback and web content plugins
- **Message Interface**: Methods for sending commands and receiving responses from plugins
- **Resource Monitoring**: API for tracking plugin resource usage and performance
- **Event Handling**: Interface for receiving plugin events and status updates

### Message Types Handled
- **Media Commands**: Play, pause, stop, seek, and other media control operations
- **Configuration Messages**: Plugin settings, preferences, and initialization parameters
- **Data Transfer**: Content URLs, media streams, and rendering parameters
- **Status Updates**: Plugin health, error conditions, and operational status
- **Resource Reports**: Memory usage, CPU consumption, and performance metrics

### Data Formats Supported
- **Web Content**: HTML, CSS, JavaScript for web-based plugin content
- **Media Streams**: Video and audio data in various formats and codecs
- **Image Data**: Rendered frames and texture data for display integration
- **Plugin Configuration**: JSON or structured data for plugin parameters

### Integration Points
- **Media System**: Provides video playback and web content rendering capabilities
- **Rendering System**: Receives rendered content for display in the viewer
- **User Interface**: Integrates plugin controls and status information
- **Security System**: Enforces isolation and access control for plugin processes
- **Asset System**: Coordinates with asset loading for plugin content

## Configuration

### Plugin Settings
- **Plugin directory paths** for discovering available plugins
- **Process limits** and resource constraints for plugin execution
- **Security policies** for plugin process isolation and access control
- **Communication timeouts** and retry policies for message handling

### Media Plugin Configuration
- **Supported media formats** and codec preferences
- **Rendering parameters** for video quality and performance balance
- **Audio settings** for plugin-based audio playback
- **Web rendering options** for browser-like plugin functionality

### Resource Management
- **Memory limits** for individual plugin processes
- **CPU usage constraints** to prevent plugin interference with viewer performance
- **Process monitoring** intervals and health check parameters
- **Cleanup policies** for handling plugin failures and resource recovery

## Testing

### Test Locations
- **Unit tests**: Plugin framework functionality and message protocol validation
- **Integration tests**: Plugin process interaction and media playback testing
- **Stress tests**: Plugin stability and resource usage under load conditions

### Testing Strategy
- **Process Tests**: Plugin lifecycle, creation, and termination validation
- **Communication Tests**: Message protocol reliability and performance testing
- **Media Tests**: Video playback, web content rendering, and audio functionality
- **Security Tests**: Isolation effectiveness and security constraint validation
- **Performance Tests**: Plugin resource usage and impact on viewer performance

### Coverage Areas
- **Plugin Management**: Loading, configuration, and lifecycle control
- **Inter-Process Communication**: Message reliability and shared memory efficiency
- **Media Functionality**: Video, audio, and web content rendering accuracy
- **Error Handling**: Plugin failure recovery and error reporting
- **Resource Monitoring**: Memory and CPU usage tracking and limits

### Known Testing Limitations
- **Platform Dependencies**: Some plugin functionality requires specific platform features
- **Media Content Variations**: Testing all possible media formats and content types is impractical
- **Security Validation**: Complete security isolation testing requires specialized tools
- **Performance Variability**: Plugin performance varies significantly across different systems

## Performance and Constraints

### Performance Considerations
- **Process Overhead**: Plugin processes consume additional memory and CPU resources
- **Communication Latency**: Inter-process messaging introduces timing overhead
- **Data Transfer Efficiency**: Shared memory transfer speed for large media content
- **Plugin Resource Usage**: Plugins may consume significant system resources

### Resource Constraints
- **Memory Usage**: Plugin processes require additional memory allocation
- **Process Limits**: Operating system limits on number of concurrent processes
- **CPU Resources**: Plugin processing competes with main viewer for CPU time
- **GPU Access**: Limited GPU access from isolated plugin processes

### Optimization Strategies
- **Efficient Messaging**: Minimal message overhead and batching for performance
- **Smart Caching**: Caching of plugin content to reduce repeated processing
- **Resource Pooling**: Reuse of plugin processes for similar content types
- **Lazy Loading**: On-demand plugin loading to reduce startup overhead

## Dependencies

### External Libraries
- **Platform APIs**: Process creation and management APIs for different operating systems
- **Media Libraries**: Codec libraries and media framework integration
- **Security Libraries**: Process isolation and sandboxing support

### Internal Dependencies
- **llcommon**: Basic utilities, threading, and cross-platform abstractions
- **llmessage**: Message serialization and communication infrastructure
- **llfilesystem**: File system access for plugin executable loading
- **Rendering System**: Integration with viewer rendering for content display

### Platform Dependencies
- **Windows**: Win32 process APIs and security features
- **macOS**: Process management and sandboxing capabilities
- **Linux**: Process isolation and security frameworks

## Known Issues / TODOs

### Design Weaknesses
- **Process Overhead**: Plugin architecture adds significant memory and CPU overhead
- **Communication Complexity**: Inter-process messaging adds system complexity
- **Limited GPU Access**: Plugins have restricted access to graphics hardware
- **Platform Variations**: Plugin behavior varies across different operating systems

### Performance Issues
- **Message Latency**: Inter-process communication introduces timing delays
- **Memory Duplication**: Data copying between processes increases memory usage
- **Process Creation Cost**: Starting new plugin processes is expensive
- **Resource Monitoring Overhead**: Tracking plugin resource usage impacts performance

### Security and Stability Issues
- **Isolation Limitations**: Complete plugin isolation is difficult to achieve
- **Plugin Crashes**: Plugin failures can still impact user experience
- **Security Updates**: Plugin security requires coordination with third-party components
- **Resource Leaks**: Plugin processes may not properly clean up resources

### Future Improvements
- **Modern Sandboxing**: Enhanced security isolation using modern operating system features
- **GPU Acceleration**: Better GPU access for plugin-based content rendering
- **Performance Optimization**: Reduced overhead for plugin communication and data transfer
- **Plugin Standards**: More standardized plugin interfaces and protocols
- **Cloud Integration**: Support for cloud-based plugin services and processing

### Code Quality Issues
- **Documentation**: Plugin architecture and protocols lack comprehensive documentation
- **Error Handling**: Plugin failure scenarios could be handled more gracefully
- **Code Organization**: Some plugin classes have overlapping responsibilities
- **API Consistency**: Different plugin types have inconsistent interfaces and protocols

*Note: The plugin subsystem enables critical functionality like web content and media playback while maintaining viewer stability. Changes should be carefully tested to ensure they don't compromise security isolation or plugin functionality.*