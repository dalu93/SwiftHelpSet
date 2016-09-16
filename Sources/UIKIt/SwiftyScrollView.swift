//
//  SwiftyScrollView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyScrollView: UIScrollView {
    
    fileprivate var _onScroll:                   VoidClosure?
    public func onScroll(closure: @escaping VoidClosure) -> Self {
        _onScroll = closure
        return self
    }
    
    fileprivate var _onZoom:                     VoidClosure?
    public func onZoom(closure: @escaping VoidClosure) -> Self {
        _onZoom = closure
        return self
    }
    
    fileprivate var _onScrollToTop:              VoidClosure?
    public func _onScrollToTop(closure: @escaping VoidClosure) -> Self {
        _onScrollToTop = closure
        return self
    }
    
    fileprivate var _onBeginDragging:            VoidClosure?
    public func onBeginDragging(closure: @escaping VoidClosure) -> Self {
        _onBeginDragging = closure
        return self
    }
    
    fileprivate var _onEndDecelerating:          VoidClosure?
    public func onEndDecelerating(closure: @escaping VoidClosure) -> Self {
        _onEndDecelerating = closure
        return self
    }
    
    fileprivate var _onBeginDecelerating:        VoidClosure?
    public func onBeginDecelerating(closure: @escaping VoidClosure) -> Self {
        _onBeginDecelerating = closure
        return self
    }
    
    fileprivate var _onEndScrollingAnimation:    VoidClosure?
    public func onEndScrollingAnimation(closure: @escaping VoidClosure) -> Self {
        _onEndScrollingAnimation = closure
        return self
    }
    
    fileprivate var _onEndZooming: ((_ view: UIView?, _ scale: CGFloat) -> ())?
    public func onEndZooming(closure: @escaping ((_ view: UIView?, _ scale: CGFloat) -> ())) -> Self {
        _onEndZooming = closure
        return self
    }
    
    fileprivate var _onEndDragging: ((_ decelerate: Bool) -> ())?
    public func onEndDragging(closure: @escaping ((_ decelerate: Bool) -> ())) -> Self {
        _onEndDragging = closure
        return self
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Helpers
private extension SwiftyScrollView {
    
    func _setupProtocol() {
        self.delegate = self
    }
}

// MARK: - UIScrollViewDelegate
extension SwiftyScrollView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _onScroll?()
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        _onZoom?()
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        _onScrollToTop?()
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _onBeginDragging?()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _onEndDecelerating?()
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        _onBeginDecelerating?()
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        _onEndScrollingAnimation?()
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        _onEndZooming?(view, scale)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _onEndDragging?(decelerate)
    }
}
