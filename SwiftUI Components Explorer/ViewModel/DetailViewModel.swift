import Foundation

// ViewModel for managing detail view data
class DetailViewModel: ObservableObject {
    let component: Component
    
    // Initializer for DetailViewModel
    init(component: Component) {
        self.component = component
    }
    
    // Computed property for documentation URL
    var documentationURL: URL? {
        URL(string: component.url)
    }
}
