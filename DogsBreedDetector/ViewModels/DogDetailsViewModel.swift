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
    
    init(breedName: String) {
        self.breedName = breedName
    }
    
    func loadBreedDetails() {
        getBreedData()
//        if !initialInfoLoaded {
//            initialInfoLoaded.toggle()
//            loadDbData()
//            fetchPage()
//        }
    }
    
    private func getBreedData() {
        loaderService?.loadDbDogBreed(breedName, completion: { (breedInfo, errorText) in
            guard let breedInfo = breedInfo, errorText == nil else {
                print(errorText ?? "Empty character")
                return
            }
            self.breedInfo = breedInfo
        })
    }
    
}
