//
//  ListResultsView.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

struct ListResultsView: View {
    @EnvironmentObject var detectorViewModel: BreedDetectorViewModel
    
    var body: some View {
        List(self.detectorViewModel.detectedDogsList) { dog in
            NavigationLink(destination: DogDetailsView(dogDetailsViewModel: DogDetailsViewModel(breedName: dog.dogName))) {
                HStack {
                    Text(dog.dogName)
                    Spacer()
                    Text("Accuracy: \(dog.detectionPercent)%")
                }
            }
        }
        .navigationTitle("Detection Results")
        Text("Possible dogs detected: \(detectorViewModel.detectedDogsList.count)")
    }
}

struct CheckResults_Previews: PreviewProvider {
    static var previews: some View {
        ListResultsView()
    }
}
