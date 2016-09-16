//
//  SwiftySearchBar.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/20/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public typealias VoidClosure = () -> ()
public typealias VoidBoolClosure = () -> Bool
public typealias TextVoidClosure = (_ text: String) -> ()
public typealias IndexVoidClosure = (_ index: Int) -> ()
public typealias RangeTextBoolClosure = (_ range: NSRange, _ text: String) -> Bool

public class SwiftySearchBar: UISearchBar {
    
    fileprivate var _onEndEditing: VoidClosure?
    public func onEndEditing(closure: @escaping VoidClosure) -> Self {
        _onEndEditing = closure
        return self
    }
    
    fileprivate var _onCancelTap: VoidClosure?
    public func onCancelTap(closure: @escaping VoidClosure) -> Self {
        _onCancelTap = closure
        return self
    }
    
    fileprivate var _onSearchTap: VoidClosure?
    public func onSearchTap(closure: @escaping VoidClosure) -> Self {
        _onSearchTap = closure
        return self
    }
    
    fileprivate var _onBeginEditing: VoidClosure?
    public func onBeginEditing(closure: @escaping VoidClosure) -> Self {
        _onBeginEditing = closure
        return self
    }
    
    fileprivate var _onBookmarkTap: VoidClosure?
    public func onBookmarkTap(closure: @escaping VoidClosure) -> Self {
        _onBookmarkTap = closure
        return self
    }
    
    fileprivate var _onResultListTap: VoidClosure?
    public func onResultListTap(closure: @escaping VoidClosure) -> Self {
        _onResultListTap = closure
        return self
    }
    
    fileprivate var _shouldEndEditing: VoidBoolClosure?
    public func shouldEndEditing(closure: @escaping VoidBoolClosure) -> Self {
        _shouldEndEditing = closure
        return self
    }
    
    fileprivate var _shouldBeginEditing: VoidBoolClosure?
    public func shouldBeginEditing(closure: @escaping VoidBoolClosure) -> Self {
        _shouldBeginEditing = closure
        return self
    }
    
    fileprivate var _onTextChange: TextVoidClosure?
    public func onTextChange(closure: @escaping TextVoidClosure) -> Self {
        _onTextChange = closure
        return self
    }
    
    fileprivate var _onSelectedScopeChange: IndexVoidClosure?
    public func onSelectedScopeChange(closure: @escaping IndexVoidClosure) -> Self {
        _onSelectedScopeChange = closure
        return self
    }
    
    fileprivate var _shouldChangeCharacters: RangeTextBoolClosure?
    public func shouldChangeCharacters(closure: @escaping RangeTextBoolClosure) -> Self {
        _shouldChangeCharacters = closure
        return self
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension SwiftySearchBar: UISearchBarDelegate {
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        _onEndEditing?()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _onCancelTap?()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        _onSearchTap?()
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _onBeginEditing?()
    }
    
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        _onBookmarkTap?()
    }
    
    public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        _onResultListTap?()
    }
    
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return _shouldEndEditing?() ?? true
    }
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return _shouldBeginEditing?() ?? true
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        _onTextChange?(searchText)
    }
    
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        _onSelectedScopeChange?(selectedScope)
    }
    
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return _shouldChangeCharacters?(range, text) ?? true
    }
}
