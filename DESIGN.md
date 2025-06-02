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

The viewer uses a hybrid storage model combining local caching with server-synchronized data. For detailed information about data management, refer to the relevant subsystem design documents:

- **Asset and Inventory Management**: See [DESIGN-llinventory.md](indra/DESIGN-llinventory.md) for comprehensive inventory and asset handling
- **Local Storage**: File system and caching details in [DESIGN-llfilesystem.md](indra/DESIGN-llfilesystem.md) (if available)
- **Network Data**: Client-server synchronization covered in [DESIGN-llmessage.md](indra/DESIGN-llmessage.md)
- **Settings Management**: Configuration handling distributed across relevant subsystems

### Key Concepts
- **Local cache** for frequently accessed assets and settings
- **Server-authoritative** model for inventory and world state  
- **Hierarchical UUIDs** for universal asset identification
- **Version-controlled** settings and preferences

## 6. Security and Permissions Model

Security is implemented across multiple subsystems with both client-side validation and server-side authority. For detailed security implementation:

- **Network Security**: Communication security details in [DESIGN-llmessage.md](indra/DESIGN-llmessage.md) and [DESIGN-llcorehttp.md](indra/DESIGN-llcorehttp.md)
- **Asset Permissions**: Inventory and asset access control in [DESIGN-llinventory.md](indra/DESIGN-llinventory.md)
- **Authentication**: Login and session management in [DESIGN-newview.md](indra/DESIGN-newview.md)

### Key Security Principles
- **Capability-based authorization** system for secure resource access
- **Client-side validation** with server-side authority for critical operations
- **Encrypted communication** for sensitive data transmission
- **Granular permissions** for asset sharing and world modification

## 7. Extensibility and Plugins

The viewer supports extensibility through multiple plugin systems and open-source development. For detailed plugin architecture:

- **Plugin Framework**: Core plugin system details in [DESIGN-llplugin.md](indra/DESIGN-llplugin.md) (if available)
- **Media Integration**: Covered in media plugin subsystems
- **UI Customization**: Extensibility details in [DESIGN-llui.md](indra/DESIGN-llui.md)

### Extension Mechanisms
- **Media plugins** for web content and video playback
- **Shader customization** for advanced graphics effects
- **UI modification** through XUI files and custom widgets
- **Open source licensing** enabling community forks and contributions

For contribution guidelines, see [CONTRIBUTING.md](CONTRIBUTING.md) and [doc/contributions.txt](doc/contributions.txt).

## 8. Performance Considerations

Performance optimization is implemented across all subsystems. For detailed performance information, refer to the Performance and Constraints section in each subsystem's design document:

- **Rendering Performance**: [DESIGN-llrender.md](indra/DESIGN-llrender.md)
- **Network Optimization**: [DESIGN-llmessage.md](indra/DESIGN-llmessage.md) and [DESIGN-llcorehttp.md](indra/DESIGN-llcorehttp.md)
- **Mathematical Operations**: [DESIGN-llmath.md](indra/DESIGN-llmath.md)
- **UI Responsiveness**: [DESIGN-llui.md](indra/DESIGN-llui.md)
- **Memory Management**: [DESIGN-llcommon.md](indra/DESIGN-llcommon.md)

### Performance Strategies
- **Level-of-detail systems** for graphics and simulation
- **Efficient caching** and background loading
- **SIMD optimization** for mathematical operations
- **Asynchronous operations** to maintain UI responsiveness

## 9. Known Trade-offs and Design Decisions

Major architectural trade-offs and design decisions are documented within each subsystem's design document under the "Known Issues / TODOs" section. This distributed approach provides context-specific details about decisions affecting each component.

### Key Trade-offs Overview
- **C++ vs. Higher-Level Languages**: Performance and hardware access vs. development complexity
- **Custom UI Framework**: Hardware acceleration vs. native platform integration
- **OpenGL Cross-platform**: Platform uniformity vs. platform-specific optimizations
- **Client-Server Model**: Authoritative world state vs. offline capabilities
- **Asset Streaming**: Faster initial experience vs. network reliability requirements

For detailed analysis of specific design decisions, refer to the relevant subsystem design documents.

## 10. Suggested Future Plans / TODOs

> **Important Disclaimer:** The suggestions in this section are AI-generated and offered for discussion purposes only. They do not constitute commitments or official plans from Linden Lab. These AI-generated suggestions may be periodically updated to reflect evolving technology and best practices.
>
> **Source of Truth for Actual Plans:** For official roadmaps and confirmed development plans, please refer to:
> - GitHub Issues in this repository
> - The feature request board at https://feedback.secondlife.com/
> - Internal Linden Lab roadmaps and official announcements

Future improvement suggestions are detailed in each subsystem's design document under the "Known Issues / TODOs" section. This provides context-specific recommendations aligned with each component's architecture and constraints.

### High-Level Improvement Areas
- **Graphics Modernization**: Vulkan support, enhanced PBR materials, improved performance
- **Architecture Evolution**: Modern C++ standards, modular design, better error handling
- **Platform Support**: WebAssembly, cloud streaming, VR/AR integration
- **Developer Experience**: Improved build systems, documentation, and debugging tools
- **User Experience**: Enhanced UI accessibility, improved onboarding, better content discovery
- **Code Quality**: Technical debt reduction, modernization, increased test coverage

For specific implementation details and priorities, consult the individual subsystem design documents and official project planning resources.

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