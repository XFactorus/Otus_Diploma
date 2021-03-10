//
//  BreedCheckerViewModel.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

struct Dog: Identifiable {
    var id: String
    var dogName: String
    var detectionPercent: Int
}

final class BreedCheckerViewModel: ObservableObject {
    
    @Published var loadedDogImage: UIImage?
    @Published public var dogDetected: Bool = false
    @Published public var dogDetectionFailed: Bool = false
    
    private let imageDetectorService = ImageDetectorService()
    var detectedDogsList = [Dog]()
    
    init() {
        subsribeDetectorUpdates()
    }
        
    func loadImageFromLibrary() {
        print("Load image from library pressed")
    }
    
    func takePhoto() {
        print("Take photo pressed")
    }
    
    func checkBreed() {
        print("Check breed pressed")
        guard let dogImage = loadedDogImage else {
            return
        }
        
        self.imageDetectorService.detectImageType(dogImage)
    }
    
    private func refreshModel() {
        detectedDogsList = [Dog]()
        loadedDogImage = nil
        dogDetected = false
        dogDetectionFailed = false
    }
    
    func loadDogImage() -> UIImage {
        return loadedDogImage ?? UIImage(named: "dog_placeholder")!
    }
    
    func setDogImage( _ image: UIImage) {
        self.refreshModel()
        loadedDogImage = image
    }
    
    func getMainDogBreed() -> String {
        return self.detectedDogsList.first?.dogName ?? ""
    }
    
    func getMainPercent() -> Int {
        return self.detectedDogsList.first?.detectionPercent ?? 0
    }
    
    private func subsribeDetectorUpdates() {
        self.imageDetectorService.detectionCallback = { [weak self] state in
            self?.detectorStateUpdated(state)
        }
    }
    
    private func detectorStateUpdated(_ state: ImageDetectorState) {
        switch state {
        case .detectionFailed:
            print("Detection failed")
            self.dogDetectionFailed = true
            self.dogDetected = false
        case .detectionStarted:
            print("Detection started")
        case .detectionResultReceived(let detectionResults):
            self.setDogsResult(detectionResults)
            self.dogDetected = true
        }
    }
    
    private func setDogsResult(_ detectionResults: [DogBreedDetectionModel]) {
        detectedDogsList = [Dog]()
        for result in detectionResults {
            let dog = Dog(id:result.getDogBreed(), dogName: result.getFriendlyDogBreed(), detectionPercent: result.getPercentConfidence())
            detectedDogsList.append(dog)
        }
    }
    
}
