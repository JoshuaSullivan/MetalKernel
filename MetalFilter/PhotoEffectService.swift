import UIKit
import CoreImage
import Combine

final class PhotoEffectService {

    enum PhotoEffectServiceError: Error {
        case failedToApplyEffect
        case failedToGenerateNoise
    }

    private let context = CIContext()

    private let effectFilter = SimpleFilter()

    init() {
        // Nothing, yet.
    }

    func applyEffect(to image: UIImage) -> AnyPublisher<UIImage, PhotoEffectServiceError> {
        return Just(image)
            .receive(on: DispatchQueue.global(qos: .default))
            .tryMap({ image in
                guard let output = self.effectFilter.outputImage?.cropped(to: CGRect(x:0, y:0, width:600, height:600)),
                      let result = self.context.createCGImage(output, from: output.extent) else {
                    throw PhotoEffectServiceError.failedToApplyEffect
                }
                return UIImage(cgImage: result)
            })
            .receive(on: DispatchQueue.main)
            .mapError({ _ in PhotoEffectServiceError.failedToApplyEffect })
            .eraseToAnyPublisher()
    }
}
