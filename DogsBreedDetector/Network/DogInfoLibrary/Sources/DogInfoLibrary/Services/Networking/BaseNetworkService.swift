import Foundation

public class BaseNetworkService {

    var environment: NetworkEnvironment = .production
    
    func getEnvironment() -> NetworkEnvironment {
        return self.environment
    }
    
    func setEnvironent(_ environment: NetworkEnvironment) {
        self.environment = environment
    }
    
}

extension BaseNetworkService {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        print("Response code: \(response.statusCode)")
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
