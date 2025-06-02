# LLCommon Subsystem Design

## Purpose

The `llcommon/` subsystem provides the foundational utilities and infrastructure required by all other components of the Second Life Viewer. It serves as the base layer that solves cross-cutting concerns including memory management, threading primitives, data structures, error handling, logging, and platform abstraction. This subsystem ensures consistent behavior across platforms and provides essential services that enable the higher-level application logic.

## Key Concepts

- **Platform Abstraction**: Unified interfaces that hide platform-specific implementation details
- **Reference Counting**: Smart pointer system (LLPointer) for automatic memory management
- **Singleton Pattern**: Managed singleton lifecycle with dependency tracking and cleanup
- **Event System**: Decoupled communication through event pumps and listeners  
- **LLSD (Linden Structured Data)**: Universal data interchange format supporting hierarchical data
- **Thread Safety**: Mutex, atomic operations, and thread-safe data structures
- **Coroutines**: Cooperative multitasking for asynchronous operations without blocking
- **Logging Framework**: Structured logging with multiple output targets and filtering
- **Timer Services**: High-resolution timing and frame-based scheduling

## Main Components

### Core Infrastructure
- **`llapp.cpp/.h`** - Base application class providing initialization/cleanup framework
- **`llcommon.h`** - Common includes and fundamental definitions for the entire codebase
- **`lldefs.h`** - Basic type definitions, constants, and cross-platform macros
- **`stdtypes.h`** - Standardized type definitions (U32, F32, etc.) for consistency

### Memory Management
- **`llmemory.cpp/.h`** - Memory allocation tracking and debugging utilities
- **`llpointer.h`** - Smart pointer implementation with reference counting
- **`llrefcount.cpp/.h`** - Base class for reference-counted objects
- **`llsafehandle.h`** - Safe handle wrapper for preventing dangling pointers

### Data Structures and Algorithms
- **`llsd.cpp/.h`** - Linden Structured Data format for flexible data storage
- **`llsdjson.cpp/.h`** - JSON serialization/deserialization for LLSD
- **`llsdserialize.cpp/.h`** - Binary and XML serialization for LLSD
- **`llstring.cpp/.h`** - Enhanced string operations and utilities
- **`llstringtable.cpp/.h`** - String interning for memory efficiency
- **`lluuid.cpp/.h`** - Universal unique identifier generation and operations

### Threading and Concurrency
- **`llthread.cpp/.h`** - Thread abstraction and management
- **`llmutex.cpp/.h`** - Mutex and critical section primitives
- **`llcoros.cpp/.h`** - Coroutine implementation for async programming
- **`llqueuedthread.cpp/.h`** - Background processing thread with work queue
- **`llworkerthread.cpp/.h`** - Worker thread pool for parallel processing
- **`threadpool.cpp/.h`** - Modern thread pool implementation

### Event and Messaging System
- **`llevents.cpp/.h`** - Central event pump system for loose coupling
- **`lleventapi.cpp/.h`** - API framework for exposing functionality via events
- **`lleventcoro.cpp/.h`** - Integration between events and coroutines
- **`lleventdispatcher.cpp/.h`** - Event routing and dispatch management

### Timing and Scheduling
- **`lltimer.cpp/.h`** - High-resolution timing and clock services
- **`llframetimer.cpp/.h`** - Frame-based timing for smooth animations
- **`lleventtimer.cpp/.h`** - Timer events for scheduled callbacks
- **`llfasttimer.cpp/.h`** - Performance profiling and timing measurement

### Error Handling and Logging
- **`llerror.cpp/.h`** - Structured logging framework with multiple severity levels
- **`llerrorcontrol.h`** - Compile-time and runtime log filtering
- **`llexception.cpp/.h`** - Exception handling utilities and stack traces
- **`llstacktrace.cpp/.h`** - Stack trace capture for debugging

### File and Network I/O
- **`llfile.cpp/.h`** - Cross-platform file operations and path handling
- **`lluri.cpp/.h`** - URI parsing and manipulation utilities
- **`lluriparser.cpp/.h`** - RFC-compliant URI parser implementation
- **`llprocess.cpp/.h`** - External process execution and management

