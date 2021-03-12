import Foundation
import DogInfoLibrary

class AppConfig: NSObject {
    static let shared = AppConfig()
    
    override init() {
        super.init()
    }
    
    func setup() {
//        TVShowsLibraryServiceLocator.addService(BreakingBadApiService())
//        TVShowsLibraryServiceLocator.addService(RickMortyApiService())
//
//        TVShowsLibraryServiceLocator.addService(DatabaseService())
//        TVShowsLibraryServiceLocator.addService(CharactersService())
//        TVShowsLibraryServiceLocator.addService(LoaderService())
        
        DogInfoLibraryServiceLocator.addService(DatabaseService())
        DogInfoLibraryServiceLocator.addService(DogApiService())
        DogInfoLibraryServiceLocator.addService(BreedsService())
        DogInfoLibraryServiceLocator.addService(LoaderService())
    }
}
