//
//  DogApiEndpoint.swift
//  
//
//  Created by Vladyslav Pokryshka 
//

import Foundation

public enum DogApi {
    case getBreedInfo(breed: String)
    case downloadImage(_ imageLink: String)
}

extension DogApi: EndPointType {
    
    var environmentBaseURL : String {
        switch DogApiService.service.getEnvironment() {
        case .production, .development: return "https://api.thedogapi.com/v1/"
        }
    }
    
    var baseURL: URL {
        switch self {
        case .downloadImage(let imageLink):
            guard let url = URL(string: imageLink) else { fatalError("baseURL could not be configured.")}
            return url
        default:
            guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    
    var baseAuthenticationHeader: HTTPHeaders {
        return ["Authorization":"Basic \("")"]
    }
    
    var path: String {
        switch self {
        case .getBreedInfo:
            return "breeds/search"
        case .downloadImage:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getBreedInfo(let breedName):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["q":breedName],
                                      additionHeaders: headers)
        case .downloadImage:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["x-api-key":"9be3b836-5777-411f-a4c5-6e1da15b278e"]
    }
}
