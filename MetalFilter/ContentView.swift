import SwiftUI
import Combine

struct ContentView: View {

    var viewModel: ViewModel

    @State var image: UIImage = UIImage(named: "professor-murder")!

    var body: some View {
        VStack(spacing: 20.0) {
            Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            Button("Apply Effect", action: viewModel.applyImageEffect)
        }
        .onReceive(viewModel.$image) { image in
            self.image = image
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
