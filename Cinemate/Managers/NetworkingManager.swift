//
//  NetworkingManager.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import Foundation
protocol NetworkingManagerDelegate {
    func request<T: Decodable>(_ route: APIRouter, method: HttpMethod, completion: @escaping (Result<T, Error>) -> Void)
}
class NetworkingManager: NetworkingManagerDelegate {
    
    static let shared: NetworkingManagerDelegate = NetworkingManager()
    
    private init() {}
    
    func request<T>(_ route: APIRouter, method: HttpMethod, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = URL(string: APIRouter.baseURL + route.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if method == .get {
            components?.queryItems = route.parameters?.filter({ $0.value != nil }).map { URLQueryItem(name: $0.key, value: "\($0.value!)") }
        }
        guard let finalURL = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: finalURL  )
        request.httpMethod = method.rawValue
        
        if method == .post {
            if let parameters = route.parameters {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            }
        }
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOTRjMGU2YTgyNTk1ZWJlZjYzZDE1MDE3ZTQ4NWZiNSIsInN1YiI6IjY1MDgxYjQwZmEyN2Y0MDEwYzRiMzM1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MK-sfrILDgNY6rGUWnC7dnEn1zp8QZP5okbZiHBz-to", forHTTPHeaderField: "Authorization")
        
        // You can add more configuration like handling parameters, encoding, etc. here
        print(finalURL)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
