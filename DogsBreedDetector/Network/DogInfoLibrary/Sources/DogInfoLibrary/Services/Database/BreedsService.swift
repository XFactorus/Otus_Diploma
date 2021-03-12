import Foundation
import RealmSwift

public final class BreedsService {
    private var readRealm: Realm!
    
    let databaseService: DatabaseService?
    
    public init(){
        self.databaseService = DogInfoLibraryServiceLocator.service()
        readRealm = databaseService?.readRealm

    }
    
    func writeBreeds<T: Object>(_ breeds: [T], completion: @escaping (_ errorText: String?)->()) {

        DispatchQueue.main.async {
            autoreleasepool{
                [weak self] in
                
                guard let self = self else {return}
                
                let writeRealm = self.databaseService!.newRealm
                
                do
                {
                    try writeRealm.write
                    {
                        writeRealm.add(breeds, update: .modified)
                        completion(nil)
                    }
                }
                catch
                {
                    completion(error.localizedDescription)
                }
            }
        }
    }
    
    func readRmDogBreed(_ breedName: String) -> BreedInfo? {
        let scope = readRealm.objects(BreedInfo.self).filter("name == %@", breedName)
        let firstBreed = scope.first
        print(firstBreed?.name ?? "")
        return firstBreed
    }
}

