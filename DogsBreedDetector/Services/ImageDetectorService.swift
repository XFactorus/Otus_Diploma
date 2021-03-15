import UIKit
import Vision

enum ImageDetectorState {
    case detectionStarted, detectionFailed, detectionResultReceived(results: [DogBreedDetectionModel])
}

final class ImageDetectorService {
    
    var detectionCallback: ((ImageDetectorState) -> Void)?
    
    func detectImageType(_ image: UIImage) {
        
        detectionCallback?(.detectionStarted)

        guard let coreModel = configCoreMLModel(), let image = CIImage(image: image) else {
            detectionCallback?(.detectionFailed)
            print("Cannot init core ML model or image is empty")
            return
        }
        
        makeImageDetectorRequest(model: coreModel, image: image)
    }
    
    private func configCoreMLModel() -> VNCoreMLModel? {
        return try? VNCoreMLModel(for: DogsClassifier(configuration: MLModelConfiguration()).model)
    }
    
    private func makeImageDetectorRequest(model: VNCoreMLModel, image: CIImage) {
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            self?.handleRequestResults(request.results)
        }
        makeImageRequestHandler(image: image, request: request)
    }
    
    private func makeImageRequestHandler(image: CIImage, request: VNCoreMLRequest) {
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print("Image request handler error: \(error.localizedDescription)")
                self.detectionCallback?(.detectionFailed)
            }
        }
    }
    
    private func handleRequestResults(_ results: [Any]?) {
        guard let results = results as? [VNClassificationObservation],
              results.count > 0 else {
            print("Cannot observe detetion results")
            self.detectionCallback?(.detectionFailed)
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            
            var detectionResults = [DogBreedDetectionModel]()
            
            for result in results {
                if result.confidence > 0.1 {
                    detectionResults.append(DogBreedDetectionModel(identifier: result.identifier, confidence: result.confidence))
                }
            }
            
            if detectionResults.count > 0 {
                self?.detectionCallback?(.detectionResultReceived(results: detectionResults))
            } else {
                print("No detection results")
                self?.detectionCallback?(.detectionFailed)
            }
        }
    }
}
