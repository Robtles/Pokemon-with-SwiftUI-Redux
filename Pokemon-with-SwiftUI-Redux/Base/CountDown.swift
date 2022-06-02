//
//  CountDown.swift
//  Pokemon-with-SwiftUI-Redux
//
//  Created by Rob on 16/05/2022.
//

import Foundation

/// An object that allows performing several actions before a given completion
public struct CountDown {
    // MARK: Type Properties
    private struct Action {
        /// The action to perform
        fileprivate let action: () -> Void
        /// The queue in which the action should be dispatched
        fileprivate let queue: DispatchQueue
        /// The quality-of-service of the thread that will perform the action
        fileprivate let qos: DispatchQoS
        
        // MARK: Init Methods
        /// Initializes an action with the thread-relative information
        /// - Parameters:
        ///   - action: The action to perform
        ///   - queue: The queue in which the action should be dispatched
        ///   - qos: The quality-of-service of the thread that will perform the action
        fileprivate init(
            action: @escaping () -> Void,
            queue: DispatchQueue,
            qos: DispatchQoS
        ) {
            self.action = action
            self.queue = queue
            self.qos = qos
        }
    }
    
    // MARK: Instance Properties
    /// The actions that the count down should perform before calling its completion
    private var actions: [CountDown.Action] = []
    /// The count down completion once all actions have been performed
    private var completion: () -> Void
    /// Automatically sset according to the actions count
    private var count: Int = 0

    // MARK: Methods
    /// Adds an action to perform. Do not forget calling `countDown.decrease()` in the action's completion
    /// - Parameters:
    ///   - action: The action to perform
    ///   - dispatchQueue: The queue in which the action should be dispatched
    ///   - qos: The quality-of-service of the thread that will perform the action
    public mutating func addAction(
        _ action: @escaping () -> Void,
        dispatchQueue: DispatchQueue = .main,
        qos: DispatchQoS = .default
    ) {
        actions.append(Action(action: action, queue: dispatchQueue, qos: qos))
    }

    /// Decreases the actions count, and calls the completion action if it equals zero
    public mutating func decrease() {
        count -= 1
        if count == 0 {
            completion()
        }
    }
    
    /// Starts all the actions
    public mutating func start() {
        count = actions.count
        actions.forEach { action in
            action.queue.async(qos: action.qos) {
                action.action()
            }
        }
    }
    
    // MARK: Init Methods
    /// Initializes a `CountDown` object with the expected completion
    /// - Parameter completion: The completion action to call once all the actions have been performed
    /// Add actions to the `CountDown` object using the `addActions()` function
    public init(_ completion: @escaping () -> Void) {
        self.completion = completion
    }
}
