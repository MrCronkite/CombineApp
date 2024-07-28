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

final class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

final class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    //Data
    let singleData = "Vlad"
    let data = ["One", "Two", "Three"]
    
    let viewModel = ViewModel()
    let just = JustPublishers()
    let futurePublishers = FuturePublishers()
    let defferedPublishers = DefferedPublishers()
    
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
        
        defferedPublishers.defferd.sink { completion in
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
