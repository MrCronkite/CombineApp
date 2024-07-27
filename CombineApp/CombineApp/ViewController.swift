//
//  ViewController.swift
//  CombineApp
//
//  Created by Admin on 25.07.24.
//

import UIKit
import Combine

enum CombineError: Error {
    case failed
}

final class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    //Data
    let singleData = "Vlad"
    let data = ["One", "Two", "Three"]
    
    let viewModel = ViewModel()
    let just = JustPublishers()
    let futurePublishers = FuturePublishers()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Publisher
        let simplePublisher = Just<String>(singleData)
        let sequncerPublisher = data.publisher
        
        // Subscriber
        simplePublisher.sink { value in
            print(value)
        }
        .store(in: &subscriptions)
        
        let user = User(name: "Empty")
        simplePublisher.assign(to: \User.name, on: user)
            .store(in: &subscriptions)
        
        print(user.name)
        
        sequncerPublisher.sink { complete in
            switch complete {
            case .finished:
                print("Success")
            case .failure(_):
                print("Fail")
            }
        } receiveValue: { value in
            print("Value: \(value)")
        }
        .store(in: &subscriptions)
        
        viewModel.requestSomething()
        just.subscribeInPublisher()
        just.subscribeData()
        
        futurePublishers.future.sink { completion in
            switch completion {
            case .finished:
               print("Success Photo")
            case .failure(let someError):
                print("Error :\(someError)")
            }
        } receiveValue: { [weak self] image in
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }.store(in: &subscriptions)
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

final class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
