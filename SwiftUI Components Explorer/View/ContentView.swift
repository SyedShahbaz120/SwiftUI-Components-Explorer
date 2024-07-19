import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ComponentViewModel()
    
    var body: some View {
        NavigationView {
            // List of Sections and Components
            List {
                ForEach(viewModel.filteredSections) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.components) { component in
                            NavigationLink(destination: DetailView(component: component)) {
                                HStack {
                                    Image(systemName: component.iconName)
                                    Text(component.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Components")
            .searchable(text: $viewModel.searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
