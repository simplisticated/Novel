//
//  KeyboardEvent.swift
//  Novel
//
//  Created by Igor Matyushkin on 05.02.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import Foundation

public struct KeyboardEvent {
    public var frameBegin: CGRect
    public var frameEnd: CGRect
    public var animationDuration: TimeInterval
    public var direction: Direction
    public var timing: Timing
}

public extension KeyboardEvent {
    
    public enum Direction {
        case show
        case hide
    }
    
}

public extension KeyboardEvent {
    
    public enum Timing {
        case will
        case did
    }
    
}
