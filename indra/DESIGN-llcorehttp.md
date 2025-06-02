# LLCoreHTTP Subsystem Design

## Purpose

The `llcorehttp/` subsystem provides a high-performance, thread-safe HTTP client implementation for the Second Life Viewer. It solves the problem of reliable, efficient web service communication by offering asynchronous HTTP operations with automatic retry, connection pooling, bandwidth throttling, and comprehensive error handling. This subsystem enables the viewer to interact with Second Life's web services, asset servers, marketplace, and other HTTP-based APIs while maintaining responsive user experience through non-blocking operations.

## Key Concepts

- **Asynchronous Operations**: Non-blocking HTTP requests that don't interrupt the main application thread
- **Policy Classes**: Configurable behavior sets for different types of HTTP operations (assets, textures, web services)
- **Priority Queuing**: Request prioritization ensuring critical operations complete first
- **Connection Pooling**: Efficient reuse of HTTP connections reducing setup overhead
- **Automatic Retry**: Intelligent retry logic with exponential backoff for failed requests
- **Thread Safety**: Multi-threaded design allowing concurrent operations from different subsystems
- **Bandwidth Management**: Global and per-class bandwidth throttling preventing network saturation
- **Handler Callbacks**: Event-driven completion notifications with success/failure status
- **Reference Counting**: Automatic memory management for request and response objects

## Main Components

### Core HTTP Service
- **`httpcommon.cpp/.h`** - Common definitions, constants, and shared utilities
- **`httprequest.cpp/.h`** - Main public interface for submitting HTTP requests
- **`httpresponse.cpp/.h`** - HTTP response representation with status and content access
- **`httphandler.h`** - Abstract handler interface for request completion callbacks
- **`httpheaders.cpp/.h`** - HTTP header management with case-insensitive operations
- **`httpoptions.cpp/.h`** - Request configuration options (timeouts, retries, SSL settings)

### Internal Service Implementation
- **`_httpservice.cpp/.h`** - Core service implementation managing worker thread and request processing
- **`_httpoperation.cpp/.h`** - Base class for HTTP operations with state management
- **`_httpoprequest.cpp/.h`** - Concrete HTTP request operation implementation
- **`_httpopcancel.cpp/.h`** - Request cancellation operation
- **`_httpopsetget.cpp/.h`** - Policy configuration operations
- **`_httpopsetpriority.cpp/.h`** - Request priority modification operations

### Request Management
- **`_httprequestqueue.cpp/.h`** - Priority queue for pending HTTP requests
- **`_httpreplyqueue.cpp/.h`** - Queue for completed requests awaiting handler notification
- **`_httpreadyqueue.h`** - Queue template for thread-safe operation queueing
- **`_httpretryqueue.h`** - Queue for requests awaiting retry after failure

### Policy and Configuration
- **`_httppolicy.cpp/.h`** - HTTP policy management and enforcement
- **`_httppolicyclass.cpp/.h`** - Individual policy class configuration and behavior
- **`_httppolicyglobal.cpp/.h`** - Global policy settings affecting all operations

### libcurl Integration
- **`_httplibcurl.cpp/.h`** - libcurl wrapper providing low-level HTTP implementation
- **`_httpinternal.h`** - Internal definitions and implementation details

### Threading and Synchronization
- **`_thread.h`** - Thread abstraction for HTTP worker thread
- **`_mutex.h`** - Mutex abstraction for thread synchronization
- **`_refcounted.cpp/.h`** - Reference counting base class for automatic memory management

### Data Handling
- **`bufferarray.cpp/.h`** - Efficient buffer management for request and response data
- **`bufferstream.cpp/.h`** - Stream interface for buffer array operations

### Statistics and Monitoring
- **`httpstats.cpp/.h`** - Performance metrics and statistics collection

### Constants and Utilities
- **`llhttpconstants.cpp/.h`** - HTTP status codes and common constants

## How It Works

### Request Lifecycle
1. **Request Creation**: Application creates HTTP request with URL, method, and options
2. **Handler Registration**: Completion handler registered for asynchronous notification
3. **Queue Submission**: Request submitted to appropriate policy class queue
4. **Priority Processing**: Requests processed in priority order within policy constraints
5. **libcurl Execution**: Request executed using libcurl on background worker thread
6. **Response Processing**: Response data collected and status codes interpreted
7. **Handler Notification**: Completion handler called on main thread with results
8. **Resource Cleanup**: Request and response objects automatically cleaned up via reference counting

