//
//  SwiftyScrollView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyScrollView: UIScrollView {
    
    private var _onScroll:                   VoidClosure?
    public func onScroll(closure: VoidClosure) -> Self {
        _onScroll = closure
        return self
    }
    private var _onZoom:                     VoidClosure?
    public func onZoom(closure: VoidClosure) -> Self {
        _onZoom = closure
        return self
    }
    private var _onScrollToTop:              VoidClosure?
    public func _onScrollToTop(closure: VoidClosure) -> Self {
        _onScrollToTop = closure
        return self
    }
    private var _onBeginDragging:            VoidClosure?
    public func onBeginDragging(closure: VoidClosure) -> Self {
        _onBeginDragging = closure
        return self
    }
    private var _onEndDecelerating:          VoidClosure?
    public func onEndDecelerating(closure: VoidClosure) -> Self {
        _onEndDecelerating = closure
        return self
    }
    private var _onBeginDecelerating:        VoidClosure?
    public func onBeginDecelerating(closure: VoidClosure) -> Self {
        _onBeginDecelerating = closure
        return self
    }
    private var _onEndScrollingAnimation:    VoidClosure?
    public func onEndScrollingAnimation(closure: VoidClosure) -> Self {
        _onEndScrollingAnimation = closure
        return self
    }
    private var _onEndZooming: ((view: UIView?, scale: CGFloat) -> ())?
    public func onEndZooming(closure: (view: UIView?, scale: CGFloat) -> ()) -> Self {
        _onEndZooming = closure
        return self
    }
    private var _onEndDragging: ((decelerate: Bool) -> ())?
    public func onEndDragging(closure: (decelerate: Bool) -> ()) -> Self {
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
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        _onScroll?()
    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {
        _onZoom?()
    }
    
    public func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        _onScrollToTop?()
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        _onBeginDragging?()
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        _onEndDecelerating?()
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        _onBeginDecelerating?()
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        _onEndScrollingAnimation?()
    }
    
    public func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        _onEndZooming?(view: view, scale: scale)
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _onEndDragging?(decelerate: decelerate)
    }
}