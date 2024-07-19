import Foundation

struct ComponentSection: Identifiable {
    let id = UUID()
    let title: String
    var components: [Component]
}