### Policy Management
1. **Policy Class Definition**: Different operation types assigned to policy classes (assets, textures, web)
2. **Resource Allocation**: Each policy class gets dedicated connection pool and bandwidth allocation
3. **Concurrency Control**: Maximum concurrent requests enforced per policy class
4. **Priority Enforcement**: High-priority requests processed before lower-priority ones
5. **Throttling Application**: Bandwidth limits enforced preventing network saturation

### Threading Model
1. **Main Thread**: Application submits requests and receives completion notifications
2. **Worker Thread**: Single background thread executes all HTTP operations
3. **Queue Synchronization**: Thread-safe queues facilitate communication between threads
4. **Event Notification**: Completion events posted back to main thread for handler execution
5. **Graceful Shutdown**: Worker thread cleanly terminates during application shutdown

### Error Handling and Retry
1. **Error Detection**: Network errors, timeouts, and HTTP status codes analyzed
2. **Retry Decision**: Retry policy determines if operation should be attempted again
3. **Backoff Calculation**: Exponential backoff applied to prevent server overload
4. **Queue Management**: Failed requests moved to retry queue for later processing
5. **Final Failure**: After maximum retries, failure reported to application handler

## Interfaces and Integration

### Public APIs
- **HttpRequest interface**: Submit HTTP GET, POST, PUT, DELETE operations
- **HttpHandler callbacks**: Receive completion notifications with success/failure status
- **HttpOptions configuration**: Timeout, retry, SSL, and other request parameters
- **HttpResponse access**: Response status, headers, and body content retrieval

### Data Formats Consumed
- **URLs**: HTTP and HTTPS URLs for various Second Life services
- **Request bodies**: JSON, XML, binary data for POST/PUT operations
- **SSL certificates**: Client certificates for authenticated operations
- **Configuration**: Policy settings and global HTTP parameters

### Data Formats Produced
- **HTTP responses**: Status codes, headers, and response body content
- **Error information**: Detailed error codes and diagnostic messages
- **Performance metrics**: Request timing, bandwidth usage, and success rates
- **Log entries**: Request/response logging for debugging and monitoring

### Integration Points
- **Asset downloads**: Large texture and mesh file downloads with resume capability
- **Web services**: API calls to Second Life services (marketplace, profiles, etc.)
- **Authentication**: Login and capability URL retrieval
- **Crash reporting**: Error log uploads for debugging support

## Configuration

### Policy Classes
- **Asset downloads**: High bandwidth, multiple connections, long timeouts for large files
- **Texture downloads**: Medium bandwidth, moderate connections, optimized for UI responsiveness
- **Web services**: Low bandwidth, few connections, fast timeouts for API responsiveness
- **Default class**: Fallback configuration for uncategorized requests

### Global Settings
- **`HttpConnectionLimit`**: Maximum total concurrent HTTP connections
- **`HttpRequestQueueSize`**: Maximum queued requests before blocking
- **`HttpTimeoutConnect`**: Connection establishment timeout
- **`HttpTimeoutRequest`**: Individual request timeout

### Performance Tuning
- **`HttpBandwidthThrottle`**: Global bandwidth limit in bytes per second
- **`HttpRetryCount`**: Maximum retry attempts for failed requests
- **`HttpPipelineLength`**: HTTP pipeline depth for improved efficiency
- **`HttpConnectionPool`**: Connection pool size per host

### SSL Configuration
- **Certificate verification**: Enable/disable SSL certificate validation
- **Client certificates**: Configuration for client-side SSL authentication
- **SSL protocol versions**: Allowed SSL/TLS protocol versions
- **Cipher suites**: Cryptographic algorithm preferences

## Testing

### Test Locations
- **`tests/`** subdirectory: Comprehensive unit tests for HTTP functionality
- **Mock services**: Local HTTP servers for testing various scenarios
- **Integration tests**: End-to-end testing with real web services

### Testing Strategy
- **Unit tests**: Individual component validation with mock HTTP responses
- **Integration tests**: Full request/response cycles with test servers
- **Load testing**: High-volume request testing to validate concurrency and performance
- **Error simulation**: Network failure simulation and error handling validation
- **Threading tests**: Multi-threaded safety and synchronization verification