### Configuration and Settings
- **`lllivefile.cpp/.h`** - File monitoring and automatic reloading
- **`llinitparam.cpp/.h`** - Parameter initialization and validation framework
- **`llkeyusetracker.h`** - Usage tracking for performance optimization

## How It Works

### Initialization Sequence
1. **Static Initialization**: Global objects and singleton registration
2. **LLApp Construction**: Base application setup and platform detection
3. **Subsystem Registration**: Components register with dependency system
4. **Ordered Startup**: Dependencies resolved and systems initialized in order
5. **Service Availability**: Core services become available to higher-level code

### Memory Management Flow
1. **Object Creation**: Reference-counted objects start with count = 1
2. **Pointer Assignment**: LLPointer automatically manages reference counts
3. **Scope Exit**: Reference count decremented when pointers go out of scope
4. **Automatic Cleanup**: Objects deleted when reference count reaches zero
5. **Leak Detection**: Memory tracking identifies unreleased objects

### Event System Operation
1. **Event Registration**: Components register interest in specific event types
2. **Event Posting**: Producers post events to named pumps
3. **Event Routing**: Event system routes messages to registered listeners
4. **Callback Execution**: Listener callbacks executed with event data
5. **Cleanup**: Automatic listener deregistration prevents dangling references

### Threading Model
1. **Main Thread**: Primary application thread handling UI and coordination
2. **Worker Threads**: Background threads for I/O, processing, and computation
3. **Synchronization**: Mutexes and atomic operations ensure thread safety
4. **Coroutines**: Cooperative scheduling within threads for async operations
5. **Work Queues**: Thread-safe queues for distributing work across threads

## Interfaces and Integration

### Public APIs
- **LLSingleton<T>**: Template-based singleton management with dependency resolution
- **LLPointer<T>**: Smart pointer for automatic reference counting
- **LLSD**: Universal data container supporting maps, arrays, and primitive types
- **LL_INFOS()/LL_WARNS()/LL_ERRS()**: Structured logging macros with filtering
- **LLEventPump**: Event publishing and subscription interface

### Data Formats Consumed
- **Configuration files**: INI-style and XML configuration formats
- **Environment variables**: System and application-specific variables
- **Command line arguments**: Standardized argument parsing

### Data Formats Produced
- **Log files**: Structured text logs with timestamps and severity levels
- **Debug dumps**: Binary dumps for crash analysis and debugging
- **Performance data**: Timing measurements and profiling information

### External Dependencies
- **Boost**: C++ utility libraries for shared_ptr, signals, and algorithms
- **PCRE**: Regular expression processing for pattern matching
- **APR (Apache Portable Runtime)**: Cross-platform system abstraction
- **OpenSSL**: Cryptographic functions and secure random number generation

## Configuration

### Compile-time Configuration
- **LL_WINDOWS/LL_DARWIN/LL_LINUX**: Platform-specific conditional compilation
- **LL_DEBUG/LL_RELEASE**: Build configuration affecting assertions and optimizations
- **LL_MSVC/LL_GNUC**: Compiler-specific optimizations and workarounds

### Runtime Configuration
- **Environment variables**: `LOGCONTROL`, `LL_RUN_ERR_CRASH` for debugging behavior
- **Command line flags**: Logging levels and output destinations
- **Configuration files**: Settings affecting memory pools and threading

### Default Settings
- **Thread pool size**: Based on CPU core count with reasonable minimums/maximums
- **Memory allocation**: Default pools sized for typical viewer usage patterns
- **Logging**: INFO level to file, WARN level to console by default

## Testing

### Test Locations
- **`tests/`** subdirectory: Comprehensive unit tests for all major components
- **Integration tests**: Cross-component interaction testing
- **Performance tests**: Memory usage and timing validation

### Testing Strategy
- **Unit tests**: Individual class and function validation with comprehensive coverage
- **Mock objects**: Simulated dependencies for isolated component testing
- **Memory leak tests**: Validation of reference counting and cleanup behavior
- **Thread safety tests**: Multi-threaded stress testing of concurrent data structures
- **Performance regression tests**: Timing benchmarks to detect performance degradation

