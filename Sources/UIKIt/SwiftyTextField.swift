//
//  SwiftyTextField.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/29/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyTextField: UITextField {
    
    /// It is called on textFieldDidEndEditing(_: UITextField)
    public var onEndEditing: (UITextField -> ())?
    
    /// It is called on textFieldDidBeginEditing(_: UITextField)
    public var onBeginEditing: (UITextField -> ())?
    
    /// It is called on textFieldShouldClear(_: UITextField)
    public var beforeCleaning: (UITextField -> Bool)?
    
    /// It is called on textFieldShouldReturn(_: UITextField)
    public var beforeReturning: (UITextField -> Bool)?
    
    /// It is called on textFieldShouldEndEditing(_: UITextField)
    public var beforeEndingEditing: (UITextField -> Bool)?
    
    /// It is called on textFieldShouldBeginEditing(_: UITextField)
    public var beforeBeginningEditing: (UITextField -> Bool)?
    
    /// It is called on textField(_: UITextField, _: NSRange, _: String)
    public var changingCharacters: ((UITextField, NSRange, String) -> Bool)?
    
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
        self.onEndEditing?(textField)
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        self.onBeginEditing?(textField)
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        return self.beforeCleaning?(textField) ?? true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        return self.beforeReturning?(textField) ?? true
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return self.beforeEndingEditing?(textField) ?? true
    }
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return self.beforeBeginningEditing?(textField) ?? true
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return self.changingCharacters?(textField, range, string) ?? true
    }
}
