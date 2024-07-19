import Foundation

struct Component: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let iconName: String
    let url: String
}
