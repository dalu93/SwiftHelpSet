//
//  Each.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 9/5/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

// MARK: - Each declaratiom
/// The `Each` class allows the user to easily create a scheduled action
public class Each {
    
    enum SecondsMultiplierType {
        case toMilliseconds
        case toSeconds
        case toMinutes
        case toHours
        
        var value: Double {
            switch self {
            case .toMilliseconds:   return 1/60
            case .toSeconds:        return 1
            case .toMinutes:        return 60
            case .toHours:          return 3600
            }
        }
    }
    
    // MARK: - Private properties
    /// The timer interval in seconds
    private let _value: NSTimeInterval
    
    /// The multiplier. If nil when using it, the configuration didn't go well,
    /// the app will crash
    private var _multiplier: Double? = nil
    
    /// The definitive time interval to use for the timer. If nil, the app will crash
    private var _timeInterval: NSTimeInterval? {
        guard let _multiplier = _multiplier else { return nil }
        return _multiplier * _value
    }
    
    /// The action to perform when the timer is triggered
    private var _performClosure: VoidBoolClosure?
    
    /// The timer instance
    private weak var _timer: NSTimer?
    
    
    // MARK: - Public properties
    /// Instance that runs the specific interval in milliseconds
    lazy var milliseconds:  Each = self._makeEachWith(value: self._value, multiplierType: .toMilliseconds)
    
    /// Instance that runs the specific interval in seconds
    lazy var seconds:       Each = self._makeEachWith(value: self._value, multiplierType: .toSeconds)
    
    /// /// Instance that runs the specific interval in minutes
    lazy var minutes:       Each = self._makeEachWith(value: self._value, multiplierType: .toMinutes)
    
    /// Instance that runs the specific interval in hours
    lazy var hours:         Each = self._makeEachWith(value: self._value, multiplierType: .toHours)
    
    
    // MARK: - Lifecycle
    /**
     Initialize a new `Each` object with an abstract value.
     Remember to use the variables `milliseconds`, `seconds`, `minutes` and
     `hours` to get the exact configuration
     
     - parameter value: The abstract value that describes the interval together
                        with the time unit
     
     - returns: A new `Each` uncompleted instance
     */
    public init(_ value: NSTimeInterval) {
        self._value = value
    }
    
    deinit {
        _timer?.invalidate()
    }
    
    
    // MARK: - Public methods
    /**
     Starts the timer and performs the action whenever the timer is triggered
     The closure should return a boolean that indicates to stop or not the timer after
     the trigger. Return `false` to continue, return `true` to stop it
     
     - parameter closure: The closure to execute whenever the timer is triggered.
     The closure should return a boolean that indicates to stop or not the timer after
     the trigger. Return `false` to continue, return `true` to stop it
     */
    public func perform(closure: VoidBoolClosure) {
        guard _timer == nil else { return }
        guard let interval = _timeInterval else { fatalError("Please, speficy the time unit by using `milliseconds`, `seconds`, `minutes` abd `hours` properties") }
        
        _performClosure = closure
        _timer = NSTimer.scheduledTimerWithTimeInterval(
            interval,
            target: self,
            selector: .Triggered,
            userInfo: nil,
            repeats: true
        )
    }
}


// MARK: - Actions
private extension Each {
    @objc func _trigger(timer: NSTimer) {
        let stopTimer = _performClosure?() ?? false
        
        guard stopTimer else { return }
        timer.invalidate()
    }
}

// MARK: - Builders
private extension Each {
    func _makeEachWith(value value: NSTimeInterval, multiplierType: SecondsMultiplierType) -> Each {
        let each = Each(value)
        each._multiplier = multiplierType.value
        
        return each
    }
}


// MARK: - Selectors
private extension Selector {
    static let Triggered = #selector(Each._trigger(_:))
}