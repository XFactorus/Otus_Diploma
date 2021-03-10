//
//  ListResultsView.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

struct ListResultsView: View {
    @EnvironmentObject var detectorViewModel: BreedCheckerViewModel
    
    var body: some View {
        List(self.detectorViewModel.detectedDogsList) { dog in
            NavigationLink(destination: DogDetailsView()) {
                HStack {
                    Text(dog.dogName)
                    Spacer()
                    Text("Accuracy: \(dog.detectionPercent)%")
                }
            }
        }
        .navigationBarTitle("Detection results", displayMode: .inline)
        Text("Possible dogs detected: \(detectorViewModel.detectedDogsList.count)")
    }
}

struct CheckResults_Previews: PreviewProvider {
    static var previews: some View {
        ListResultsView()
    }
}
