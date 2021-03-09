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
        Text("Dogs found: \(detectorViewModel.detectedDogsList.count)")
    }
}

struct CheckResults_Previews: PreviewProvider {
    static var previews: some View {
        ListResultsView()
    }
}
