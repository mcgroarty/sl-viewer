# LLMessage Subsystem Design

## Purpose

The `llmessage/` subsystem provides comprehensive network communication infrastructure for the Second Life Viewer. It solves the problem of reliable, efficient communication between the viewer and Second Life's distributed server infrastructure, including simulators, asset servers, and web services. This subsystem handles real-time virtual world updates, asset transfers, instant messaging, and service integration while abstracting the complexities of network protocols, data serialization, and connection management.

## Key Concepts

- **Circuit Management**: Persistent UDP connections to simulators with heartbeat and reliability layers
- **Message Templates**: XML-defined message formats ensuring protocol compatibility across client/server versions
- **Reliable UDP**: Custom reliability layer providing guaranteed delivery over inherently unreliable UDP
- **Capability URLs**: Dynamic service endpoints for secure, capability-based access to server resources
- **Asset Transfer System**: Optimized large file transfer with resumption and integrity verification
- **Instant Messaging**: Real-time person-to-person and group communication infrastructure
- **Throttling**: Bandwidth management preventing network congestion and ensuring fair usage
- **Data Serialization**: Efficient binary and LLSD formats for network data transmission
- **Service Discovery**: Dynamic discovery and connection to appropriate server endpoints

## Main Components

### Core Messaging Infrastructure
- **`message.cpp/.h`** - Central message system providing template-based message construction and parsing
- **`llmessagebuilder.cpp/.h`** - Abstract interface for constructing outbound messages
- **`llmessagereader.cpp/.h`** - Abstract interface for parsing inbound messages
- **`llmessagetemplate.cpp/.h`** - Message format definitions and validation rules
- **`llmessagetemplateparser.cpp/.h`** - XML parser for message template files

### Template-based Messaging
- **`lltemplatemessagebuilder.cpp/.h`** - Concrete builder for binary message format
- **`lltemplatemessagereader.cpp/.h`** - Concrete reader for binary message format
- **`lltemplatemessagedispatcher.cpp/.h`** - Message routing to registered handlers

### LLSD Messaging (Modern Format)
- **`llsdmessagebuilder.cpp/.h`** - Builder for LLSD-based message format
- **`llsdmessagereader.cpp/.h`** - Reader for LLSD-based message format
- **`llsdhttpserver.cpp/.h`** - HTTP server for LLSD-based service endpoints

### Network Layer
- **`llcircuit.cpp/.h`** - UDP circuit management with connection state and reliability
- **`llhost.cpp/.h`** - Network endpoint representation with address and port management
- **`net.cpp/.h`** - Low-level network utilities and socket management
- **`llproxy.cpp/.h`** - SOCKS proxy support for network connectivity

### Asset and Transfer Management
- **`llassetstorage.cpp/.h`** - Asset download and upload coordination
- **`lltransfermanager.cpp/.h`** - Large file transfer with chunking and resume capability
- **`llxfermanager.cpp/.h`** - Legacy transfer system for specific file types
- **`llxfer*.cpp/.h`** - Various transfer source and target implementations

### Caching and Name Services
- **`llcachename.cpp/.h`** - Agent and group name caching with automatic updates
- **`llavatarnamecache.cpp/.h`** - Display name and username caching system
- **`llexperiencecache.cpp/.h`** - Scripted experience information caching

### I/O and Streaming
- **`lliopipe.cpp/.h`** - Asynchronous I/O pipeline framework
- **`llpumpio.cpp/.h`** - Event-driven I/O pump for network operations
- **`lliobuffer.cpp/.h`** - Buffered I/O operations with automatic memory management
- **`lliosocket.cpp/.h`** - Socket-based I/O operations within pipeline framework

### Throttling and Quality of Service
- **`llthrottle.cpp/.h`** - Bandwidth throttling for various message categories
- **`llmessagethrottle.cpp/.h`** - Message-specific throttling and prioritization
- **`llpacketring.cpp/.h`** - Packet queueing and reliability management

### Utility and Support
- **`lldatapacker.cpp/.h`** - Efficient binary data serialization utilities
- **`llbuffer.cpp/.h`** - Memory buffer management for network operations
- **`llinstantmessage.cpp/.h`** - Instant message data structures and utilities

## How It Works

### Message Lifecycle
1. **Message Construction**: Application creates message using template-based builder
2. **Serialization**: Message data serialized to binary or LLSD format
3. **Transmission**: Message sent over appropriate transport (UDP circuit or HTTP)
4. **Receipt**: Remote endpoint receives and validates message format
5. **Deserialization**: Message data extracted using corresponding reader
6. **Dispatch**: Message routed to appropriate handler based on type
7. **Processing**: Application logic processes message content and responds

