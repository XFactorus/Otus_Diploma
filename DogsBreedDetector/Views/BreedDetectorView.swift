//
//  BreedCheckerView.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

struct BreedDetectorView: View {
    
    @EnvironmentObject var viewModel: BreedDetectorViewModel

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var dogImage: Image?
    @State private var isCameraSelected = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image(uiImage: viewModel.loadDogImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    if inputImage == nil {
                        Text("Load dog's image to start")
                            .padding()
                    }
                    Spacer()
                    HStack {
                        Button("Photo from library") {
                            self.showingImagePicker = true
                            self.isCameraSelected = false
                        }.padding()
                        Spacer()
                        Button("Take a photo") {
                            self.showingImagePicker = true
                            self.isCameraSelected = true
                        }.padding()
                    }
                }
    
                if self.viewModel.dogDetected {
                    Text("Dog detected!\n We are \(self.viewModel.getMainPercent())% sure it's \(self.viewModel.getMainDogBreed())")
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: ListResultsView()) {
                        Text("See all results")
                    }
                }
                else if self.viewModel.dogDetectionFailed {
                    Text("Sorry, but we cannot recognize this dog.\n Try Another photo!")
                        .padding()
                        .multilineTextAlignment(.center)
                }
                else {
                    if inputImage != nil {
                        Button("Check dog's breed!") {
                            self.viewModel.checkBreed()
                        }
//                        Spacer()
                    }
                }
            }
            .navigationTitle("Breed Detector")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding([.horizontal, .bottom])
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, isCamera: self.isCameraSelected)
        }
    }
    
    func loadImage() {
        guard let image = inputImage else {
            return
        }
        self.viewModel.setDogImage(image)
    }
}

struct MainViewPreviews: PreviewProvider {
    static var previews: some View {
        BreedDetectorView().environmentObject(BreedDetectorViewModel())
    }
}
