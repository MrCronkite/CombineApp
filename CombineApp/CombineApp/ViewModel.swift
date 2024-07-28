//
//  ViewModel.swift
//  CombineApp
//
//  Created by Admin on 26.07.24.
//

import UIKit
import Combine

final class ViewModel {
    let network = Network()
    var subs: Set<AnyCancellable> = []
    
    init() {
        network.requestComplete.sink { result in
            print(result)
        }.store(in: &subs)
    }
    
    func requestSomething() {
        network.send()
    }
    
    func loadData(urlString: String, closure: @escaping (UIImage) -> Void) {
        network.getImageData(urlString: urlString).sink(receiveCompletion: { completion in
            print("Success photo data")
        }, receiveValue: { data in
            closure(UIImage(data: data) ?? UIImage())
        }).store(in: &subs)
    }
}
