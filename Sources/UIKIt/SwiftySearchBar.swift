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
public typealias TextVoidClosure = (text: String) -> ()
public typealias IndexVoidClosure = (index: Int) -> ()
public typealias RangeTextBoolClosure = (range: NSRange, text: String) -> Bool

public class SwiftySearchBar: UISearchBar {
    
    private var _onEndEditing: VoidClosure?
    public func onEndEditing(closure: VoidClosure) -> Self {
        _onEndEditing = closure
        return self
    }
    
    private var _onCancelTap: VoidClosure?
    public func onCancelTap(closure: VoidClosure) -> Self {
        _onCancelTap = closure
        return self
    }
    
    private var _onSearchTap: VoidClosure?
    public func onSearchTap(closure: VoidClosure) -> Self {
        _onSearchTap = closure
        return self
    }
    
    private var _onBeginEditing: VoidClosure?
    public func onBeginEditing(closure: VoidClosure) -> Self {
        _onBeginEditing = closure
        return self
    }
    
    private var _onBookmarkTap: VoidClosure?
    public func onBookmarkTap(closure: VoidClosure) -> Self {
        _onBookmarkTap = closure
        return self
    }
    
    private var _onResultListTap: VoidClosure?
    public func onResultListTap(closure: VoidClosure) -> Self {
        _onResultListTap = closure
        return self
    }
    
    private var _shouldEndEditing: VoidBoolClosure?
    public func shouldEndEditing(closure: VoidBoolClosure) -> Self {
        _shouldEndEditing = closure
        return self
    }
    
    private var _shouldBeginEditing: VoidBoolClosure?
    public func shouldBeginEditing(closure: VoidBoolClosure) -> Self {
        _shouldBeginEditing = closure
        return self
    }
    
    private var _onTextChange: TextVoidClosure?
    public func onTextChange(closure: TextVoidClosure) -> Self {
        _onTextChange = closure
        return self
    }
    
    private var _onSelectedScopeChange: IndexVoidClosure?
    public func onSelectedScopeChange(closure: IndexVoidClosure) -> Self {
        _onSelectedScopeChange = closure
        return self
    }
    
    private var _shouldChangeCharacters: RangeTextBoolClosure?
    public func shouldChangeCharacters(closure: RangeTextBoolClosure) -> Self {
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
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        _onEndEditing?()
    }
    
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        _onCancelTap?()
    }
    
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        _onSearchTap?()
    }
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        _onBeginEditing?()
    }
    
    public func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        _onBookmarkTap?()
    }
    
    public func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        _onResultListTap?()
    }
    
    public func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return _shouldEndEditing?() ?? true
    }
    
    public func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        return _shouldBeginEditing?() ?? true
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        _onTextChange?(text: searchText)
    }
    
    public func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        _onSelectedScopeChange?(index: selectedScope)
    }
    
    public func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return _shouldChangeCharacters?(range: range, text: text) ?? true
    }
}
