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
                guard let ciImage = CIImage(image: image) else {
                    throw PhotoEffectServiceError.failedToApplyEffect
                }
                self.effectFilter.inputImage = ciImage
                guard let output = self.effectFilter.outputImage,
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
