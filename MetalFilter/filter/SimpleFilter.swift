import Foundation
import CoreImage

class SimpleFilter: CIFilter {
    var inputImage: CIImage?

    static var kernel: CIColorKernel = { () -> CIColorKernel in
        let url = Bundle.main.url(forResource: "SimpleKernel", withExtension: "ci.metallib")!
        let data = try! Data(contentsOf: url)
        return try! CIColorKernel(functionName: "SimpleKernel", fromMetalLibraryData: data)
    }()

    override var outputImage: CIImage? {
        get {
            guard let input = inputImage else { return nil }
            return SimpleFilter.kernel.apply(extent: input.extent, arguments: [input])
        }
    }
}
