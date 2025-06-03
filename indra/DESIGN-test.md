# Test Subsystem Design

## Purpose

The `test/` subsystem provides comprehensive testing infrastructure for the Second Life Viewer. It serves as the centralized testing framework that enables unit testing, integration testing, and validation of all major viewer components. This subsystem ensures code quality, prevents regressions, and validates that all components work correctly in isolation and when integrated together.

## Key Concepts

- **TUT Framework**: Template Unit Test framework providing structured test case organization
- **Mock Objects**: Simulated components for testing in isolation without dependencies
- **Test Harness**: Unified test execution and reporting infrastructure
- **Integration Testing**: Cross-component testing to validate system interactions
- **Regression Testing**: Automated validation to prevent reintroduction of bugs
- **Performance Testing**: Measurement and validation of timing and resource usage
- **Error Injection**: Controlled failure scenarios to test error handling paths
- **Test Utilities**: Common helpers and fixtures for test case implementation

## Main Components

### Core Testing Framework
- **`lltut.cpp/.h`** - TUT (Template Unit Test) framework integration and customization
- **`test.cpp/.h`** - Main test application entry point and test runner
- **`lltestapp.h`** - Base test application class providing test environment setup

### Test Utilities and Helpers
- **`io.cpp`** - I/O testing utilities for file and stream operations
- **`llpipeutil.cpp/.h`** - Pipeline testing utilities for data flow validation
- **`debug.h`** - Debugging utilities specific to test environments
- **`sync.h`** - Synchronization primitives for multi-threaded test scenarios
- **`print.h`** - Enhanced printing utilities for test output and debugging

### Mock and Simulation Components
- **`mock_http_client.cpp/.h`** - HTTP client simulation for network testing
- **`namedtempfile.h`** - Temporary file creation and management for test isolation
- **`setenv.h`** - Environment variable manipulation for test configuration
- **`hexdump.h`** - Binary data inspection utilities for debugging test failures

### Component-Specific Test Suites

#### Core Component Tests
- **`llapp_tut.cpp`** - Application lifecycle and initialization testing
- **`llsd_new_tut.cpp`** - LLSD data structure validation and serialization tests
- **`llsdutil_tut.cpp`** - LLSD utility function testing
- **`llevents_tut.cpp`** - Event system and messaging framework tests

#### Data and Communication Tests
- **`llbuffer_tut.cpp`** - Buffer management and data handling tests
- **`lldatapacker_tut.cpp`** - Data packing and serialization validation
- **`llstreamtools_tut.cpp`** - Stream processing and manipulation tests
- **`lltranscode_tut.cpp`** - Character encoding and transcoding tests

#### Network and Messaging Tests
- **`llmessageconfig_tut.cpp`** - Message system configuration testing
- **`llmessagetemplateparser_tut.cpp`** - Message template parsing validation
- **`llsdmessagebuilder_tut.cpp`** - LLSD message construction tests
- **`llsdmessagereader_tut.cpp`** - LLSD message parsing and reading tests
- **`lltemplatemessagebuilder_tut.cpp`** - Template-based message building tests
- **`message_tut.cpp`** - General messaging system tests

#### HTTP and Network Tests
- **`llhttpdate_tut.cpp`** - HTTP date parsing and formatting tests
- **`llhttpnode_tut.cpp`** - HTTP node and routing functionality tests
- **`lliohttpserver_tut.cpp`** - HTTP server component testing

#### Security and Cryptography Tests
- **`llblowfish_tut.cpp`** - Blowfish encryption algorithm testing
- **`llxorcipher_tut.cpp`** - XOR cipher implementation validation

#### Business Logic Tests
- **`llpermissions_tut.cpp`** - Asset permission system testing
- **`llsaleinfo_tut.cpp`** - Virtual economy and sales transaction tests
- **`lluserrelations_tut.cpp`** - User relationship and social system tests
- **`prim_linkability_tut.cpp`** - 3D object linking and attachment tests

#### Utility and Service Tests
- **`llservicebuilder_tut.cpp`** - Service construction and dependency injection tests
- **`lltimestampcache_tut.cpp`** - Timestamp caching and validation tests
- **`lldoubledispatch_tut.cpp`** - Double dispatch pattern implementation tests

### Supporting Test Data
- **`blowfish.1.bin`** - Binary test data for cryptographic function validation
- **`blowfish.2.bin`** - Additional binary test vectors for encryption testing
- **`blowfish.digits.txt`** - Text-based test data for algorithm verification
- **`blowfish.pl`** - Perl script for generating and validating test vectors

## How It Works

### Test Execution Flow
1. **Test Discovery**: Automatic registration of test cases through TUT framework macros
2. **Environment Setup**: Initialization of test environment and mock objects
3. **Test Case Execution**: Sequential execution of individual test methods
4. **Result Collection**: Aggregation of pass/fail results and performance metrics
5. **Cleanup**: Teardown of test fixtures and cleanup of temporary resources
6. **Reporting**: Generation of test reports and failure diagnostics

### Test Organization
Tests are organized by component and functionality, with each test file focusing on a specific subsystem or feature. The TUT framework provides automatic test registration and execution through template-based test case definitions.

