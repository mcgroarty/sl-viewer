# Second Life Viewer Design Document

> **Note:** This initial version of the design document was created by an AI agent to provide comprehensive architectural documentation for the Second Life Viewer project. It serves as a starting point for understanding the codebase and will be updated by human maintainers as the architecture evolves.

## 1. Overview

### Project Purpose
The Second Life Viewer is the official client application for the Second Life virtual world platform. It serves as the primary interface between users and the Second Life metaverse, enabling real-time 3D interaction, social communication, content creation, and economic transactions within a persistent virtual environment.

For additional documentation, resources, and development information, visit the [Second Life Open Source Portal](https://wiki.secondlife.com/wiki/Open_Source_Portal), which serves as the official documentation portal for all open source Second Life projects.

**Who uses it:**
- End users accessing the Second Life virtual world
- Content creators building and scripting virtual objects
- Virtual world developers and third-party viewer maintainers
- Researchers and educators using virtual environments

**Goals it serves:**
- Provide immersive 3D virtual world experiences with real-time rendering
- Enable social interaction through avatars, chat, and voice communication
- Support user-generated content creation and scripting (LSL - Linden Scripting Language)
- Facilitate virtual economy through asset transactions and marketplace integration
- Maintain cross-platform compatibility (Windows, macOS, Linux)

For information on how to contribute to this project, see [CONTRIBUTING.md](CONTRIBUTING.md).

### High-Level Architecture
The viewer follows a modular, layered architecture designed around real-time 3D rendering, network communication, and user interface systems:

```
┌─────────────────────────────────────────┐
│              Application Layer           │
│         (llappviewer, main loop)        │
├─────────────────────────────────────────┤
│           User Interface Layer          │
│        (llui, floaters, panels)         │
├─────────────────────────────────────────┤
│          Rendering Pipeline             │
│     (pipeline, drawable objects)        │
├─────────────────────────────────────────┤
│     Game Logic & World Management       │
│  (avatars, objects, physics, inventory) │
├─────────────────────────────────────────┤
│        Network & Communication          │
│     (messaging, HTTP, voice, media)     │
├─────────────────────────────────────────┤
│         Core Systems & Utilities        │
│    (llcommon, math, memory, threading)  │
└─────────────────────────────────────────┘
```

### Subsystem Documentation Structure

This document provides a high-level architectural overview. Detailed subsystem documentation is maintained in individual `DESIGN-(directory).md` files within the `indra/` source tree for each major subsystem. Each subsystem design document follows a standardized template with the following sections:

**Template Structure:**

1. **Purpose** - Role of the subsystem and problems it solves
2. **Key Concepts** - Domain-specific terms, abstractions, and design patterns
3. **Main Components** - Core modules, classes, and files with their relationships
4. **How It Works** - Control flows, data flows, algorithms, and logic paths
5. **Interfaces and Integration** - APIs, data formats, and interactions with other subsystems
6. **Configuration** - Environment variables, config files, and settings
7. **Testing** - Test locations, strategies, and coverage limitations
8. **Performance and Constraints** - Performance considerations and resource constraints
9. **Dependencies** - External packages and internal module dependencies
10. **Known Issues / TODOs** - Design weaknesses, refactors, and open issues

**Available Subsystem Documentation:**

- [DESIGN-newview.md](indra/DESIGN-newview.md) - Main viewer application
- [DESIGN-llcommon.md](indra/DESIGN-llcommon.md) - Common utilities and base classes
- [DESIGN-llui.md](indra/DESIGN-llui.md) - User interface framework
- [DESIGN-llmessage.md](indra/DESIGN-llmessage.md) - Network messaging system
- [DESIGN-llmath.md](indra/DESIGN-llmath.md) - Mathematical utilities
- [DESIGN-llcorehttp.md](indra/DESIGN-llcorehttp.md) - HTTP core functionality
- [DESIGN-llrender.md](indra/DESIGN-llrender.md) - Rendering pipeline
- [DESIGN-llcharacter.md](indra/DESIGN-llcharacter.md) - Character and avatar system
- [DESIGN-llprimitive.md](indra/DESIGN-llprimitive.md) - 3D object primitives
- [DESIGN-llinventory.md](indra/DESIGN-llinventory.md) - Inventory management
- [DESIGN-llwindow.md](indra/DESIGN-llwindow.md) - Window management
- [DESIGN-llappearance.md](indra/DESIGN-llappearance.md) - Avatar appearance system

### Key Features
- **Real-time 3D rendering** with advanced lighting, shadows, and materials (PBR support)
- **Avatar-based social interaction** with customizable appearances and animations
- **Voice and text communication** systems for individual and group conversations
- **User-generated content support** including building tools and LSL scripting
- **Economic systems** with virtual currency (L$) and marketplace integration
- **Cross-platform compatibility** supporting Windows, macOS, and Linux
- **Plugin architecture** for media playback and voice communication
- **Advanced graphics features** including water/sky rendering, post-processing effects
- **Inventory management** for user assets and virtual possessions

## 2. Directory Structure and Purposes

### Top-Level Directories

- **`indra/`** - Main source code tree containing all C++ libraries and applications
- **`scripts/`** - Build scripts, code generation tools, and utility scripts
- **`doc/`** - Documentation files, licenses, and project metadata (see [doc/](doc/))
- **`etc/`** - Configuration files and message templates
- **`buildscripts_support_functions`** - Build system support functions

For detailed build instructions, refer to the [Second Life Open Source Portal](https://wiki.secondlife.com/wiki/Open_Source_Portal) build guides.

### Core Indra Libraries

The `indra/` directory contains modular C++ libraries organized by functionality. Each major subsystem has its own directory with detailed documentation in its respective `DESIGN-(directory).md` file:

**Major Subsystems:**
- **`newview/`** - Main viewer application ([DESIGN-newview.md](indra/DESIGN-newview.md))
- **`llcommon/`** - Common utilities and base classes ([DESIGN-llcommon.md](indra/DESIGN-llcommon.md))
- **`llui/`** - User interface framework ([DESIGN-llui.md](indra/DESIGN-llui.md))
- **`llmessage/`** - Network messaging system ([DESIGN-llmessage.md](indra/DESIGN-llmessage.md))
- **`llrender/`** - OpenGL rendering abstraction ([DESIGN-llrender.md](indra/DESIGN-llrender.md))
- **`llmath/`** - Mathematical utilities ([DESIGN-llmath.md](indra/DESIGN-llmath.md))

**Supporting Libraries:**
- **`llcharacter/`** - Avatar animation systems ([DESIGN-llcharacter.md](indra/DESIGN-llcharacter.md))
- **`llinventory/`** - Asset and inventory management ([DESIGN-llinventory.md](indra/DESIGN-llinventory.md))
- **`llappearance/`** - Avatar appearance system ([DESIGN-llappearance.md](indra/DESIGN-llappearance.md))
- **`llwindow/`** - Platform-specific window management ([DESIGN-llwindow.md](indra/DESIGN-llwindow.md))
- **`llprimitive/`** - 3D object geometry ([DESIGN-llprimitive.md](indra/DESIGN-llprimitive.md))
- **`llcorehttp/`** - HTTP core functionality ([DESIGN-llcorehttp.md](indra/DESIGN-llcorehttp.md))

**Utility Libraries:**
- **`llimage/`** - Image processing and texture handling
- **`llaudio/`** - Audio system and sound management
- **`llfilesystem/`** - File I/O and disk cache management
- **`llxml/`** - XML parsing and serialization utilities
- **`llplugin/`** - Plugin architecture for media and voice systems
- **`media_plugins/`** - Platform-specific media plugin implementations
- **`llwebrtc/`** - WebRTC integration for voice communication

## 3. Languages, Frameworks, and File Formats

### Primary Languages

**C++ (Primary)** - Used for the core application, chosen for:
- Performance requirements of real-time 3D rendering
- Direct OpenGL and platform API access
- Memory management control for large virtual worlds
- Extensive existing codebase and library ecosystem

**Objective-C++** - Used for macOS-specific functionality
- Native macOS integration and system services
- Cocoa framework interoperability

**Python** - Used for build scripts and tools
- Cross-platform build automation
- String processing and code generation utilities

### Key Frameworks and Libraries

**Graphics and Rendering:**
- **OpenGL** - Core graphics API for cross-platform 3D rendering
- **GLSL** - Shader language for graphics pipeline customization
- **OpenJPEG** - JPEG 2000 image compression for texture streaming

**Networking:**
- **libcurl** - HTTP client for web services and asset downloads
- **Custom UDP messaging** - Low-latency communication with simulators
- **WebRTC** - Voice communication infrastructure

**Audio:**
- **OpenAL** - Cross-platform 3D audio positioning
- **libsndfile** - Audio file format support

**UI Framework:**
- **Custom widget system** - Built on top of OpenGL for hardware acceleration
- **Boost libraries** - Signal/slots, smart pointers, and utility functions

**Build System:**
- **CMake** - Cross-platform build configuration
- **Autobuild** - Linden Lab's dependency management system

### File Formats Used

**Configuration and Data:**
- **XML** - UI definitions (XUI), settings, and configuration files
- **JSON/LLSD** - Data serialization and communication protocol
- **INI** - Simple configuration files
- **DAE (COLLADA)** - 3D model interchange format

**Assets and Media:**
- **JPEG 2000** - Texture compression with progressive loading
- **glTF** - Modern 3D asset format with PBR materials
- **OGG Vorbis** - Audio compression format
- **Various image formats** - PNG, TGA, BMP for textures and UI

**Scripts and Code:**
- **LSL (Linden Scripting Language)** - In-world object scripting
- **GLSL** - Vertex and fragment shaders for rendering effects

## 4. Major Systems and Components

The Second Life Viewer is built from several interconnected systems. This section provides a high-level overview of the major components. For detailed information about each system, refer to the specific subsystem design documents listed in the [Subsystem Documentation Structure](#subsystem-documentation-structure) section.

### Application Core
Central application controller managing initialization, main loop, and shutdown. Implemented primarily in the `newview/` subsystem with supporting utilities from `llcommon/`. See [DESIGN-newview.md](indra/DESIGN-newview.md) for detailed architecture.

### Rendering Pipeline
Real-time 3D rendering system providing advanced graphics features including deferred rendering, PBR materials, and spatial optimization. Implemented in the `llrender/` subsystem with mathematical support from `llmath/`. See [DESIGN-llrender.md](indra/DESIGN-llrender.md) and [DESIGN-llmath.md](indra/DESIGN-llmath.md).

### Network Communication
Handles all communication with Second Life servers using custom UDP protocols and HTTP services. Implemented in the `llmessage/` and `llcorehttp/` subsystems. See [DESIGN-llmessage.md](indra/DESIGN-llmessage.md) and [DESIGN-llcorehttp.md](indra/DESIGN-llcorehttp.md).

### User Interface System
Comprehensive UI framework providing widget-based interface with XML-driven definitions. Implemented in the `llui/` subsystem with window management from `llwindow/`. See [DESIGN-llui.md](indra/DESIGN-llui.md) and [DESIGN-llwindow.md](indra/DESIGN-llwindow.md).

### Avatar and Character Systems
Manages avatar rendering, animation, and appearance customization. Implemented across `llcharacter/` and `llappearance/` subsystems with primitive support from `llprimitive/`. See [DESIGN-llcharacter.md](indra/DESIGN-llcharacter.md), [DESIGN-llappearance.md](indra/DESIGN-llappearance.md), and [DESIGN-llprimitive.md](indra/DESIGN-llprimitive.md).

### Inventory and Asset Management
Handles user possessions, asset caching, and server synchronization. Implemented in the `llinventory/` subsystem with file system support from `llfilesystem/`. See [DESIGN-llinventory.md](indra/DESIGN-llinventory.md).

### Plugin Architecture
Extensible system for media playback and voice communication through dynamically loaded plugins. Implemented in `llplugin/` and `media_plugins/` subsystems.

## 5. Data Model and Storage

### Data Architecture Overview
The viewer uses a hybrid storage model combining local caching with server-synchronized data:

- **Local cache** for frequently accessed assets and settings
- **Server-authoritative** model for inventory and world state
- **Hierarchical UUIDs** for universal asset identification
- **Version-controlled** settings and preferences

### Storage Systems

**Asset Cache:**
- Texture cache with LRU eviction policy
- Mesh and animation data caching
- Sound file local storage
- Configurable cache size limits

**Inventory Database:**
- Hierarchical folder structure
- Item metadata with permissions
- Local SQLite storage for offline access
- Server synchronization on changes

**Settings Storage:**
- XML-based configuration files
- Per-account and global settings separation
- Default value fallback system
- Live update capabilities

**Temporary Data:**
- Object update queues
- Network message buffers
- Render command lists
- UI state variables

### Schema and Versioning

**Asset References:**
```
UUID → Asset Type → Data Location
├── Texture → Cache File → Compressed Image Data
├── Mesh → Cache File → Vertex/Index Buffers
├── Animation → Cache File → Keyframe Data
└── Script → Memory → Compiled Bytecode
```

**Settings Hierarchy:**
- Global defaults in app_settings/
- User overrides in user directory
- Per-account settings for multi-user support
- Runtime modifications in memory

**Version Management:**
- Cache versioning for asset format changes
- Settings migration on viewer updates
- Backward compatibility preservation
- Clean migration paths for breaking changes

## 6. Security and Permissions Model

### Authentication Mechanisms

**Initial Authentication:**
- Username/password or OAuth-based login
- HTTPS-secured credential transmission
- Time-limited authentication tokens
- Optional two-factor authentication support

**Session Management:**
- Capability-based authorization system
- Time-limited session tokens
- Automatic token renewal
- Secure logout procedures

### Access Control System

**Asset Permissions:**
- Copy, Modify, Transfer permission flags
- Creator and owner attribution
- Group-based sharing mechanisms
- Marketplace licensing integration

**World Permissions:**
- Land parcel access controls
- Group membership requirements
- Payment-based access gates
- Ban list enforcement

**Communication Controls:**
- Block list for unwanted interactions
- Voice communication permissions
- Friend list and presence sharing
- Group communication privileges

### Security Enforcement Points

**Client-Side Validation:**
- Input sanitization for user data
- Bounds checking for UI interactions
- Asset format validation
- Network message verification

**Server-Side Authority:**
- All critical operations server-verified
- Economic transactions secured
- Object creation permissions
- World modification controls

### Data Protection

**Local Data Security:**
- Settings file access restrictions
- Cache file integrity checking
- Credential storage protection
- Secure memory handling for sensitive data

**Network Security:**
- HTTPS for web service communication
- Encrypted voice communication
- Message integrity verification
- Protection against common attack vectors

## 7. Extensibility and Plugins

### Plugin Architecture

**Media Plugins:**
- CEF (Chromium Embedded Framework) for web content
- Platform-specific video decoders
- Audio codec implementations
- Streaming media support

**Plugin Interface:**
- Standardized API for plugin communication
- Process isolation for stability
- Dynamic loading and unloading
- Version compatibility checking

### Extension Points

**Shader System:**
- Custom GLSL shader loading
- Material parameter customization
- Post-processing effect chains
- Runtime shader compilation

**UI Customization:**
- XUI file modification support
- Custom widget development
- Skin and theme systems
- Layout manager extensions

**Script Integration:**
- LSL compilation and execution
- Custom function libraries
- External service integration
- Debug and development tools

### Third-Party Development

**Viewer Forks:**
- Open source license (LGPL) enables derivatives (see [doc/LGPL-license.txt](doc/LGPL-license.txt))
- Standardized build system for modifications
- Community-maintained feature branches
- Backward compatibility guidelines

For contribution guidelines and community information, see [CONTRIBUTING.md](CONTRIBUTING.md) and [doc/contributions.txt](doc/contributions.txt).

**Asset Pipeline:**
- External content creation tool support
- Import/export format standardization
- Asset validation tools
- Batch processing utilities

## 8. Performance Considerations

### Known Bottlenecks

**Rendering Performance:**
- High polygon count scenes with many avatars
- Texture memory limitations on older hardware
- Shader compilation overhead on startup
- Transparency overdraw in complex scenes

**Network Constraints:**
- Asset download bandwidth for new users
- UDP packet loss in poor network conditions
- HTTP request queuing for web services
- Voice quality degradation with high latency

**Memory Management:**
- Large texture datasets requiring careful cache management
- Asset decompression creating temporary memory spikes
- UI widget creation and destruction overhead
- Fragmentation from long-running sessions

### Implemented Optimizations

**Graphics Optimizations:**
- Level-of-detail (LOD) system for objects and avatars
- Frustum and occlusion culling
- Texture compression and streaming
- Deferred rendering for complex lighting
- Instancing for repeated geometry

**Network Optimizations:**
- Delta compression for object updates
- Priority-based message queuing
- Asset caching with intelligent prefetching
- Connection pooling for HTTP requests

**Memory Management:**
- Smart pointer usage for automatic cleanup
- Object pooling for frequently created items
- Lazy loading of assets and UI components
- Garbage collection for script objects

### Performance Guidelines

**Rendering Best Practices:**
- Maintain consistent frame rates through adaptive quality
- Use appropriate LOD levels for viewing distance
- Minimize state changes in render batches
- Profile shader performance regularly

**Network Efficiency:**
- Batch small operations where possible
- Implement proper retry mechanisms
- Cache frequently accessed data
- Monitor bandwidth usage patterns

**Memory Usage:**
- Set appropriate cache size limits
- Release unused resources promptly
- Monitor for memory leaks in long sessions
- Use memory-mapped files for large assets

## 9. Known Trade-offs and Design Decisions

### Technology Choices

**C++ Over Higher-Level Languages:**
- **Chosen for:** Performance, hardware access, existing ecosystem
- **Trade-off:** Development complexity vs. runtime efficiency
- **Limitation:** Longer development cycles, more potential for memory issues

**Custom UI Framework vs. Standard Toolkit:**
- **Chosen for:** Hardware acceleration, game-like experience
- **Trade-off:** Custom development vs. native platform integration
- **Limitation:** Accessibility features require additional implementation

**OpenGL Over DirectX or Vulkan:**
- **Chosen for:** Cross-platform compatibility
- **Trade-off:** Platform uniformity vs. platform-specific optimizations
- **Limitation:** Cannot leverage latest GPU features as quickly

### Architecture Decisions

**Client-Server Model:**
- **Chosen for:** Authoritative world state, anti-cheat protection
- **Trade-off:** Network dependency vs. offline capabilities
- **Limitation:** Requires constant internet connection

**Asset Streaming vs. Full Download:**
- **Chosen for:** Faster initial experience, reduced storage requirements
- **Trade-off:** Smooth streaming vs. network reliability issues
- **Limitation:** Poor experience with slow or unreliable connections

**Monolithic vs. Microservice Architecture:**
- **Chosen for:** Simplified deployment, shared state access
- **Trade-off:** Single process reliability vs. fault isolation
- **Limitation:** One component failure can crash entire application

### Performance vs. Quality Decisions

**Texture Compression:**
- **Chosen:** JPEG 2000 for progressive loading
- **Trade-off:** Load times vs. visual quality
- **Limitation:** CPU overhead for decompression

**Animation System:**
- **Chosen:** Client-side animation blending
- **Trade-off:** Smooth animation vs. network bandwidth
- **Limitation:** Synchronization challenges in multi-user scenarios

**Rendering Fidelity:**
- **Chosen:** Configurable quality levels
- **Trade-off:** Visual appeal vs. hardware compatibility
- **Limitation:** Wide performance variance across user hardware

## 10. Suggested Future Plans / TODOs

> **Important Disclaimer:** The suggestions in this section are AI-generated and offered for discussion purposes only. They do not constitute commitments or official plans from Linden Lab. These AI-generated suggestions may be periodically updated to reflect evolving technology and best practices.
>
> **Source of Truth for Actual Plans:** For official roadmaps and confirmed development plans, please refer to:
> - GitHub Issues in this repository
> - The feature request board at https://feedback.secondlife.com/
> - Internal Linden Lab roadmaps and official announcements

### Short-term Improvements (Next 6-12 months)

- **[ ] Graphics Modernization**
  - Vulkan rendering backend for better performance
  - Enhanced PBR material support
  - Improved HDR and tone mapping
  - Better shadow mapping techniques

- **[ ] Performance Optimizations**
  - Multi-threaded asset loading
  - Improved object culling algorithms
  - Better memory pool management
  - Network protocol optimizations

- **[ ] User Experience Enhancements**
  - Modernized UI framework with better accessibility
  - Improved onboarding experience for new users
  - Enhanced inventory search and management

### Long-term Architectural Changes (1-3 years)

- **[ ] Core Infrastructure**
  - Migration to modern C++ standards (C++20/23)
  - Modular architecture with plugin-based components
  - Improved error handling and crash recovery
  - Better debugging and profiling tools

- **[ ] Platform Modernization**
  - WebAssembly build target for browser compatibility
  - Cloud streaming capabilities
  - VR/AR platform integration

- **[ ] Developer Experience**
  - Improved build system with better dependency management
  - Enhanced debugging tools and profilers
  - Better documentation and API references
  - Streamlined third-party contribution process

### Technology Evolution

- **[ ] Next-Generation Features**
  - AI-assisted content discovery (suggesting marketplace items for user outfits or builds, helping users find relevant community-created content)
  - Advanced physics simulation improvements
  - Procedural content generation tools
  - Enhanced social interaction features

- **[ ] Deprecation Plans**
  - Legacy OpenGL code paths in favor of modern APIs
  - Old asset formats migration to more efficient ones
  - Phased retirement of obsolete platform support
  - Cleanup of technical debt in core systems

### Code Quality Improvements

- **[ ] Technical Debt Reduction**
  - Refactor legacy code modules with poor maintainability
  - Improve unit test coverage across all components
  - Standardize error handling patterns
  - Update documentation for all public APIs

- **[ ] Code Modernization**
  - Adopt modern C++ idioms and best practices
  - Improve const-correctness throughout codebase
  - Better separation of concerns in large classes
  - Reduce coupling between major subsystems

### TODOs Tagged in Code

The codebase contains numerous TODO comments that should be addressed:
- Performance optimization opportunities in rendering pipeline
- Error handling improvements in network code
- Memory leak fixes in UI components
- Documentation updates for public interfaces
- Platform-specific code cleanup and standardization

---

## Document Maintenance and Objectives

### Document Purpose and Scope
This DESIGN.md document serves multiple objectives:
- **Architectural Reference**: Provides developers with a comprehensive understanding of the system design and component relationships
- **Onboarding Guide**: Helps new developers quickly understand the codebase structure and design decisions
- **Design Decision Documentation**: Records the rationale behind architectural choices for future reference
- **Development Planning**: Serves as a foundation for discussing future improvements and changes

The document complements [CONTRIBUTING.md](CONTRIBUTING.md) by focusing on the **"what and why"** of the architecture, while CONTRIBUTING.md addresses the **"how"** of contributing to the project.

### When to Update This Document
This document should be updated in the following circumstances:

**Required Updates (High Priority):**
- Major architectural changes or refactoring efforts
- Addition or removal of core system components
- Significant changes to the build system or dependencies
- Updates to data models or storage systems
- Changes to security or permissions model

**Recommended Updates (Medium Priority):**
- New major features that introduce significant code changes
- Performance optimization efforts that affect multiple systems
- Updates to external dependencies that impact architecture
- Changes to plugin interfaces or extensibility points

**Optional Updates (Low Priority):**
- Minor feature additions within existing frameworks
- Bug fixes that don't affect overall architecture
- Documentation improvements in other files
- Updates to suggested future plans based on new priorities

### Update Process
1. **Before making changes**: Review existing content to understand current architectural documentation
2. **During development**: Update relevant sections as architectural decisions are made
3. **After implementation**: Validate that documentation accurately reflects the final implementation
4. **Regular maintenance**: Review and update suggested future plans quarterly

### Responsibility for Updates
- **Core maintainers**: Responsible for major architectural documentation updates
- **Feature developers**: Should update sections related to their changes
- **Community contributors**: Encouraged to suggest improvements via issues or pull requests
- **AI assistance**: May periodically suggest updates to future plans and technical content

**Note:** This document should be updated periodically as the architecture evolves. [CONTRIBUTING.md](CONTRIBUTING.md) handles how to contribute to the project, while DESIGN.md explains the what and why of the architectural decisions and system design.