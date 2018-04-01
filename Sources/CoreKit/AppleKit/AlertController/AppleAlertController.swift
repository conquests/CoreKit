//
//  AppleAlertController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 31..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
public typealias AppleAlertController = UIAlertController
public typealias AppleAlertAction = UIAlertAction
#elseif os(macOS)

open class AppleAlertAction {
    
    open var title: String
    open var handler: (AppleAlertAction) -> Void
    
    public init(title: String, handler: @escaping (AppleAlertAction) -> Void) {
        self.title = title
        self.handler = handler
    }
}

open class AppleAlertController: NSObject {
    
    open var title: String
    open var message: String
    open var style:  NSAlert.Style
    
    private var actions: [AppleAlertAction]
    
    public init(title: String, message: String, alertStyle: NSAlert.Style = .warning) {
        self.title = title
        self.message = message
        self.style = alertStyle
        
        self.actions = []
        
        super.init()
    }
    
    public func addAction(_ action: AppleAlertAction) {
        self.actions.append(action)
    }
    
    fileprivate func prepare(for window: NSWindow) -> NSAlert {
        let alert = NSAlert()
        
        alert.messageText = self.title
        alert.informativeText = self.message
        alert.alertStyle = self.style
        
        for (index, action) in self.actions.enumerated() {
            let button = alert.addButton(withTitle: action.title)
            button.tag = index
            button.target = self
            button.action = #selector(self.handleButtonAction(_:))
        }
        return alert
    }
    
    @objc func handleButtonAction(_ sender: NSButton) {
        let action = self.actions[sender.tag]
        action.handler(action)
    }
}

public extension AppleViewController {
    
    public func present(alert: AppleAlertController) {
        guard let window = self.view.window else {
            return
        }
        let alert = alert.prepare(for: window)
        alert.beginSheetModal(for: window, completionHandler: nil)
        alert.runModal()
    }
}

#endif
