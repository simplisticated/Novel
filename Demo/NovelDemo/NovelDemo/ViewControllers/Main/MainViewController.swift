//
//  MainViewController.swift
//  NovelDemo
//
//  Created by Igor Matyushkin on 04.02.2018.
//  Copyright © 2018 Igor Matyushkin. All rights reserved.
//

import UIKit
import Novel

class MainViewController: UIViewController {

    // MARK: Class variables & properties
    
    // MARK: Public class methods
    
    // MARK: Private class methods
    
    // MARK: Initializers
    
    // MARK: Deinitializer
    
    deinit {
        // Unsubscribe from keyboard events
        
        if self.keyboardEventSubscription != nil {
            KeyboardListener.shared.unsubscribe(self.keyboardEventSubscription!)
            self.keyboardEventSubscription = nil
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet fileprivate weak var textView: UITextView!
    
    @IBOutlet fileprivate weak var textViewBottomLayoutConstraint: NSLayoutConstraint!
    
    // MARK: Object variables & properties
    
    fileprivate var keyboardEventSubscription: KeyboardEventSubscription?
    
    // MARK: Public object methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize navigation bar
        
        self.navigationItem.title = "Novel Demo"
        
        //self.textView.keyboardDismissMode = .onDrag
        
        // Subscribe to keyboard events
        
        self.keyboardEventSubscription = KeyboardListener.shared.subscribe { (event) in
            print("Frame begin: ", event.frameBegin)
            print("Frame end: ", event.frameEnd)
            print("Animation duration: ", event.animationDuration)
            print("Direction: ", event.direction)
            print("Timing: ", event.timing)
            print("\n")
            
            self.textViewBottomLayoutConstraint.constant = -event.frameEnd.height
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private object methods
    
    // MARK: Actions
    
    // MARK: Protocol implementation
    
}
