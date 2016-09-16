//
//  Purchase.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 7/20/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation
import StoreKit

/// The `Purchase` object represents an elegant and functional way to use the 
/// `StoreKit` framework provided by Apple.
public final class Purchase: NSObject {
    private static let `default` = Purchase()
    private var productRequest: SKRequest? {
        didSet {
            productRequest?.delegate = self
            productRequest?.start()
        }
    }
    
    fileprivate var restoreRequest: SKRequest? {
        didSet {
            restoreRequest?.delegate = self
            restoreRequest?.start()
        }
    }
    
    fileprivate var purchasing = false
    
    fileprivate var onFetchedProducts: ((Completion<[SKProduct]>) -> ())?
    fileprivate var onPurchaseCompleted: ((Completion<Data>) -> ())?
    fileprivate var onPurchaseRestored: ((Completion<Data>) -> ())?
    
    // MARK: - Static methods
    
    /**
     Requests a list of `SKProduct` from an array of identifiers. 
     
     It calls the completion block
     when the request is completed or failed.
     Whenever this method is called, it cancels any other appending requests of the same type
     
     - parameter identifiers: The products identifiers list
     - parameter completion:  Completion handler
     */
    static public func products(from identifiers: [String], completion: @escaping ((Completion<[SKProduct]>) -> ())) {
        Purchase.default.onFetchedProducts = completion
        
        Purchase.default.productRequest?.cancel()
        Purchase.default.productRequest = SKProductsRequest(productIdentifiers: Set(identifiers))
    }
    
    /**
     Purchase a `SKProduct`. 
     
     The completion handler could return the receipt `NSData` value or
     an error
     
     - parameter product:    The product to buy
     - parameter completion: Completion handler
     */
    static public func purchase(product: SKProduct, completion: @escaping ((Completion<Data>) -> ())) {
        
        guard Purchase.default.purchasing else {
            completion(.failed(.purchaseInProgressError()))
            return
        }
        
        Purchase.default.purchasing = true
        Purchase.default.onPurchaseCompleted = completion
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    /**
     Tries to restore the purchase the account has done before. 
     
     The completion handler could return the receipt `NSData` value.
     
     - parameter completion: Completion handler
     */
    static public func restorePurchase(completion: @escaping ((Completion<Data>) -> ())) {
        Purchase.default.onPurchaseRestored = completion
        Purchase.default.restoreRequest = SKReceiptRefreshRequest()
    }
    
    // MARK: - Object lifecycle
    override public init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
}

// MARK: - SKProductsRequestDelegate
extension Purchase: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        let invalidProductsIdentifier = response.invalidProductIdentifiers
        
        guard invalidProductsIdentifier.isEmpty else {
            onFetchedProducts?(.failed(.errorWith(invalidIdentifiers: invalidProductsIdentifier)))
            return
        }
        
        onFetchedProducts?(.success(products))
    }
}

// MARK: - SKRequestDelegate
extension Purchase: SKRequestDelegate {
    
    public func requestDidFinish(_ request: SKRequest) {
        
        if request == restoreRequest {
            
            guard let receipt = self._getReceipt() else {
                onPurchaseRestored?(.failed(.restoringError()))
                return
            }
            
            onPurchaseRestored?(.success(receipt))
        }
    }
}

// MARK: - SKPaymentTransactionObserver
extension Purchase: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing, .deferred: break
            case .purchased:
                purchasing = false
                guard let receipt = self._getReceipt() else {
                    onPurchaseCompleted?(.failed(.purchaseGenericError()))
                    return
                }
                
                onPurchaseCompleted?(.success(receipt))
                
            case .failed:
                purchasing = false
                onPurchaseCompleted?(.failed($0.error as? NSError ?? NSError.purchaseGenericError()))
                SKPaymentQueue.default().finishTransaction($0)

            default:
                purchasing = false
                SKPaymentQueue.default().finishTransaction($0)
            }
        }
    }
}

// MARK: - Receipt utility
private extension Purchase {
    func _getReceipt() -> Data? {
        if let url = Bundle.main.appStoreReceiptURL {
            return try? Data(contentsOf: url)
        }
        return nil
    }
}

// MARK: - Error utilities
private extension NSError {
    static func errorWith(invalidIdentifiers: [String]) -> NSError {
        return NSError(
            domain: "Purchase",
            code: -1,
            userInfo: [
                NSLocalizedDescriptionKey: "The product identifiers (\(invalidIdentifiers) are invalid)"
            ]
        )
    }
    
    static func restoringError() -> NSError {
        return NSError(
            domain: "Purchase",
            code: -2,
            userInfo: [
                NSLocalizedDescriptionKey: "Error while restoring the purchases"
            ]
        )
    }
    
    static func purchaseGenericError() -> NSError {
        return NSError(
            domain: "Purchase",
            code: -3,
            userInfo: [
                NSLocalizedDescriptionKey: "Error while purchasing"
            ]
        )
    }
    
    static func purchaseInProgressError() -> NSError {
        return NSError(
            domain: "Purchase",
            code: -4,
            userInfo: [
                NSLocalizedDescriptionKey: "An another pruchase is still processing"
            ]
        )
    }
}
