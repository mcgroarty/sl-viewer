# NewView Subsystem Design

## Purpose

The `newview/` subsystem is the main application layer for the Second Life Viewer. It serves as the central controller that orchestrates all viewer functionality, managing the application lifecycle from startup to shutdown, coordinating between subsystems, and providing the primary user interface. This subsystem solves the problem of integrating diverse components (rendering, networking, UI, avatar management, etc.) into a cohesive virtual world client experience.

## Key Concepts

- **LLAppViewer**: Central application singleton that manages the main event loop and coordinates all subsystems
- **Viewer State Machine**: Application progresses through distinct states (startup, login, connected, shutdown)
- **Frame-based Update Loop**: Continuous cycle of processing events, updating world state, and rendering frames
- **Observer Pattern**: Extensive use of notifications and listeners for decoupled component communication
- **Singleton Management**: Critical subsystems accessed through singleton instances for global coordination
- **Asset Pipeline**: Asynchronous loading and caching of textures, meshes, sounds, and other content
- **Region/World Model**: Virtual world divided into regions with local and remote object management
- **Avatar-centric Perspective**: User experience centered around avatar representation and interaction

## Main Components

### Core Application Files
- **`llappviewer.cpp/.h`** - Main application class handling initialization, main loop, and shutdown
- **`llstartup.cpp/.h`** - Startup sequence management and login process coordination
- **`llviewerwindow.cpp/.h`** - Main window management and root UI container
- **`llappviewerlistener.cpp/.h`** - Command dispatcher for external automation interfaces

### Platform-Specific Implementations
- **`llappviewermacosx.cpp/.h`** - macOS-specific application behavior and system integration
- **`llappviewerlinux.cpp/.h`** - Linux-specific application behavior and system integration  
- **`llappviewerwin32.cpp/.h`** - Windows-specific application behavior and system integration

### World and Object Management
- **`llworld.cpp/.h`** - Global world state and region management
- **`llviewerobject.cpp/.h`** - Base class for all renderable objects in the virtual world
- **`llviewerobjectlist.cpp/.h`** - Management and tracking of all objects in view
- **`llviewerregion.cpp/.h`** - Individual region (simulator) management and communication
- **`llvoavatar.cpp/.h`** - Avatar rendering and animation management
- **`llvoavatarself.cpp/.h`** - User's own avatar with additional controls and permissions

### User Interface Coordination
- **`llviewermenu.cpp/.h`** - Main menu system and action dispatching
- **`llviewermenufile.cpp/.h`** - File operations and import/export functionality
- **`llfloater*.cpp/.h`** - Numerous floating window implementations (100+ files)
- **`llpanel*.cpp/.h`** - Panel components for complex UI layouts (80+ files)

### Asset and Media Management
- **`llviewerassetstorage.cpp/.h`** - Asset downloading and caching coordination
- **`llviewerinventory.cpp/.h`** - User inventory management and operations
- **`llviewermedia.cpp/.h`** - Web media and streaming content integration
- **`lltexturefetch.cpp/.h`** - Asynchronous texture downloading and processing

## How It Works

### Application Lifecycle
1. **Initialization Phase**
   - Parse command line arguments and load initial settings
   - Initialize core subsystems (llcommon, llmath, llrender, etc.)
   - Create main window and OpenGL context
   - Load user interface definitions and create widget hierarchy

2. **Login and Connection**
   - Present login screen and handle user authentication
   - Retrieve grid information and establish simulator connections
   - Download initial world data and user inventory
   - Initialize user's avatar and spawn in virtual world

3. **Main Event Loop** (60 FPS target)
   - Process system events (window, input, network messages)
   - Update world state (object positions, animations, physics)
   - Update user interface (widget states, animations, layouts)
   - Render 3D world and 2D UI overlay
   - Handle background tasks (asset downloads, inventory sync)

4. **Shutdown Sequence**
   - Save user settings and cache data
   - Disconnect from simulators and clean up network connections
   - Destroy UI elements and release OpenGL resources
   - Shut down subsystems in reverse initialization order

### Key Control Flows
- **Event Processing**: System events → LLAppViewer → Subsystem handlers → UI updates
- **Frame Updates**: Timer → Update world → Update UI → Render frame → Present
- **Network Messages**: Receive → Parse → Route to handlers → Update state → Notify observers
- **User Actions**: UI interaction → Command dispatch → State changes → Notifications

## Interfaces and Integration

### Public APIs
- **LLAppViewer instance methods**: Main application control and state queries
- **Global function interfaces**: Utility functions for common operations across subsystems
- **Notification system**: Event broadcasting for loose coupling between components
- **Settings framework**: Persistent configuration management across application restarts

### Data Formats Consumed
- **XUI (XML UI) files**: User interface layout and widget definitions
- **Settings XML**: Application configuration and user preferences
- **Shader files (GLSL)**: Graphics pipeline programs loaded at startup
- **Localization files**: Multi-language text resources

