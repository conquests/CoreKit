//
//  Game.swift
//  Emojipoverb
//
//  Created by Tibor Bödecs on 2018. 02. 23..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//


#if os(iOS)
import StoreKit

extension Notification.Name {
    static let TransactionStoreNotification = Notification.Name("TransactionStoreNotification")
}

open class TransactionStore: NSObject  {
    
    fileprivate let productIdentifiers: Set<String>
    fileprivate var purchasedProductIdentifiers = Set<String>()
    
    fileprivate var productsRequest: SKProductsRequest?
    fileprivate var productsRequestCompletionHandler: ((_ products: [SKProduct]) -> Void)?
    
    
    public init(productIds: Set<String>) {
        
        self.productIdentifiers = productIds

        for productIdentifier in productIds {
            let purchased = UserDefaults.standard.bool(forKey: productIdentifier)

            if purchased {
                self.purchasedProductIdentifiers.insert(productIdentifier)
            }
        }
        
        super.init()
        
        SKPaymentQueue.default().add(self)
    }

    deinit {
        self.productsRequest?.cancel()
        self.productsRequest?.delegate = nil
        SKPaymentQueue.default().remove(self)
    }
    
}

extension TransactionStore {

    func addObserver(_ object: Any, selector: Selector) {
        NotificationCenter.default.addObserver(object, selector: selector, name: .TransactionStoreNotification, object: nil)
    }
}

extension TransactionStore {
    
    public func requestProducts(completionHandler: @escaping ((_ products: [SKProduct]) -> Void)) {
        self.productsRequest?.cancel()
        self.productsRequestCompletionHandler = completionHandler
        
        self.productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        self.productsRequest?.delegate = self
        self.productsRequest?.start()
    }
    
    public func buy(_ product: SKProduct) {
        SKPaymentQueue.default().add(SKPayment(product: product))
    
    }
    
    public func isPurchased(_ productIdentifier: String) -> Bool {
        return self.purchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


extension TransactionStore: SKProductsRequestDelegate {

    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        self.productsRequestCompletionHandler?(products)
        self.clearRequestAndHandler()
        
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        self.productsRequestCompletionHandler?([])
        self.clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler() {
        self.productsRequest = nil
        self.productsRequestCompletionHandler = nil
    }
}


extension TransactionStore: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                self.complete(transaction)
                break
            case .failed:
                self.fail(transaction)
                break
            case .restored:
                self.restore(transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            }
        }
    }
    
    private func complete(_ transaction: SKPaymentTransaction) {
        self.deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier, success: true)
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restore(_ transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        self.deliverPurchaseNotificationFor(identifier: productIdentifier, success: true)
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(_ transaction: SKPaymentTransaction) {
        self.deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier, success: false)

        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String, success: Bool) {
        if success {
            self.purchasedProductIdentifiers.insert(identifier)
            UserDefaults.standard.set(true, forKey: identifier)
            UserDefaults.standard.synchronize()
        }
        NotificationCenter.default.post(name: .TransactionStoreNotification, object: identifier, userInfo: ["success": success])
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        NotificationCenter.default.post(name: .TransactionStoreNotification, object: nil)
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        NotificationCenter.default.post(name: .TransactionStoreNotification, object: nil)
    }
    
}
#endif
