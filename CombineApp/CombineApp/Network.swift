//
//  Network.swift
//  CombineApp
//
//  Created by Admin on 26.07.24.
//

import Foundation
import Combine

final class Network {
    let requestComplete: PassthroughSubject<String, Never> = .init()
    
    func send() {
        requestComplete.send("Complete")
    }
}