### Circuit Management
1. **Connection Establishment**: Initial handshake with simulator establishing circuit
2. **Heartbeat Maintenance**: Regular ping/pong messages maintaining connection liveness
3. **Reliability Layer**: Packet acknowledgment and retransmission for guaranteed delivery
4. **Flow Control**: Bandwidth monitoring and throttling preventing network congestion
5. **Graceful Shutdown**: Proper connection termination with resource cleanup

### Asset Transfer Flow
1. **Request Initiation**: Asset requested by UUID with priority and transfer parameters
2. **Capability Resolution**: Appropriate download URL resolved through capability system
3. **Transfer Setup**: Connection established with transfer service endpoint
4. **Chunked Download**: Large assets downloaded in manageable chunks with progress tracking
5. **Integrity Verification**: Downloaded data validated against expected hash
6. **Caching**: Successfully downloaded assets stored in local cache for reuse
7. **Notification**: Completion or failure notification sent to requesting component

### Message Template Processing
1. **Template Loading**: XML message templates loaded and parsed at startup
2. **Format Validation**: Message structure validated against template definitions
3. **Version Compatibility**: Template versions checked for client/server compatibility
4. **Runtime Binding**: Message handlers registered for specific message types
5. **Dynamic Dispatch**: Incoming messages routed to appropriate handlers automatically

## Interfaces and Integration

### Public APIs
- **Message construction**: LLMessageSystem for sending templated messages
- **Message handling**: Registration of callbacks for specific message types
- **Asset requests**: LLAssetStorage for downloading and uploading assets
- **Transfer management**: LLTransferManager for large file operations
- **Circuit management**: Connection state monitoring and control

### Data Formats Consumed
- **Message templates**: XML definitions of message structure and validation rules
- **Capability URLs**: JSON service endpoint specifications
- **Asset metadata**: UUID, type, size, and hash information for downloads
- **Configuration files**: Network settings and connection parameters

### Data Formats Produced
- **Binary messages**: Efficient template-based message format for UDP communication
- **LLSD messages**: Structured data format for HTTP and modern services
- **Transfer protocols**: Chunked data with integrity verification and progress reporting
- **Log data**: Network activity and performance metrics for debugging

### Service Endpoints
- **Simulator circuits**: UDP connections to virtual world simulators
- **Asset services**: HTTP endpoints for asset download and upload
- **Capability services**: Dynamic HTTP services for various viewer functions
- **Web services**: Integration with marketplace, profiles, and other web features

## Configuration

### Network Settings
- **`BandwidthLimit`**: Maximum bandwidth usage for downloads and uploads
- **`ThrottleSettings`**: Per-category bandwidth allocation for different message types
- **`ConnectionTimeout`**: Timeout values for various network operations
- **`MaxConcurrentTransfers`**: Limits on simultaneous asset downloads

### Circuit Configuration
- **`HeartbeatInterval`**: Frequency of keep-alive messages to simulators
- **`RetransmissionDelay`**: Timing for reliable message retransmission
- **`MaxPacketSize`**: Maximum UDP packet size for message transmission
- **`CircuitTimeout`**: Time before declaring circuit dead and attempting reconnection

### Asset Transfer Settings
- **`AssetCacheSize`**: Maximum size of local asset cache
- **`TransferChunkSize`**: Size of individual chunks for large file transfers
- **`MaxRetries`**: Maximum retry attempts for failed transfers
- **`ConcurrentDownloads`**: Number of simultaneous asset downloads

### Message Template Files
- **`message.xml`**: Core message template definitions for UDP communication
- **`template_verifier.xml`**: Template validation rules and version compatibility

## Testing

### Test Locations
- **`tests/`** subdirectory: Unit tests for message parsing, serialization, and network utilities
- **Integration tests**: End-to-end testing of message flows and service integration
- **Network simulation**: Testing under various network conditions and failure scenarios

### Testing Strategy
- **Message format tests**: Validation of serialization/deserialization round-trips
- **Protocol compliance**: Verification of message template adherence and version compatibility
- **Network resilience**: Testing behavior under packet loss, latency, and connectivity issues
- **Performance tests**: Bandwidth utilization and throughput optimization validation
- **Security tests**: Message validation and sanitization verification

### Coverage Areas
- **Template parsing**: XML message template loading and validation
- **Message building**: Construction of various message types with correct formatting
- **Circuit management**: Connection establishment, maintenance, and failure recovery
- **Asset transfers**: Large file download/upload with integrity verification
- **Throttling**: Bandwidth management and quality of service enforcement

