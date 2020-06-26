import Foundation
import CoreImage

class SimpleFilter: CIFilter {
    var inputImage: CIImage?

    static var kernel: CIColorKernel? = {
            guard let url = Bundle.main.url(forResource: "SimpleKernel", withExtension: "ci.metallib") else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try CIColorKernel(functionName: "SimpleKernel", fromMetalLibraryData: data)
        } catch {
            print("[ERROR] Failed to create CIColorKernel: \(error)")
        }
        return nil
    }()

    override var outputImage: CIImage? {
        get {
            guard let input = inputImage else { return nil }
            return SimpleFilter.kernel?.apply(extent: input.extent, arguments: [input])
        }
    }
}
