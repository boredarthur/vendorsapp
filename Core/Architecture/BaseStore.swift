//
//  BaseStore.swift
//  VendorsApp
//
//  Created by Артур Заволович on 02.05.2023.
//

import Foundation
import Combine

typealias Reducer<State: BaseState, Action: BaseAction> = (inout State, Action) -> AnyPublisher<Action, Never>?

class Store<State: BaseState, Action: BaseAction>: ObservableObject {
    
    // MARK: - Properties (private)
    
    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        state = initialState
        self.reducer = reducer
    }
    
    // MARK: - Methods (public)
    
    func dispatch(_ action: Action) {
        guard let effect = reducer(&state, action) else { return }
        
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch)
            .store(in: &subscriptions)
    }
}
