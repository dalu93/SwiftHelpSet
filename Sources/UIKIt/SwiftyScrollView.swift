//
//  SwiftyScrollView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/14/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

public class SwiftyScrollView: UIScrollView {
    
    public typealias GenericScrollViewClosure = ((scrollView: UIScrollView) -> ())
    
    private var _onScroll:                   GenericScrollViewClosure?
    public func onScroll(closure: GenericScrollViewClosure) -> Self {
        _onScroll = closure
        return self
    }
    private var _onZoom:                     GenericScrollViewClosure?
    public func onZoom(closure: GenericScrollViewClosure) -> Self {
        _onZoom = closure
        return self
    }
    private var _onScrollToTop:              GenericScrollViewClosure?
    public func _onScrollToTop(closure: GenericScrollViewClosure) -> Self {
        _onScrollToTop = closure
        return self
    }
    private var _onBeginDragging:            GenericScrollViewClosure?
    public func onBeginDragging(closure: GenericScrollViewClosure) -> Self {
        _onBeginDragging = closure
        return self
    }
    private var _onEndDecelerating:          GenericScrollViewClosure?
    public func onEndDecelerating(closure: GenericScrollViewClosure) -> Self {
        _onEndDecelerating = closure
        return self
    }
    private var _onBeginDecelerating:        GenericScrollViewClosure?
    public func onBeginDecelerating(closure: GenericScrollViewClosure) -> Self {
        _onBeginDecelerating = closure
        return self
    }
    private var _onEndScrollingAnimation:    GenericScrollViewClosure?
    public func onEndScrollingAnimation(closure: GenericScrollViewClosure) -> Self {
        _onEndScrollingAnimation = closure
        return self
    }
    private var _onEndZooming: ((scrollView: UIScrollView, view: UIView?, scale: CGFloat) -> ())?
    public func onEndZooming(closure: (scrollView: UIScrollView, view: UIView?, scale: CGFloat) -> ()) -> Self {
        _onEndZooming = closure
        return self
    }
    private var _onEndDragging: ((scrollView: UIScrollView, decelerate: Bool) -> ())?
    public func onEndDragging(closure: (scrollView: UIScrollView, decelerate: Bool) -> ()) -> Self {
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
        _onScroll?(scrollView: scrollView)
    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {
        _onZoom?(scrollView: scrollView)
    }
    
    public func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        _onScrollToTop?(scrollView: scrollView)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        _onBeginDragging?(scrollView: scrollView)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        _onEndDecelerating?(scrollView: scrollView)
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        _onBeginDecelerating?(scrollView: scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        _onEndScrollingAnimation?(scrollView: scrollView)
    }
    
    public func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        _onEndZooming?(scrollView: scrollView, view: view, scale: scale)
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _onEndDragging?(scrollView: scrollView, decelerate: decelerate)
    }
}