### Mock and Simulation Strategy
Mock objects simulate external dependencies to enable isolated testing of individual components. This approach allows testing of network protocols, file I/O, and other external interactions without requiring actual external resources.

## Interfaces and Integration

### Public APIs
- **Test Registration**: Macros for registering test cases and suites
- **Assertion Framework**: Comprehensive assertion macros for validation
- **Mock Interfaces**: Standardized mock object interfaces for common components
- **Test Utilities**: Helper functions for common testing scenarios

### Integration Points
- **Build System**: Integration with CMake for automated test execution
- **Continuous Integration**: Support for automated testing in CI/CD pipelines
- **Component Testing**: Direct integration with all viewer subsystems
- **Performance Monitoring**: Integration with timing and profiling systems

### Test Data Formats
- **Binary Test Vectors**: Raw binary data for cryptographic and encoding tests
- **Configuration Files**: Test-specific configuration for component testing
- **Mock Data**: Simulated network responses and file system data

## Configuration

### Test Environment Variables
- **Test output verbosity and formatting options**
- **Mock service configuration and behavior**
- **Test data file locations and paths**
- **Performance testing thresholds and limits**

### Test Configuration Files
- **Component-specific test configurations**
- **Mock service behavior specifications**
- **Test data set definitions and locations**

## Testing

### Test Locations
- **Unit Tests**: All `*_tut.cpp` files in the test directory
- **Integration Tests**: Cross-component tests in `../integration_tests/`
- **Performance Tests**: Timing and resource usage validation tests

### Testing Strategy
- **Unit Testing**: Isolated testing of individual functions and classes
- **Integration Testing**: Component interaction and data flow validation
- **Regression Testing**: Automated validation of bug fixes and stability
- **Performance Testing**: Timing and resource usage benchmarking
- **Mock Testing**: Validation of mock object behavior and interfaces

### Coverage Areas
- **Core Infrastructure**: Application lifecycle, data structures, utilities
- **Network Communication**: Message processing, HTTP operations, protocols
- **Data Processing**: Serialization, encryption, encoding operations
- **Business Logic**: Permissions, economics, user interactions
- **Error Handling**: Exception paths and error recovery mechanisms

### Known Testing Limitations
- **Platform Dependencies**: Some tests may behave differently across operating systems
- **Timing Sensitivity**: Performance tests may be affected by system load
- **External Dependencies**: Network tests require careful mock configuration
- **Complex Interactions**: Some multi-threaded scenarios are difficult to test reliably

## Performance and Constraints

### Performance Considerations
- **Test Execution Time**: Balance between thorough testing and build time constraints
- **Memory Usage**: Efficient cleanup of test fixtures and temporary data
- **Parallel Execution**: Thread safety considerations for concurrent test execution
- **Resource Cleanup**: Proper disposal of temporary files and mock resources

### Resource Constraints
- **Temporary File Space**: Disk space requirements for test data and outputs
- **Memory Allocation**: Memory usage patterns during test execution
- **Network Resources**: Mock service resource requirements
- **Processing Time**: CPU usage for cryptographic and performance tests

## Dependencies

### External Libraries
- **TUT Framework**: Template Unit Test library for test organization
- **Standard Library**: C++ standard library for basic test utilities
- **Platform APIs**: Operating system APIs for file and process management

### Internal Dependencies
- **All Viewer Components**: Tests depend on the components they validate
- **Common Utilities**: Shared utilities from llcommon for basic operations
- **Mock Infrastructure**: Internal mock objects and simulation components

## Known Issues / TODOs

### Design Weaknesses
- **Test Organization**: Some test files contain mixed functionality that could be better separated
- **Mock Consistency**: Mock object interfaces could be more standardized across components
- **Test Data Management**: Test data files could be better organized and documented
- **Cross-Platform Testing**: Some tests have platform-specific behavior that complicates maintenance

### Performance Issues
- **Test Execution Time**: Some tests take longer than optimal for development workflow
- **Resource Usage**: Memory and disk usage could be optimized for large test runs
- **Parallel Execution**: Limited support for parallel test execution

### Coverage Gaps
- **UI Component Testing**: Limited automated testing of user interface components
- **Graphics Testing**: Rendering and graphics functionality difficult to test automatically
- **Integration Scenarios**: Some complex multi-component interactions lack comprehensive tests
- **Error Recovery**: Error handling paths could use more thorough testing

### Future Improvements
- **Modern Testing Framework**: Consider migration to more modern C++ testing frameworks
- **Automated Test Generation**: Tools for automatically generating test cases from interfaces
- **Performance Benchmarking**: Better integration with performance monitoring tools
- **Test Data Generation**: Automated generation of test data sets
- **Cross-Platform Validation**: Better support for testing platform-specific behavior

### Code Quality Issues
- **Documentation**: Test cases could benefit from better inline documentation
- **Test Naming**: Some test names could be more descriptive of their purpose
- **Code Duplication**: Common test patterns could be extracted into reusable utilities
- **Legacy Tests**: Some older tests could be modernized to use current best practices

*Note: The test subsystem is critical for maintaining code quality and preventing regressions. Changes should be carefully reviewed to ensure they don't compromise the testing infrastructure.*