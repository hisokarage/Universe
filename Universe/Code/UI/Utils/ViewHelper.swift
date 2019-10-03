//
//  ViewHelper.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit

extension UIView {
    
    func addMainLoaderWithView() -> (UIActivityIndicatorView, UIView) {
        let loaderView = UIView()
        loaderView.frame = frame
        loaderView.center = center
        loaderView.backgroundColor = UIColor(rgb: 0xffffff, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = center
        loadingView.backgroundColor = UIColor(rgb: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let loader = addLoader(onView: loadingView, withStyle: .large)
        loaderView.addSubview(loadingView)
        addSubview(loaderView)
        loaderView.isHidden = true
        return (loader, loaderView)
    }
    
    func addLoader(onView view: UIView, withStyle style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView()
        loader.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        loader.style = style
        loader.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        view.addSubview(loader)
        return loader
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor?.UIColor
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}
