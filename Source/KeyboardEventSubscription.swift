//
//  KeyboardEventSubscription.swift
//  Novel
//
//  Created by Igor Matyushkin on 05.02.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import Foundation

public struct KeyboardEventSubscription {
    internal var observerForKeyboardWillShowEvent: NSObjectProtocol?
    internal var observerForKeyboardDidShowEvent: NSObjectProtocol?
    internal var observerForKeyboardWillHideEvent: NSObjectProtocol?
    internal var observerForKeyboardDidHideEvent: NSObjectProtocol?
}
