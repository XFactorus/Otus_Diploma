import Foundation

protocol IService {
    static var service: Self {get}
    
    func clear()
    func remove()
}

protocol IServiceLocator {
    func service<T>() -> T?
}

final public class DogInfoLibraryServiceLocator: IServiceLocator {
    
    private static let instance = DogInfoLibraryServiceLocator()
    private lazy var services: [String: Any] = [:]
    
    // MARK: - Public methods
    public class func service<T>() -> T? {
        return instance.service()
    }
    
    public class func addService<T>(_ service: T) {
        return instance.addService(service)
    }
    
    public class func clear() {
        instance.services.removeAll()
    }
    
    public class func removeService<T>(_ service: T) {
        instance.removeService(service)
    }
    
    func service<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
    
    // MARK: - Private methods
    private func addService<T>(_ service: T) {
        let key = typeName(T.self)
        services[key] = service
    }
    
    private func removeService<T>(_ service: T) {
        let key = typeName(T.self)
        services.removeValue(forKey: key)
    }
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
