import UIKit
import Combine

final class ViewModel {
    @Published var image: UIImage = UIImage(named: "professor-murder")!

    private let service = PhotoEffectService()

    private var cancellation: AnyCancellable?

    func applyImageEffect() {
        cancellation?.cancel()
        cancellation = service.applyEffect(to: image)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { image in
                    self.image = image
                })
    }
}
