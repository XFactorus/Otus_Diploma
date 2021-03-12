//
//  DogDetailsListRowView.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka on 12.03.2021.
//

import SwiftUI

struct DogDetailsListRowView: View {
    var title: String
    var info: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(info)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct DogDetailsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailsListRowView(title: "Name", info: "Poodle")
    }
}
