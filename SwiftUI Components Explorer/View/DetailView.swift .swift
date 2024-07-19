import SwiftUI
import SafariServices

struct DetailView: View {
    let component: Component
    @State private var showSafari = false
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var selectedDate = Date()
    @State private var selectedColor = Color.blue
    @State private var selectedOption = 0
    @State private var sliderValue: Double = 0.5
    @State private var isToggled = false
    @State private var selectedMenuOption = "Select an option"
    @State private var isLoading = false
    @State private var progress = 0.0
    @State private var buttonDisabled = false
    @State private var imageLoading = true
    @State private var loadedImage: UIImage? = nil
    @State private var imageUrl = URL(string: "https://images.unsplash.com/photo-1635805737707-575885ab0820?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!

    private let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack(alignment: .leading) {
            Text(component.description)
                .padding()

            // Display component example based on its name
            switch component.name {
            case "Text":
                Text("This is a Text component.")
                    .padding()
            case "Label":
                Label("This is a Label", systemImage: "star")
                    .padding()
            case "TextField":
                TextField("Enter text here", text: .constant("Sample text"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            case "SecureField":
                SecureField("Enter secure text here", text: .constant("Password"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            case "TextArea":
                TextEditor(text: .constant("This is a TextEditor."))
                    .border(Color.gray, width: 1)
                    .padding()
            case "Image":
                VStack {
                    if imageLoading {
                        ProgressView("Loading image...")
                            .padding()
                    } else if let loadedImage = loadedImage {
                        Image(uiImage: loadedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                    } else {
                        Image(systemName: "photo") // Fallback image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                    }
                }
                .onAppear {
                    loadImage(from: imageUrl)
                }
            case "Button":
                VStack {
                    Button(action: {
                        print("Primary button tapped")
                    }) {
                        Text("Primary Button")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Button(action: {
                        print("Disabled button tapped")
                    }) {
                        Text("Disabled Button")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(true)
                    .padding()
                }
            case "Menu":
                Menu {
                    ForEach(options, id: \.self) { option in
                        Button(option) {
                            selectedMenuOption = option
                        }
                    }
                } label: {
                    Text(selectedMenuOption)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            case "Link":
                Link("Open Apple", destination: URL(string: "https://www.apple.com")!)
                    .padding()
            case "Slider":
                Slider(value: $sliderValue, in: 0...1)
                    .padding()
                Text("Slider value: \(sliderValue, specifier: "%.2f")")
                    .padding()
            case "Stepper":
                Stepper("Value: \(Int(sliderValue))", value: $sliderValue, in: 0...100)
                    .padding()
            case "Toggle":
                Toggle("Toggle me", isOn: $isToggled)
                    .padding()
            case "Picker":
                Picker("Select an option", selection: $selectedOption) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(options[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Text("Selected Option: \(options[selectedOption])")
                    .padding()
            case "DatePicker":
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                    .padding()
            case "ColorPicker":
                ColorPicker("Select a color", selection: $selectedColor)
                    .padding()
                Text("Selected Color:")
                    .padding()
                    .background(selectedColor)
                    .frame(height: 50)
                    .border(Color.black, width: 1)
            case "HStack":
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<15) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .border(Color.black, width: 1)
                        }
                    }
                }
                .padding()
            case "VStack":
                ScrollView(.vertical) {
                    VStack {
                        ForEach(0..<15) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .border(Color.black, width: 1)
                        }
                    }
                }
                .padding()
            case "ZStack":
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                    Text("Overlay")
                        .foregroundColor(.white)
                }
                .padding()
            case "Form":
                Form {
                    TextField("Name", text: .constant("Sample Name"))
                    Toggle("Active", isOn: .constant(true))
                }
                .padding()
            case "NavigationView":
                NavigationView {
                    List {
                        ForEach(0..<5) { index in
                            NavigationLink(destination: Text("Detail for item \(index)")) {
                                Text("Item \(index)")
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .navigationTitle("Navigation Example")
                }
                .padding()
            case "Alert":
                Button("Show Alert") {
                    showAlert = true
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert Title"),
                          message: Text("This is an example of an alert."),
                          dismissButton: .default(Text("OK")))
                }
            case "Sheet":
                Button("Show Sheet") {
                    showSheet = true
                }
                .padding()
                .sheet(isPresented: $showSheet) {
                    VStack {
                        Text("This is a modal sheet!")
                            .font(.title)
                            .padding()
                        Button("Dismiss") {
                            showSheet = false
                        }
                        .padding()
                    }
                }
            case "Plain":
                List {
                    ForEach(0..<10) { index in
                        Text("Item \(index)")
                            .padding()
                    }
                }
                .listStyle(PlainListStyle())
                .padding()
            case "Inset":
                List {
                    ForEach(0..<10) { index in
                        Text("Item \(index)")
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .listStyle(InsetListStyle())
                .padding()
            case "Grouped":
                List {
                    Section(header: Text("Header")) {
                        ForEach(0..<10) { index in
                            Text("Item \(index)")
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .padding()
            case "Inset Grouped":
                List {
                    Section(header: Text("Header")) {
                        ForEach(0..<10) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding()
            case "Sidebar":
                NavigationView {
                    List {
                        ForEach(0..<10) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .listStyle(SidebarListStyle())
                    .padding()
                    .frame(width: 200)
                }
                .padding()
            case "ProgressView":
                VStack {
                    ProgressView("Loading...", value: progress, total: 100)
                        .padding()
                    Button("Simulate Progress") {
                        simulateProgress()
                    }
                    .padding()
                }
            case "ScrollView":
                ScrollView {
                    VStack {
                        ForEach(0..<50) { index in
                            Text("Scrollable Item \(index)")
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            default:
                Text("Component not supported.")
                    .padding()
            }
        }
        .navigationTitle(component.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if let url = URL(string: component.url) {
                    Button(action: {
                        showSafari = true
                    }) {
                        Image(systemName: "doc.text") // Page symbol for opening URL
                    }
                    .sheet(isPresented: $showSafari) {
                        SafariView(url: url)
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    private func loadImage(from url: URL) {
        // Asynchronous image loading
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.loadedImage = UIImage(data: data)
                    self.imageLoading = false
                }
            }
        }
    }
    
    private func simulateProgress() {
        // Simulate progress updates
        withAnimation {
            for i in 0...100 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                    self.progress = Double(i)
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(component: Component(name: "Text", description: "Sample description", iconName: "textformat", url: "https://developer.apple.com/documentation/swiftui/text"))
    }
}
