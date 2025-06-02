# LLUI Subsystem Design

## Purpose

The `llui/` subsystem provides a comprehensive user interface framework for the Second Life Viewer. It solves the problem of creating complex, interactive graphical interfaces that can handle the diverse needs of a virtual world client - from simple buttons and text fields to sophisticated floaters, inventory browsers, and chat systems. The subsystem enables developers to create consistent, accessible, and performant user interfaces using a widget-based architecture with XML-driven layout definitions.

## Key Concepts

- **Widget Hierarchy**: Tree-structured UI elements with parent-child relationships for layout and event propagation
- **XUI (XML UI)**: Declarative UI definition format separating layout from logic
- **Focus Management**: Keyboard and mouse focus handling with traversal order and accessibility
- **Event Propagation**: Input events bubble up and down the widget hierarchy for processing
- **View-Model Separation**: UI components separate from data representation for clean architecture
- **Layout Management**: Automatic sizing and positioning with constraints and relative positioning
- **Style System**: Consistent visual theming with color schemes and typography management
- **Localization Support**: Multi-language text rendering with Unicode and translation frameworks
- **Accessibility**: Support for screen readers and alternative input methods

## Main Components

### Core UI Framework
- **`llui.cpp/.h`** - Central UI manager and global state management
- **`llview.cpp/.h`** - Base class for all UI elements with rendering and event handling
- **`lluictrl.cpp/.h`** - Base control class with value management and validation
- **`llpanel.cpp/.h`** - Container widget for grouping and layout of child elements

### Widget Library
- **`llbutton.cpp/.h`** - Clickable button widgets with states and visual feedback
- **`lllineeditor.cpp/.h`** - Single-line text input with editing capabilities
- **`lltexteditor.cpp/.h`** - Multi-line text editing with rich formatting support
- **`llscrolllistctrl.cpp/.h`** - Scrollable list widget with sortable columns
- **`llcombobox.cpp/.h`** - Dropdown selection widget with autocomplete
- **`llsliderctrl.cpp/.h`** - Numerical input with visual slider interface
- **`llcheckboxctrl.cpp/.h`** - Boolean toggle with checkbox visual representation

### Layout and Container Systems
- **`lllayoutstack.cpp/.h`** - Flexible box layout container with automatic sizing
- **`lltabcontainer.cpp/.h`** - Tabbed interface container for organizing content
- **`llscrollcontainer.cpp/.h`** - Scrollable viewport for content larger than container
- **`llaccordionctrl.cpp/.h`** - Collapsible panel container for hierarchical content
- **`llfolderview.cpp/.h`** - Tree-view widget for hierarchical data display

### Advanced UI Components
- **`llfloater.cpp/.h`** - Moveable window container with title bar and controls
- **`llmenugl.cpp/.h`** - Context menus and menu bar implementation
- **`lltooltip.cpp/.h`** - Hover help and informational popup system
- **`llmodaldialog.cpp/.h`** - Modal dialog base class for blocking user interactions
- **`lltoolbar.cpp/.h`** - Customizable toolbar widget with button management

### Text and Rendering
- **`lltextbase.cpp/.h`** - Base text rendering with Unicode and style support
- **`lltextutil.cpp/.h`** - Text processing utilities for formatting and parsing
- **`llstyle.cpp/.h`** - Text styling system with colors, fonts, and effects
- **`lltrans.cpp/.h`** - Localization and translation management

### Input and Focus Management
- **`llfocusmgr.cpp/.h`** - Keyboard focus management and traversal
- **`llurlregistry.cpp/.h`** - URL detection and hyperlinking in text
- **`llspellcheck.cpp/.h`** - Spell checking integration for text inputs
- **`llclipboard.cpp/.h`** - System clipboard integration for copy/paste operations

### UI Factory and Parsing
- **`lluictrlfactory.cpp/.h`** - Widget creation from XML definitions
- **`llxuiparser.cpp/.h`** - XML parsing for UI layout files
- **`llviewereventrecorder.cpp/.h`** - UI event recording for testing and automation

## How It Works

### Widget Lifecycle
1. **Creation**: Widgets created via factory from XML or programmatically
2. **Initialization**: Properties set, child widgets created, layout calculated
3. **Hierarchy Building**: Widgets added to parent containers building UI tree
4. **Event Registration**: Input handlers and callbacks registered
5. **Layout Phase**: Size and position calculated based on constraints
6. **Rendering**: Draw cycle renders widget and child visual representation
7. **Event Processing**: User input events routed to appropriate widgets
8. **Cleanup**: Widgets destroyed in reverse order with proper resource cleanup