### Data Formats Produced  
- **Log files**: Application events, errors, and debugging information
- **Crash dumps**: Error reporting and debugging information
- **User settings**: Persistent configuration and preferences
- **Cache data**: Temporary asset storage for performance

### Service Endpoints
- **HTTP capabilities**: RESTful web services for grid communication
- **UDP messaging**: Real-time communication with simulators
- **Voice services**: WebRTC-based voice communication
- **Web services**: Marketplace, profiles, and other web-integrated features

## Configuration

### Command Line Arguments
- `--set <setting> <value>`: Override individual application settings
- `--settings <file>`: Load settings from alternative configuration file
- `--channel <name>`: Specify release channel for updates and reporting
- `--grid <gridname>`: Connect to specific grid (main grid, beta grid, etc.)
- `--loginuri <uri>`: Override login server URL for private grids
- `--helperuri <uri>`: Override helper services URL

### Configuration Files
- **`settings.xml`**: Core application settings and preferences
- **`settings_per_account.xml`**: Per-user account-specific settings
- **`featuretable.txt`**: Hardware-specific graphics capability detection
- **`app_settings/`**: Directory containing shaders, cursors, and other assets

### Environment Variables
- `SECONDLIFE_*`: Various runtime configuration overrides
- Standard OpenGL and system library environment variables apply

## Testing

### Test Locations
- **`tests/`** subdirectory: Unit tests for core newview functionality
- **Integration tests**: Located in `indra/integration_tests/`
- **Manual testing**: Extensive QA processes for virtual world interactions

### Testing Strategy
- **Unit tests**: Critical application logic and state management
- **Integration tests**: Cross-subsystem communication and data flow
- **Performance tests**: Frame rate stability and memory usage validation
- **User experience tests**: Manual testing of complex interaction scenarios
- **Automated UI tests**: Basic user interface functionality verification

### Known Testing Limitations
- Complex virtual world interactions are difficult to automate
- Graphics rendering tests require specific hardware configurations
- Network-dependent features need controlled server environments
- Platform-specific behavior requires testing on multiple operating systems

## Performance and Constraints

### Performance Considerations
- **Frame Rate Target**: 60 FPS in typical usage scenarios
- **Memory Management**: Large texture and mesh caches require careful memory monitoring
- **Network Optimization**: Prioritization of critical data over background downloads
- **Rendering Optimization**: Level-of-detail systems and frustum culling for complex scenes

### Resource Constraints
- **Memory Usage**: Typical range 1-4 GB depending on cache size and content complexity
- **Network Bandwidth**: Adaptive quality based on available connection speed
- **GPU Requirements**: Modern OpenGL support required for advanced rendering features
- **Storage Requirements**: Local cache can grow to several gigabytes

### Time Complexity
- **Object Updates**: O(n) where n is number of visible objects per frame
- **UI Processing**: O(m) where m is number of active UI elements
- **Network Processing**: Varies with message volume and complexity

## Dependencies

### External Libraries
- **OpenGL**: Core graphics rendering API
- **Boost**: C++ utility libraries for signals, threading, and data structures
- **libcurl**: HTTP client for web service communication
- **OpenAL**: 3D audio positioning and playback
- **WebRTC**: Voice communication infrastructure
- **Freetype**: Font rendering and text layout

### Internal Module Dependencies
- **llcommon**: Core utilities, threading, and data structures (critical dependency)
- **llrender**: OpenGL abstraction and rendering pipeline (critical dependency)
- **llui**: User interface framework and widget system (critical dependency)
- **llmessage**: Network communication and protocol handling (critical dependency)
- **llmath**: Mathematical operations and 3D geometry (critical dependency)
- **llwindow**: Platform-specific window and input management (critical dependency)
- **llimage**: Texture loading, processing, and format conversion
- **llaudio**: Audio system integration and spatial sound
- **llcharacter**: Avatar animation and appearance systems
- **llinventory**: Asset and inventory management

## Known Issues / TODOs

### Design Weaknesses
- **Monolithic application structure**: Large single executable with tightly coupled subsystems
- **Singleton overuse**: Heavy reliance on singleton pattern creates testing and modularity challenges
- **Global state management**: Extensive use of global variables complicates state reasoning
- **Platform abstraction**: Inconsistent abstraction layers for cross-platform functionality

### Performance Issues
- **Memory fragmentation**: Long-running sessions can experience memory fragmentation
- **Asset loading hitches**: Large asset downloads can cause frame rate stutters
- **UI responsiveness**: Complex UI operations can block the main thread

### Future Refactoring Needs
- **Component-based architecture**: Move toward more modular, loosely-coupled design
- **Thread safety improvements**: Better separation of render and update threads
- **Plugin system expansion**: More functionality exposed through plugin interfaces
- **State management**: Centralized state management with immutable data patterns

### Related GitHub Issues
- Performance optimization tracking issues
- Memory leak investigation and fixes
- Cross-platform compatibility improvements
- User interface modernization efforts

*Note: Specific GitHub issue numbers should be referenced as they become available and relevant to architectural decisions.*