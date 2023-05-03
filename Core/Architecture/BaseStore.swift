//
//  BaseStore.swift
//  VendorsApp
//
//  Created by Артур Заволович on 02.05.2023.
//

import Foundation
import Combine

typealias Reducer<State: BaseState, Action: BaseAction> = (inout State, Action) -> AnyPublisher<Action, Never>?
typealias Middleware<State: BaseState, Action: BaseAction> = (State, Action) -> AnyPublisher<Action, Never>?

class BaseStore<State: BaseState, Action: BaseAction>: ObservableObject {
    
    // MARK: - Properties (private)
    
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private var subscriptions = Set<AnyCancellable>()
    private var middlewares: [Middleware<State, Action>]
    
    // MARK: - Initialization
    
    init(initialState: State, reducer: @escaping Reducer<State, Action>, middlewares: [Middleware<State, Action>] = []) {
        state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    // MARK: - Methods (public)
    
    func dispatch(_ action: Action) {
        if let effect = reducer(&state, action) {
            effect
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }
        
        for middleware in middlewares {
            guard let middleware = middleware(state, action) else {
                break
            }
            
            middleware
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }
    }
}
