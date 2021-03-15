//
//  DogDetailsViewModel.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka on 11.03.2021.
//

import Foundation
import DogInfoLibrary
import Combine

final class DogDetailsViewModel: ObservableObject {
    
    private var breedName: String
    private var loaderService: LoaderService? = DogInfoLibraryServiceLocator.service()
    
    @Published public var breedInfo: BreedInfo?
    @Published public var breedInfoFailed: Bool = false
    
    init(breedName: String) {
        self.breedName = breedName
    }
    
    func loadBreedDetails() {
        getBreedData()
    }
    
    private func getBreedData() {
        loaderService?.loadDbDogBreed(breedName, completion: { (breedInfo, errorText) in
            guard let breedInfo = breedInfo, errorText == nil else {
                print(errorText ?? "Empty character")
                self.breedInfoFailed = true
                return
            }
            self.breedInfo = breedInfo
        })
    }
    
}
