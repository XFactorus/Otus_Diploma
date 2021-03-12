//
//  DogDetailsListView.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka 
//

import SwiftUI
import DogInfoLibrary

struct DogDetailsListView: View {
    var breedInfo: BreedInfo
    var body: some View {
        List {
            DogDetailsListRowView(title: "Life span", info: breedInfo.lifeSpan)
            if let temperament = breedInfo.temperament {
                DogDetailsListRowView(title: "Temperament", info: temperament)
            }
            if let weight = breedInfo.weight {
                DogDetailsListRowView(title: "Weight", info: weight.metric + " kg")
            }
            
            if let weight = breedInfo.height {
                DogDetailsListRowView(title: "Height", info: weight.metric + " cm")
            }
        }
    }
}

struct DogDetailsListView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailsListView(breedInfo: BreedInfo.getMockBreed())
    }
}
