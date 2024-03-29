//
//  BaseViewController.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loader: UIActivityIndicatorView?
    private var loaderView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (loader, loaderView) = view.addMainLoaderWithView()
    }
    
    // MARK: - Error
    
    func showAlert(withErrorMessage message: String, externalAction: UIAlertAction?) {
        
        loading = false
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        if let action = externalAction {
            alert.addAction(action)
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Loader
    var loading = false {
        didSet {
            loaderView?.isHidden = !loading
            loading ? loader?.startAnimating() : loader?.stopAnimating()
        }
    }
}