### Known Testing Limitations
- **Live network dependencies**: Full testing requires connection to actual Second Life services
- **Timing-sensitive behavior**: Real-time aspects difficult to test deterministically
- **Scale testing**: Limited ability to test high-volume message scenarios
- **Security validation**: Complete security testing requires production-like environments

## Performance and Constraints

### Performance Characteristics
- **Message throughput**: Optimized for high-volume message processing with minimal latency
- **Bandwidth efficiency**: Compression and efficient serialization minimizing network usage
- **Connection management**: Persistent connections reducing overhead of repeated handshakes
- **Caching effectiveness**: Intelligent caching reducing redundant network requests

### Network Constraints
- **Bandwidth limitations**: Adaptive behavior based on available network capacity
- **Latency sensitivity**: Real-time requirements for virtual world interaction
- **Packet loss tolerance**: Reliable delivery mechanisms handling unreliable networks
- **Firewall compatibility**: NAT traversal and proxy support for restricted networks

### Memory Constraints
- **Buffer management**: Careful allocation and cleanup of network buffers
- **Cache sizing**: Bounded caches preventing unbounded memory growth
- **Connection overhead**: Per-circuit memory usage must remain reasonable
- **Message queuing**: Bounded queues preventing memory exhaustion under load

### Time Complexity
- **Message dispatch**: O(1) for registered message handlers with hash table lookup
- **Template lookup**: O(1) for message template access with pre-computed indexes
- **Circuit management**: O(n) where n is number of active circuits
- **Asset transfers**: O(1) per chunk with parallel download streams

## Dependencies

### External Libraries
- **OpenSSL**: Cryptographic functions for secure communications and integrity verification
- **libcurl**: HTTP client functionality for web service integration
- **APR (Apache Portable Runtime)**: Network socket abstraction and threading primitives
- **Boost**: Utility libraries for smart pointers and data structures

### Internal Module Dependencies
- **llcommon**: Core utilities, threading, and data structures (critical dependency)
- **llmath**: Mathematical operations for networking calculations and transformations
- **llxml**: XML parsing for message templates and configuration files
- **llimage**: Image format handling for texture asset transfers

### Platform Dependencies
- **Socket APIs**: Platform-specific network programming interfaces
- **Threading libraries**: Multi-threaded network I/O and background processing
- **System networking**: Platform network configuration and proxy detection

## Known Issues / TODOs

### Design Weaknesses
- **Legacy protocol support**: Maintaining compatibility with older message formats adds complexity
- **Global message system**: Single LLMessageSystem instance creates coupling and testing challenges
- **Mixed protocols**: Dual support for UDP templates and HTTP LLSD increases maintenance burden
- **Error handling inconsistency**: Different error handling patterns across various subsystems

### Performance Issues
- **Template lookup overhead**: Message template resolution can impact high-frequency operations
- **Memory allocation patterns**: Frequent buffer allocation/deallocation causes fragmentation
- **Circuit overhead**: Per-simulator connection state requires significant memory
- **Serialization costs**: Binary format conversion overhead for complex data structures

### Reliability Issues
- **Network failure recovery**: Some failure scenarios don't gracefully recover connections
- **Message ordering**: Limited ordering guarantees for certain message categories
- **Circuit detection**: Slow detection of dead circuits can impact user experience
- **Asset corruption**: Rare cases of asset corruption during transfer not fully addressed

### Security Considerations
- **Message validation**: Insufficient validation of incoming messages could allow attacks
- **Capability security**: Capability URL leakage could enable unauthorized access
- **Encryption gaps**: Some communications lack end-to-end encryption
- **Rate limiting**: Inadequate protection against message flooding attacks

### Future Improvements
- **Protocol modernization**: Migration to modern protocols (WebSocket, HTTP/2) for improved efficiency
- **Async/await patterns**: Modernize callback-based code with coroutine support
- **Connection pooling**: Better reuse of connections for HTTP-based services
- **Message compression**: Improved compression algorithms for bandwidth optimization
- **IPv6 support**: Full support for IPv6 networking infrastructure

### Code Quality Issues
- **Documentation gaps**: Many internal protocols lack comprehensive documentation
- **Test coverage**: Complex network interactions have limited automated test coverage
- **Code duplication**: Similar patterns repeated across different message types
- **Legacy compatibility**: Old code paths complicate maintenance and modernization

*Note: Network communication is critical to viewer functionality and changes must be carefully coordinated with server-side infrastructure to maintain compatibility.*