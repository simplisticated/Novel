//
//  KeyboardListener.swift
//  Novel
//
//  Created by Igor Matyushkin on 03.12.2017.
//

import UIKit

public class KeyboardListener {
    
    // MARK: Class variables & properties
    
    public static let shared = {
        return KeyboardListener()
    }()
    
    // MARK: Public class methods
    
    // MARK: Private class methods
    
    // MARK: Initializers
    
    fileprivate init() {
    }
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    // MARK: Object variables & properties
    
    // MARK: Public object methods
    
    @discardableResult
    public func subscribe(withHandler handler: @escaping EventHandler) -> KeyboardEventSubscription {
        let notificationClosure = { (notification: Notification) in
            self.didReceiveKeyboardNotification(notification, withHandler: handler)
        }
        
        let notificationCenter = NotificationCenter.default
        
        var subscription = KeyboardEventSubscription()
        subscription.observerForKeyboardWillShowEvent = notificationCenter.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil, using: notificationClosure)
        subscription.observerForKeyboardDidShowEvent = notificationCenter.addObserver(forName: .UIKeyboardDidShow, object: nil, queue: nil, using: notificationClosure)
        subscription.observerForKeyboardWillHideEvent = notificationCenter.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil, using: notificationClosure)
        subscription.observerForKeyboardDidHideEvent = notificationCenter.addObserver(forName: .UIKeyboardDidHide, object: nil, queue: nil, using: notificationClosure)
        return subscription
    }
    
    public func unsubscribe(_ subscription: KeyboardEventSubscription) {
        let notificationCenter = NotificationCenter.default
        
        if let observerForKeyboardWillShowEvent = subscription.observerForKeyboardWillShowEvent {
            notificationCenter.removeObserver(observerForKeyboardWillShowEvent, name: .UIKeyboardWillShow, object: nil)
        }
        
        if let observerForKeyboardDidShowEvent = subscription.observerForKeyboardDidShowEvent {
            notificationCenter.removeObserver(observerForKeyboardDidShowEvent, name: .UIKeyboardDidShow, object: nil)
        }
        
        if let observerForKeyboardWillHideEvent = subscription.observerForKeyboardWillHideEvent {
            notificationCenter.removeObserver(observerForKeyboardWillHideEvent, name: .UIKeyboardWillHide, object: nil)
        }
        
        if let observerForKeyboardDidHideEvent = subscription.observerForKeyboardDidHideEvent {
            notificationCenter.removeObserver(observerForKeyboardDidHideEvent, name: .UIKeyboardDidHide, object: nil)
        }
    }
    
    // MARK: Private object methods
    
    fileprivate func didReceiveKeyboardNotification(_ notification: Notification, withHandler handler: EventHandler) {
        guard let frameBegin = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        guard let frameEnd = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        guard let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        
        switch notification.name {
        case .UIKeyboardWillShow:
            let event = KeyboardEvent(
                frameBegin: frameBegin,
                frameEnd: frameEnd,
                animationDuration: animationDuration,
                direction: .show,
                timing: .will
            )
            handler(event)
            break
        case .UIKeyboardDidShow:
            let event = KeyboardEvent(
                frameBegin: frameBegin,
                frameEnd: frameEnd,
                animationDuration: animationDuration,
                direction: .show,
                timing: .did
            )
            handler(event)
            break
        case .UIKeyboardWillHide:
            let event = KeyboardEvent(
                frameBegin: frameBegin,
                frameEnd: frameEnd,
                animationDuration: animationDuration,
                direction: .hide,
                timing: .will
            )
            handler(event)
            break
        case .UIKeyboardDidHide:
            let event = KeyboardEvent(
                frameBegin: frameBegin,
                frameEnd: frameEnd,
                animationDuration: animationDuration,
                direction: .hide,
                timing: .did
            )
            handler(event)
            break
        default:
            // Do nothing
            break
        }
    }
    
    // MARK: Protocol implementation
    
}

public extension KeyboardListener {
    
    public typealias EventHandler = (_ event: KeyboardEvent) -> Void
    
}