### Event Flow
1. **Input Capture**: Mouse/keyboard events captured by window system
2. **Hit Testing**: Determine which widget should receive the event based on position
3. **Event Routing**: Events sent to target widget with bubble/capture phases
4. **Handler Execution**: Widget-specific event handlers process the input
5. **Propagation Control**: Widgets can stop propagation or allow bubbling to parents
6. **State Updates**: Widget state changes reflected in visual appearance
7. **Notifications**: Change notifications sent to observers and data models

### Layout System
1. **Constraint Specification**: Widgets declare size and positioning requirements
2. **Hierarchy Traversal**: Layout engine walks widget tree calculating dimensions
3. **Size Negotiation**: Parent containers negotiate with children for space allocation
4. **Position Calculation**: Final positions computed based on layout policies
5. **Validation**: Layout validated and adjusted for minimum/maximum constraints
6. **Invalidation**: Changes trigger re-layout of affected widget subtrees

### XUI Processing
1. **File Loading**: XML files loaded from filesystem or embedded resources
2. **Parsing**: XML parsed into intermediate representation with validation
3. **Widget Creation**: Factory creates widgets based on XML element types
4. **Property Setting**: XML attributes mapped to widget properties
5. **Hierarchy Construction**: Parent-child relationships established from XML structure
6. **Post-processing**: Cross-references resolved and initialization completed

## Interfaces and Integration

### Public APIs
- **LLUICtrlFactory**: Widget creation from XML with template and parameter support
- **LLView hierarchy**: Base classes for creating custom widgets and containers
- **Event handling**: Mouse, keyboard, and focus event callback interfaces
- **Data binding**: Model-view connection for automatic UI updates
- **Layout constraints**: Flexible sizing and positioning system

### Data Formats Consumed
- **XUI files**: XML-based UI layout definitions with widget specifications
- **Localization files**: Multi-language string resources for UI text
- **Image assets**: UI textures, icons, and visual elements
- **Font files**: TrueType and OpenType fonts for text rendering
- **Color schemes**: Theme definitions for consistent visual styling

### Data Formats Produced
- **Event logs**: User interaction recording for testing and analytics
- **Layout metrics**: Performance data for UI responsiveness optimization
- **Accessibility data**: Screen reader compatible information and navigation hints

### Integration Points
- **llrender**: Low-level graphics rendering and OpenGL state management
- **llwindow**: Platform-specific window management and input handling
- **llcommon**: Base utilities, memory management, and event systems
- **newview**: Application-specific widgets and UI coordination

## Configuration

### XUI Configuration
- **Widget properties**: Size, position, color, font, and behavior settings
- **Layout parameters**: Anchoring, sizing policies, and constraint specifications
- **Event bindings**: Callback assignments and input method mappings
- **Resource references**: Image, font, and localization resource paths

### Runtime Settings
- **`UIScaleFactor`**: Global UI scaling for high-DPI displays
- **`UIAutoScale`**: Automatic UI scaling based on window size
- **`FontSizeAdjustment`**: Text size modification for accessibility
- **`ShowTooltips`**: Enable/disable hover help system
- **`DebugViews`**: Development mode showing widget boundaries and hierarchy

### Theme Configuration
- **Color definitions**: Named colors for consistent theming across widgets
- **Font specifications**: Font family, size, and style definitions
- **Image resources**: Texture paths for buttons, backgrounds, and decorations
- **Default values**: Fallback settings for undefined widget properties

## Testing

### Test Locations
- **`tests/`** subdirectory: Unit tests for core UI functionality and widgets
- **Manual testing**: Extensive user interaction testing for complex UI behaviors
- **Automated UI tests**: Scripted testing of widget interactions and state changes

### Testing Strategy
- **Widget unit tests**: Individual widget behavior validation with mock dependencies
- **Layout testing**: Constraint resolution and positioning verification
- **Event system tests**: Input routing and propagation validation
- **Accessibility testing**: Screen reader compatibility and keyboard navigation
- **Performance testing**: Rendering speed and memory usage optimization
- **Cross-platform testing**: UI consistency across Windows, macOS, and Linux

