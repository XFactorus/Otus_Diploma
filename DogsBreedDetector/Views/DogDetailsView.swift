//
//  DogDetailsView.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

struct DogDetailsView: View {
    
    @ObservedObject var dogDetailsViewModel:DogDetailsViewModel
    
    var body: some View {
        VStack {
            if dogDetailsViewModel.breedInfo == nil {
                Text("Loading dog details...")
            } else {
                Text(dogDetailsViewModel.breedInfo!.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                DogDetailsListView(breedInfo: dogDetailsViewModel.breedInfo!)
            }
        }
        .onAppear {
            dogDetailsViewModel.loadBreedDetails()
        }
    }
}

struct DogDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DogDetailsView(dogDetailsViewModel: DogDetailsViewModel(breedName: "poodle"))
        }
    }
}
