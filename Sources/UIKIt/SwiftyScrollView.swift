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
    
    public var onScroll:                   GenericScrollViewClosure?
    public var onZoom:                     GenericScrollViewClosure?
    public var onScrollToTop:              GenericScrollViewClosure?
    public var onBeginDragging:            GenericScrollViewClosure?
    public var onEndDecelerating:          GenericScrollViewClosure?
    public var onBeginDecelerating:        GenericScrollViewClosure?
    public var onEndScrollingAnimation:    GenericScrollViewClosure?
    public var onEndZooming: ((scrollView: UIScrollView, view: UIView?, scale: CGFloat) -> ())?
    public var onEndDragging: ((scrollView: UIScrollView, decelerate: Bool) -> ())?
    
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
        onScroll?(scrollView: scrollView)
    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {
        onZoom?(scrollView: scrollView)
    }
    
    public func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        onScrollToTop?(scrollView: scrollView)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        onBeginDragging?(scrollView: scrollView)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        onEndDecelerating?(scrollView: scrollView)
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        onBeginDecelerating?(scrollView: scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        onEndScrollingAnimation?(scrollView: scrollView)
    }
    
    public func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        onEndZooming?(scrollView: scrollView, view: view, scale: scale)
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        onEndDragging?(scrollView: scrollView, decelerate: decelerate)
    }
}