### Coverage Areas
- **Widget lifecycle**: Creation, initialization, layout, rendering, and cleanup
- **Event handling**: Mouse, keyboard, focus, and custom event processing
- **Layout algorithms**: Constraint solving and positioning calculations
- **XML parsing**: XUI file loading and widget factory operation
- **Localization**: Multi-language text rendering and resource loading

### Known Testing Limitations
- **Complex interactions**: Multi-widget workflows difficult to test in isolation
- **Visual validation**: Rendering correctness requires manual verification
- **Timing-dependent behavior**: Animation and transition testing challenges
- **Platform-specific behavior**: Some features require testing on target platforms

## Performance and Constraints

### Performance Characteristics
- **Rendering efficiency**: Optimized drawing with batching and dirty rectangle tracking
- **Layout calculation**: Incremental updates avoiding full tree recalculation
- **Event processing**: Low-latency input handling with efficient hit testing
- **Memory usage**: Careful widget lifecycle management preventing leaks

### Constraints
- **Hierarchy depth**: Deep widget trees can impact layout and rendering performance
- **Dynamic content**: Frequent layout changes can cause performance degradation
- **Text rendering**: Complex text with rich formatting requires significant processing
- **Cross-platform differences**: Platform-specific behavior may affect consistency

### Time Complexity
- **Layout calculation**: O(n) where n is number of widgets in affected subtree
- **Event routing**: O(log n) with spatial indexing for hit testing
- **Widget creation**: O(m) where m is number of child widgets being created
- **Rendering**: O(v) where v is number of visible widgets requiring updates

### Memory Usage
- **Widget overhead**: Each widget requires ~200-500 bytes base memory
- **Hierarchy storage**: Parent-child relationships require additional pointers
- **Event handlers**: Callback storage proportional to number of registered handlers
- **Layout caches**: Cached calculations trade memory for computational speed

## Dependencies

### External Libraries
- **OpenGL**: Low-level graphics rendering for widget visual presentation
- **Unicode libraries**: Text processing and internationalization support
- **Platform UI APIs**: Native system integration for accessibility and input methods

### Internal Module Dependencies
- **llcommon**: Core utilities, memory management, and event infrastructure (critical)
- **llrender**: Graphics abstraction and rendering pipeline (critical)
- **llwindow**: Window management and input event capture (critical)
- **llmath**: Mathematical operations for layout calculations and transformations
- **llimage**: Image loading and texture management for UI graphics
- **llxml**: XML parsing utilities for XUI file processing

### Optional Dependencies
- **llmessage**: Network communication for some specialized widgets
- **llaudio**: Sound effects for UI feedback and accessibility

## Known Issues / TODOs

### Design Weaknesses
- **Tightly coupled widgets**: Some widgets have excessive dependencies on specific implementations
- **Global state reliance**: Heavy use of global UI state complicates testing and modularity
- **Platform abstraction gaps**: Inconsistent abstraction of platform-specific UI features
- **Layout system limitations**: Complex layouts sometimes require workarounds

### Performance Issues
- **Layout thrashing**: Rapid property changes can trigger excessive recalculation
- **Text rendering overhead**: Rich text with many styles impacts rendering performance
- **Event propagation costs**: Deep hierarchies increase event processing time
- **Memory fragmentation**: Widget creation/destruction patterns can fragment memory

### Accessibility Limitations
- **Screen reader support**: Incomplete implementation of accessibility APIs
- **Keyboard navigation**: Some complex widgets lack proper keyboard-only access
- **High contrast support**: Limited support for high contrast visual themes
- **Motor accessibility**: Insufficient support for alternative input methods

### Future Improvements
- **Modern layout system**: CSS-style layout with flexbox and grid capabilities
- **Component architecture**: More modular widget design with composition over inheritance
- **Animation framework**: Built-in support for smooth transitions and animations
- **Theme system overhaul**: More sophisticated styling with runtime theme switching
- **Performance optimization**: Better caching and incremental update strategies

### Code Quality Issues
- **Documentation gaps**: Many internal APIs lack comprehensive documentation
- **Test coverage**: Some complex widgets have insufficient automated test coverage
- **Code duplication**: Similar patterns repeated across different widget implementations
- **Legacy compatibility**: Old XUI features limit modernization efforts

*Note: The UI subsystem is critical to user experience and changes should be carefully tested across all supported platforms and use cases.*