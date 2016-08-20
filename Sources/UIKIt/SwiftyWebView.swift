//
//  SwiftyWebView.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/19/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import UIKit

/**
    Example of use:
    ````
     let webView = SwiftyWebView(frame: .zero)
     
     webView.filter { request, _ in
         return true
     }.onStart {
         print("Started")
     }.onFinish {
         print("Finished with success")
     }.onError {
         print("Error: \($0)")
     }.loadRequest(NSURLRequest.request(with: "http://www.google.com")!)
    ````
*/
public class SwiftyWebView: UIWebView {
    
    private var _onStart: VoidClosure?
    /// Called at the start of the request
    public func onStart(closure: VoidClosure) -> Self {
        _onStart = closure
        return self
    }
    
    private var _filter: ((request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool)?
    /// Called when the webView asks the user to handle or not the request.
    /// - parameter request:        The request is going to handle or not
    /// - parameter navigationType: The navigation type
    /// - return: Return `true` if the request should be handled, `false` if not. Default value is `true`
    public func filter(closure: (request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool) -> Self {
        _filter = closure
        return self
    }
    
    private var _onFinish: VoidClosure?
    /// Called at the end of the request
    public func onFinish(closure: VoidClosure) -> Self {
        _onFinish = closure
        return self
    }
    
    private var _onError: ((error: NSError?) -> ())?
    /// Called in case of errors during loading
    /// - parameter: The error instance
    public func onError(closure: (error: NSError?) -> ()) -> Self {
        _onError = closure
        return self
    }
    
    // MARK: - Lifecycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
}

// MARK: - UIWebViewDelegate
extension SwiftyWebView: UIWebViewDelegate {
    
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return _filter?(request: request, navigationType: navigationType) ?? true
    }
    
    public func webViewDidStartLoad(webView: UIWebView) {
        _onStart?()
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        _onFinish?()
    }
    
    public func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        _onError?(error: error)
    }
}