### Coverage Areas
- **LLSD operations**: Serialization, deserialization, and data manipulation
- **Reference counting**: Pointer lifecycle and automatic cleanup validation
- **Event system**: Event routing, listener management, and error handling
- **Threading primitives**: Mutex behavior, atomic operations, and deadlock detection
- **String operations**: UTF-8 handling, case conversion, and parsing functions

### Known Testing Limitations
- **Platform-specific behavior**: Some tests require execution on target platforms
- **Timing-dependent tests**: Real-time behavior difficult to test deterministically
- **Memory allocation patterns**: Full testing requires long-running scenarios

## Performance and Constraints

### Performance Characteristics
- **Reference counting overhead**: Small constant overhead for automatic memory management
- **Event system latency**: Low-latency message passing with minimal allocation
- **String operations**: Optimized for common viewer use cases (file paths, URLs, user input)
- **LLSD performance**: Efficient for typical data sizes, may be costly for very large datasets

### Memory Constraints
- **Reference cycles**: Circular references can cause memory leaks (requires weak references)
- **String storage**: Large numbers of temporary strings can cause fragmentation
- **Event listener overhead**: Each listener registration consumes memory until cleanup

### Threading Constraints
- **Contention points**: Shared data structures may become bottlenecks under heavy load
- **Context switching**: Excessive thread creation can degrade performance
- **Lock ordering**: Potential deadlocks if consistent lock ordering not maintained

### Time Complexity
- **LLSD operations**: O(1) for primitive access, O(n) for iteration, O(log n) for map operations
- **Event dispatch**: O(n) where n is number of registered listeners
- **String table lookup**: O(1) average case for interned string access

## Dependencies

### External Libraries
- **Boost**: shared_ptr, function, bind, signals for modern C++ patterns
- **Apache Portable Runtime (APR)**: Threading, file I/O, and system abstraction
- **PCRE**: Regular expression engine for pattern matching and validation
- **OpenSSL**: MD5, SHA hashing, and cryptographically secure random numbers

### Internal Dependencies
- **None**: This is the foundational layer with no dependencies on other llcommon modules
- **Self-contained**: All functionality implemented within this subsystem
- **Minimal external coupling**: Only depends on standard C++ library and selected external libraries

### Platform Dependencies
- **Windows**: Native Win32 APIs for threading, file handling, and system information
- **macOS**: Objective-C runtime and Cocoa frameworks for system integration  
- **Linux**: POSIX APIs for threading, file operations, and system calls

## Known Issues / TODOs

### Design Weaknesses
- **Singleton overuse**: Heavy reliance on singleton pattern reduces testability and modularity
- **Global state**: Extensive use of global variables complicates reasoning about state
- **Platform abstraction inconsistency**: Some platform-specific code leaks into higher layers
- **Memory pool limitations**: Fixed-size pools may not adapt well to varying usage patterns

### Performance Issues
- **Reference counting overhead**: Atomic operations for thread safety impact performance
- **String allocation patterns**: Frequent temporary string creation causes memory pressure
- **Event system bottlenecks**: Single event pump can become contention point
- **Lock granularity**: Some mutexes protect larger critical sections than necessary

### Threading Issues
- **Deadlock potential**: Complex lock ordering requirements not always clearly documented
- **Race conditions**: Some singleton initialization patterns have threading vulnerabilities
- **Scalability limits**: Fixed thread pool sizes may not scale well on many-core systems

### Future Improvements
- **Modern C++ adoption**: Move to std::shared_ptr, std::thread, and other standard features
- **Memory allocator improvements**: Custom allocators for specific usage patterns
- **Event system optimization**: Lock-free event queues for better performance
- **Platform modernization**: Remove dependencies on legacy APIs where possible

### Code Quality TODOs
- **Documentation**: Many internal interfaces lack comprehensive documentation
- **Test coverage**: Some edge cases and error paths need additional test coverage
- **Code duplication**: Similar patterns implemented multiple times could be consolidated
- **API consistency**: Some interfaces use inconsistent naming and parameter conventions

*Note: This subsystem is foundational to the entire viewer and changes require careful consideration of impact on all dependent systems.*