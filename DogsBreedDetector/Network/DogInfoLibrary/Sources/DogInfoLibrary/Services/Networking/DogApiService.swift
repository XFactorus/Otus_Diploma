import Foundation

final public class DogApiService: BaseNetworkService, IService {
    
    let router = Router<DogApi>()
    
    override public init() {
        super.init()
    }
    
    public class var service: DogApiService {
        if let service: DogApiService = DogInfoLibraryServiceLocator.service() {
            return service
        }
        
        let service = DogApiService()
        DogInfoLibraryServiceLocator.addService(service)
        return service
    }
    
    public func clear() {
        
    }
    
    public func remove() {
        DogInfoLibraryServiceLocator.removeService(self)
    }
    
    public func loadBreedInfo( _ breedName: String, completion: @escaping (_ characters: [BreedInfo]?, _ error: String?)->()) {

        router.request(.getBreedInfo(breed: breedName)) { (data, response, error) in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        //TODO: add logger if needed
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode([BreedInfo].self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

}
