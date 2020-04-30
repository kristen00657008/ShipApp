import SwiftUI
import SafariServices

struct VideoView: View {
    @State var showSafari = false
    @State var urlString = "192.168.3.185:5000"

    var body: some View {
        Button(action: {
            self.showSafari = true
        }) {
            Text("觀看即時影像")
        }
        .sheet(isPresented: $showSafari) {
               SafariView(url:URL(string: self.urlString)!)            
        }
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
