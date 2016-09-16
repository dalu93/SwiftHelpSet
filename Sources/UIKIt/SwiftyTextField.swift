//
//  SwiftyTextField.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyTextField: UITextField {
    
    fileprivate var _onEndEditing: VoidClosure?
    /// It is called on textFieldDidEndEditing(_: UITextField)
    public func onEndEditing(closure: @escaping VoidClosure) -> Self {
        _onEndEditing = closure
        return self
    }
    
    /// It is called on textFieldDidBeginEditing(_: UITextField)
    fileprivate var _onBeginEditing: VoidClosure?
    public func onBeginEditing(closure: @escaping VoidClosure) -> Self {
        _onBeginEditing = closure
        return self
    }
    
    fileprivate var _beforeCleaning: VoidBoolClosure?
    /// It is called on textFieldShouldClear(_: UITextField)
    public func beforeCleaning(closure: @escaping VoidBoolClosure) -> Self {
        _beforeCleaning = closure
        return self
    }
    
    fileprivate var _beforeReturning: VoidBoolClosure?
    /// It is called on textFieldShouldReturn(_: UITextField)
    public func beforeReturning(closure: @escaping VoidBoolClosure) -> Self {
        _beforeReturning = closure
        return self
    }
    
    fileprivate var _beforeEndingEditing: VoidBoolClosure?
    /// It is called on textFieldShouldEndEditing(_: UITextField)
    public func beforeEndingEditing(closure: @escaping VoidBoolClosure) -> Self {
        _beforeEndingEditing = closure
        return self
    }
    
    fileprivate var _beforeBeginningEditing: VoidBoolClosure?
    /// It is called on textFieldShouldBeginEditing(_: UITextField)
    public func beforeBeginningEditing(closure: @escaping VoidBoolClosure) -> Self {
        _beforeBeginningEditing = closure
        return self
    }
    
    fileprivate var _changingCharacters: RangeTextBoolClosure?
    /// It is called on textField(_: UITextField, _: NSRange, _: String)
    public func changingCharacters(closure: @escaping RangeTextBoolClosure) -> Self {
        _changingCharacters = closure
        return self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension SwiftyTextField: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self._onEndEditing?()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self._onBeginEditing?()
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self._beforeCleaning?() ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self._beforeReturning?() ?? true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self._beforeEndingEditing?() ?? true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self._beforeBeginningEditing?() ?? true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self._changingCharacters?(range, string) ?? true
    }
}
