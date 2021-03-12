//
//  DogsBreedDetectorApp.swift
//  DogsBreedDetector
//
//  Created by Vladyslav Pokryshka
//

import SwiftUI

@main
struct DogsBreedDetectorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            BreedDetectorView()
                .environmentObject(BreedDetectorViewModel())
        }
    }
}
