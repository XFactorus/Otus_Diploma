import Foundation
import RealmSwift

public protocol LoaderOutput {
    func charactersArrayLoaded<T: Codable>(characters: [T])
    func charactersLoadingFailed(errorText: String)
}

public final class LoaderService {
    
    private var dogApiService: DogApiService?
    
    private var breedsService: BreedsService?
    
    private var notificationToken: NotificationToken?
    public var rmCharactersOutput: LoaderOutput?
    public var bbCharactersOutput: LoaderOutput?
    
    public init() {
        self.dogApiService = DogInfoLibraryServiceLocator.service()
        self.breedsService = DogInfoLibraryServiceLocator.service()
    }
    
    private func getApiDogBreed( _ breedName: String, completion: @escaping (_ breedInfo: BreedInfo?, _ errorText: String?)->()) {
        
        dogApiService?.loadBreedInfo(breedName, completion: { (breeds, errorText) in
            guard let breeds = breeds,
                  breeds.count > 0,
                  errorText == nil else {
                let errorText = errorText ?? "Empty breeds characters list"
                completion(nil, errorText)
                return
            }
            
            self.breedsService?.writeBreeds(breeds, completion: { (errorText) in
                guard errorText == nil else {
                    completion(nil, errorText)
                    return
                }
                completion(breeds.first, nil)
            })
        })
    }
    
    public func loadDbDogBreed(_ breedName: String, completion: @escaping (_ breedInfo: BreedInfo?, _ errorText: String?)->()) {

        if let dbDogBreed = self.breedsService?.readRmDogBreed(breedName) {
            completion(dbDogBreed, nil)
            return
        } else {
            self.getApiDogBreed(breedName) { (breedInfo, errorText) in
                completion(breedInfo, errorText)
            }
        }
    }    
}
