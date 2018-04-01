//
//  WebViewController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 01..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)
import WebKit

open class WebViewController: ViewController {

    open var url: URL?
    open weak var indicatorView: UIActivityIndicatorView!
    open weak var webView: WKWebView!
    
    open var selected: ((URL) -> Void)?

    open override func loadView() {
        super.loadView()

        let webView = WKWebView(autolayout: true)
        self.webView = webView
        self.view.addSubview(self.webView)
        self.webView.fillAnchors(toView: self.view)

        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.indicatorView = indicatorView
        self.view.addSubview(self.indicatorView)
        self.indicatorView.centerAnchors(toView: self.view)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.scrollView.delegate = self
        self.webView.navigationDelegate = self

        self.indicatorView.hidesWhenStopped = true
        self.indicatorView.startAnimating()

        guard let url = self.url else {
            return
        }
        self.webView.load(URLRequest(url: url))
    }
}

extension WebViewController: WKNavigationDelegate {

    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }

    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView.stopAnimating()
    }

    open func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard
            navigationAction.navigationType == .linkActivated,
            let url = navigationAction.request.url
        else {
            return decisionHandler(.allow)
        }
        self.selected?(url)
        decisionHandler(.cancel)
    }
}

extension WebViewController: UIScrollViewDelegate {

    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}
#endif

