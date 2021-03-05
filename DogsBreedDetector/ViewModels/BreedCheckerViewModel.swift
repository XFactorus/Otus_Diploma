//
//  BreedCheckerViewModel.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

final class BreedCheckerViewModel: ObservableObject {
    
    @Published var loadedDogImage:UIImage?
    
    func loadImageFromLibrary() {
        print("Load image from library pressed")
    }
    
    func takePhoto() {
        print("Take photo pressed")
    }
    
    func checkBreed() {
        print("Check breed pressed")
    }
    
    func loadDogImage() -> UIImage {
        return loadedDogImage ?? UIImage(named: "dog_placeholder")!
    }
    
    func setDogImage( _ image: UIImage) {
        loadedDogImage = image
    }
}
