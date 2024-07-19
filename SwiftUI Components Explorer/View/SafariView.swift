import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    // Create and configure the SFSafariViewController
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    // Update the SFSafariViewController
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
