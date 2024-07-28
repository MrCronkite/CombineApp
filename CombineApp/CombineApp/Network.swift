//
//  Network.swift
//  CombineApp
//
//  Created by Admin on 26.07.24.
//

import UIKit
import Combine

final class Network {
    let requestComplete: PassthroughSubject<String, Never> = .init()
    
    func send() {
        requestComplete.send("Complete")
    }
    
    func getImageData(urlString: String) -> any Publisher<Data, CombineError> {
        guard let url = URL(string: urlString) else {
            return Fail<Data, CombineError>(error: .failed).eraseToAnyPublisher()
        }
        
        return Future<Data, CombineError> { promise in
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data , response , error in
                guard error == nil else {
                    promise(.failure(.failed))
                    return
                }
                
                guard let imageData = data else {
                    promise(.failure(.failed))
                    return
                }
                
                promise(.success(imageData))
            }.resume()
        }.eraseToAnyPublisher()
    }
}
