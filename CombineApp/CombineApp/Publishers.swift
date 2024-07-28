//
//  Publishers.swift
//  CombineApp
//
//  Created by Admin on 28.07.24.
//

import UIKit
import Combine

final class FuturePublishers {
    let future = Future<UIImage, CombineError> { promise in
        let url = URL(string: "https://media.istockphoto.com/id/1441759606/ru/%D1%84%D0%BE%D1%82%D0%BE/%D1%81%D1%87%D0%B0%D1%81%D1%82%D0%BB%D0%B8%D0%B2%D0%B0%D1%8F-%D1%81%D0%BF%D0%BE%D1%80%D1%82%D1%81%D0%BC%D0%B5%D0%BD%D0%BA%D0%B0-%D1%81-%D0%BD%D0%B0%D1%83%D1%88%D0%BD%D0%B8%D0%BA%D0%B0%D0%BC%D0%B8-%D0%B1%D0%B5%D0%B3%D0%B0%D0%B5%D1%82-%D0%B2-%D0%BF%D0%B0%D1%80%D0%BA%D0%B5.jpg?s=612x612&w=0&k=20&c=Apes_rqX1rj6DBiHKS8Ncn87b6cVv2RvzkfBtkUUwGE=")!
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data , response , error in
            guard error == nil else {
                promise(.failure(.failed))
                return
            }
            
            guard let imageData = data else {
                promise(.failure(.failed))
                return
            }
            
            promise(.success(UIImage(data: imageData)!))
        }.resume()
    }
}

final class JustPublishers {
    let data = ["One", "Two", "Three"]
    var store: Set<AnyCancellable> = []
    
    let just = Just("First Message")
    
    func subscribeInPublisher() {
        just.sink { value in
            print("Just value: \(value)")
        }.store(in: &store)
    }
    
    func subscribeData() {
        data.publisher.sink { value in
            print("Sequence value: \(value)")
        }.store(in: &store)
    }
}

final class DefferedPublishers {
    let defferd = Deferred {
        print("Start Deffered")
       return  Future<UIImage, CombineError> { promise in
            let url = URL(string: "https://cdn.prod.website-files.com/63fda77e5fd49598bbf00892/6416e5ccdbc0d68da0d7727d_swift.jpg")!
            
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data , response , error in
                guard error == nil else {
                    promise(.failure(.failed))
                    return
                }
                
                guard let imageData = data else {
                    promise(.failure(.failed))
                    return
                }
                
                promise(.success(UIImage(data: imageData)!))
            }.resume()
        }
    }
}
