//
//  SwiftyTextField.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyTextField: UITextField {
    
    private var _onEndEditing: VoidClosure?
    /// It is called on textFieldDidEndEditing(_: UITextField)
    public func onEndEditing(closure: VoidClosure) -> Self {
        _onEndEditing = closure
        return self
    }
    
    /// It is called on textFieldDidBeginEditing(_: UITextField)
    private var _onBeginEditing: VoidClosure?
    public func onBeginEditing(closure: VoidClosure) -> Self {
        _onBeginEditing = closure
        return self
    }
    
    private var _beforeCleaning: VoidBoolClosure?
    /// It is called on textFieldShouldClear(_: UITextField)
    public func beforeCleaning(closure: VoidBoolClosure) -> Self {
        _beforeCleaning = closure
        return self
    }
    
    private var _beforeReturning: VoidBoolClosure?
    /// It is called on textFieldShouldReturn(_: UITextField)
    public func beforeReturning(closure: VoidBoolClosure) -> Self {
        _beforeReturning = closure
        return self
    }
    
    private var _beforeEndingEditing: VoidBoolClosure?
    /// It is called on textFieldShouldEndEditing(_: UITextField)
    public func beforeEndingEditing(closure: VoidBoolClosure) -> Self {
        _beforeEndingEditing = closure
        return self
    }
    
    private var _beforeBeginningEditing: VoidBoolClosure?
    /// It is called on textFieldShouldBeginEditing(_: UITextField)
    public func beforeBeginningEditing(closure: VoidBoolClosure) -> Self {
        _beforeBeginningEditing = closure
        return self
    }
    
    private var _changingCharacters: RangeTextBoolClosure?
    /// It is called on textField(_: UITextField, _: NSRange, _: String)
    public func changingCharacters(closure: RangeTextBoolClosure) -> Self {
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
    
    public func textFieldDidEndEditing(textField: UITextField) {
        self._onEndEditing?()
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        self._onBeginEditing?()
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        return self._beforeCleaning?() ?? true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        return self._beforeReturning?() ?? true
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return self._beforeEndingEditing?() ?? true
    }
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return self._beforeBeginningEditing?() ?? true
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return self._changingCharacters?(range: range, text: string) ?? true
    }
}
