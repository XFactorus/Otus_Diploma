//
//  DogsBreedDetectorApp.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

@main
struct DogsBreedDetectorApp: App {
    var body: some Scene {
        WindowGroup {
            BreedDetectorView()
                .environmentObject(BreedCheckerViewModel())
        }
    }
}
