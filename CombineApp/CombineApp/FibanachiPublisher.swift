//
//  FibanachiPublisher.swift
//  CombineApp
//
//  Created by Admin on 30.07.24.
//

import Combine

struct FibanachiPublisher: Publisher {
    
    typealias Output = Int
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        let subscription = FibanachiSubscription(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}


class FibanachiSubscription<S: Subscriber>: Subscription where S.Input == Int {
    
    private var subscriber: S?
    
    init(subscriber: S) {
        self.subscriber = subscriber
    }
    
    func request(_ demand: Subscribers.Demand) {
        <#code#>
    }
    
    func cancel() {
        subscriber = nil
    }
}