### Coverage Areas
- **Request submission**: Various HTTP methods, headers, and body content
- **Response processing**: Status codes, headers, and content extraction
- **Error handling**: Network failures, timeouts, and HTTP error responses
- **Policy enforcement**: Bandwidth throttling and connection limiting
- **Memory management**: Reference counting and leak detection

### Known Testing Limitations
- **Network dependency**: Many tests require actual network connectivity
- **Timing sensitivity**: Multi-threaded behavior has inherent timing dependencies
- **External services**: Testing depends on availability of external web services
- **Platform differences**: Network behavior varies across operating systems

## Performance and Constraints

### Performance Characteristics
- **Asynchronous operation**: Non-blocking requests maintaining UI responsiveness
- **Connection reuse**: HTTP Keep-Alive reduces connection overhead
- **Pipeline support**: HTTP pipelining improves throughput for sequential requests
- **Bandwidth efficiency**: Compression and efficient data transfer protocols

### Network Constraints
- **Bandwidth limitations**: Global and per-class throttling prevents network saturation
- **Connection limits**: Maximum concurrent connections prevent resource exhaustion
- **Timeout handling**: Configurable timeouts prevent indefinite blocking
- **Proxy support**: SOCKS and HTTP proxy compatibility for restricted networks

### Memory Constraints
- **Buffer management**: Efficient memory allocation for request/response data
- **Connection pooling**: Bounded connection pools prevent memory growth
- **Queue limits**: Request queue size limits prevent unbounded memory usage
- **Reference counting**: Automatic cleanup prevents memory leaks

### Time Complexity
- **Request submission**: O(1) for queue insertion with priority ordering
- **Policy enforcement**: O(1) for resource limit checking
- **Connection reuse**: O(1) for connection pool lookup
- **Handler notification**: O(1) for callback execution

## Dependencies

### External Libraries
- **libcurl**: Multi-protocol file transfer library providing HTTP implementation
- **OpenSSL**: Cryptographic library for HTTPS and SSL certificate handling
- **c-ares**: Asynchronous DNS resolver for improved connection performance

### Internal Module Dependencies
- **llcommon**: Threading primitives, memory management, and utilities (critical dependency)
- **llmath**: Minimal dependency for statistical calculations

### Platform Dependencies
- **Network stack**: Platform-specific networking APIs and socket implementations
- **SSL libraries**: System or bundled SSL/TLS implementation
- **Threading**: Platform threading primitives for worker thread management

## Known Issues / TODOs

### Design Weaknesses
- **Single worker thread**: All HTTP operations share one background thread potentially creating bottlenecks
- **Policy complexity**: Multiple policy classes add configuration complexity
- **Error code mapping**: Inconsistent mapping between libcurl and application error codes
- **Memory allocation**: Some temporary allocations could be optimized with pooling

### Performance Issues
- **Thread contention**: Single worker thread can become bottleneck for high-volume operations
- **Connection pool overhead**: Connection pool management adds some processing overhead
- **Large response handling**: Very large responses may cause memory pressure
- **Queue processing**: Priority queue operations have logarithmic complexity

### Reliability Issues
- **Network failure recovery**: Some edge cases in network failure recovery need improvement
- **SSL certificate handling**: Certificate validation errors sometimes poorly reported
- **Proxy detection**: Automatic proxy detection doesn't work reliably on all platforms
- **Resource cleanup**: Rare cases of incomplete resource cleanup under error conditions

### Future Improvements
- **HTTP/2 support**: Modern HTTP protocol for improved performance and efficiency
- **Multiple worker threads**: Thread pool for better concurrency and performance
- **Streaming responses**: Support for streaming large responses without full buffering
- **WebSocket support**: Real-time bidirectional communication capabilities
- **Connection pooling improvements**: More sophisticated connection management algorithms

### Code Quality Issues
- **Documentation gaps**: Some internal interfaces lack comprehensive documentation
- **Error handling inconsistency**: Different error handling patterns across components
- **Test coverage**: Some edge cases and error paths need additional test coverage
- **API evolution**: Legacy compatibility requirements complicate interface improvements

*Note: HTTP communication is critical for viewer functionality and changes should be carefully tested to ensure compatibility with Second Life's web service infrastructure.*