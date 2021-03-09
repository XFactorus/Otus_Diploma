import Foundation

class DogBreedDetectionModel {
    private let identifier: String
    private let confidence: Float
    
    required init(identifier: String, confidence: Float) {
        self.identifier = identifier
        self.confidence = confidence
    }
    
    func getPercentConfidence() -> Int {
        return Int((confidence * 100).rounded())
    }
    
    func getDogBreed() -> String {
        return identifier
    }
    
    func getFriendlyDogBreed() -> String {
        let friendlyName = identifier.replacingOccurrences(of: "_", with: " ").capitalized
        return friendlyName
    }
}
