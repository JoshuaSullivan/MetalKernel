import Foundation
import CoreImage

class SimpleFilter: CIFilter {

    var offsetX: Float = 0.0
    var offsetY: Float = 0.0
    var offsetZ: Float = 10.0
    var zoom: Float = 50.0
    
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
            let clampedZoom = max(1.0, min(zoom, 1000.0))
            let scale = 1.0 / clampedZoom
            return SimpleFilter.kernel?.apply(extent: .infinite, arguments: [offsetX, offsetY, offsetZ, scale])
        }
    }
}
