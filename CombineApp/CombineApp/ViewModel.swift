//
//  ViewModel.swift
//  CombineApp
//
//  Created by Admin on 26.07.24.
//

import Foundation
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
}
