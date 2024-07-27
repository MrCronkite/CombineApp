//
//  ViewController.swift
//  CombineApp
//
//  Created by Admin on 25.07.24.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    //Data
    let singleData = "Vlad"
    let data = ["One", "Two", "Three"]
    
    let viewModel = ViewModel()
    let just = JustPublishers()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
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
}

final class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
