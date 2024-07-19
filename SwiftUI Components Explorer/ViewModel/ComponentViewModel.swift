import Foundation
import Combine

// ViewModel for managing component data
class ComponentViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    // Sample sections with components
    let sections: [ComponentSection] = [
        // Section for Text Input/Output components
        ComponentSection(title: "Text Input/Output", components: [
            Component(name: "Text", description: "Displays text.", iconName: "textformat", url: "https://developer.apple.com/documentation/swiftui/text"),
            Component(name: "Label", description: "Displays a label.", iconName: "tag", url: "https://developer.apple.com/documentation/swiftui/label"),
            Component(name: "TextField", description: "A text input field.", iconName: "text.cursor", url: "https://developer.apple.com/documentation/swiftui/textfield"),
            Component(name: "SecureField", description: "A secure text input field.", iconName: "lock", url: "https://developer.apple.com/documentation/swiftui/securefield"),
            Component(name: "TextArea", description: "A multiline text input area.", iconName: "rectangle.and.pencil.and.ellipsis", url: "https://developer.apple.com/documentation/swiftui/texteditor"),
            Component(name: "Image", description: "Displays an image.", iconName: "photo", url: "https://developer.apple.com/documentation/swiftui/image")
        ]),
        // Section for Control components
        ComponentSection(title: "Controls", components: [
            Component(name: "Button", description: "A button control.", iconName: "rectangle", url: "https://developer.apple.com/documentation/swiftui/button"),
            Component(name: "Menu", description: "A menu control.", iconName: "ellipsis", url: "https://developer.apple.com/documentation/swiftui/menu"),
            Component(name: "Link", description: "A link to open a URL.", iconName: "link", url: "https://developer.apple.com/documentation/swiftui/link"),
            Component(name: "Slider", description: "A slider control.", iconName: "slider.horizontal.3", url: "https://developer.apple.com/documentation/swiftui/slider"),
            Component(name: "Stepper", description: "A stepper control.", iconName: "minus.slash.plus", url: "https://developer.apple.com/documentation/swiftui/stepper"),
            Component(name: "Toggle", description: "A toggle switch.", iconName: "switch.2", url: "https://developer.apple.com/documentation/swiftui/toggle"),
            Component(name: "Picker", description: "A picker control.", iconName: "square.grid.3x3", url: "https://developer.apple.com/documentation/swiftui/picker"),
            Component(name: "DatePicker", description: "A date picker control.", iconName: "calendar", url: "https://developer.apple.com/documentation/swiftui/datepicker"),
            Component(name: "ColorPicker", description: "A color picker control.", iconName: "eyedropper.full", url: "https://developer.apple.com/documentation/swiftui/colorpicker"),
            Component(name: "ProgressView", description: "A progress view.", iconName: "hourglass", url: "https://developer.apple.com/documentation/swiftui/progressview")
        ]),
        // Section for Container Views
        ComponentSection(title: "Container Views", components: [
            Component(name: "HStack", description: "A horizontal stack.", iconName: "rectangle.split.3x1.fill", url: "https://developer.apple.com/documentation/swiftui/hstack"),
            Component(name: "VStack", description: "A vertical stack.", iconName: "rectangle.split.3x3.fill", url: "https://developer.apple.com/documentation/swiftui/vstack"),
            Component(name: "ZStack", description: "A stack with overlapping views.", iconName: "square.on.square", url: "https://developer.apple.com/documentation/swiftui/zstack"),
            Component(name: "Form", description: "A form view.", iconName: "square.and.pencil", url: "https://developer.apple.com/documentation/swiftui/form"),
            Component(name: "NavigationView", description: "A view with navigation capabilities.", iconName: "map", url: "https://developer.apple.com/documentation/swiftui/navigationview"),
            Component(name: "Alert", description: "An alert dialog.", iconName: "exclamationmark.triangle", url: "https://developer.apple.com/documentation/swiftui/alert"),
            Component(name: "Sheet", description: "A sheet presentation.", iconName: "doc.on.clipboard", url: "https://developer.apple.com/documentation/swiftui/sheet")
        ]),
        // Section for List styles
        ComponentSection(title: "List", components: [
            Component(name: "Plain", description: "A plain list style.", iconName: "list.bullet", url: "https://developer.apple.com/documentation/swiftui/list"),
            Component(name: "Inset", description: "An inset list style.", iconName: "list.bullet.indent", url: "https://developer.apple.com/documentation/swiftui/list"),
            Component(name: "Grouped", description: "A grouped list style.", iconName: "list.bullet.rectangle", url: "https://developer.apple.com/documentation/swiftui/list"),
            Component(name: "Inset Grouped", description: "An inset grouped list style.", iconName: "list.bullet.rectangle.portrait", url: "https://developer.apple.com/documentation/swiftui/list"),
            Component(name: "Sidebar", description: "A sidebar list style.", iconName: "sidebar.left", url: "https://developer.apple.com/documentation/swiftui/list")
        ])
    ]
    
    // Filter sections based on search text
    var filteredSections: [ComponentSection] {
        if searchText.isEmpty {
            return sections
        } else {
            return sections.map { section in
                let filteredComponents = section.components.filter { component in
                    component.name.lowercased().contains(searchText.lowercased()) || component.description.lowercased().contains(searchText.lowercased())
                }
                return ComponentSection(title: section.title, components: filteredComponents)
            }
        }
    }
}
