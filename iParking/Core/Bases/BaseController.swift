//
//  BaseController.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import UIKit

class BaseController: UIViewController, UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        
        setupUI()

        
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                onChangeUIMode(true)
            } else {
                onChangeUIMode(false)
            }
        }
        else {
           onChangeUIMode(false)
        }

        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector:#selector(self.keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector:#selector(self.keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.cancelsTouchesInView = false
        swipeGesture.direction = .down
        swipeGesture.delegate = self
        self.view.addGestureRecognizer(swipeGesture)
    

    }


    /**
     Esta funcion oculta el teclado cuando hace el gesture hacia abajo
     */
    @objc private func handleSwipeGesture() {
        self.view.endEditing(true)
    }
    
    
    /**
     Esta funcion se dispara cuando el sistema muestra el teclado
     - Parameters:
        - keyboardHeight : devuelve el tamaño del teclado
     
     ### Usage Example: ###
     ````
       override func keyboardDidAppear(_ keyboardHeight: CGFloat) {
           wrapperBottomConstraint.constant = keyboardHeight
           updateViewConstraints()
       }
     ````
     */
    public func keyboardDidAppear(_ keyboardHeight: CGFloat) {}
    
    /**
     Esta funcion se dispara cuando se oculta el teclado del sistema
     
     ### Usage Example: ###
     ````
       override func keyboardDidDisappear() {
          wrapperBottomConstraint.constant = 0
          updateViewConstraints()
       }
     ````
     */
    public func keyboardDidDisappear() {}
    
    /**
        Funcion nativa que se dispara cuando el teclado se muestra
     */
    @objc private func keyboardWillAppear(notification: NSNotification){
        let d = notification.userInfo!
        let r = (d[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardDidAppear(r.size.height)
    }
    
    /**
        Funcion nativa que se dispara cuando el teclado se oculta
     */
    @objc private func keyboardWillDisappear(notification: NSNotification){
        keyboardDidDisappear()
    }
    
    public func setupUI() {}
    

    override internal func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                onChangeUIMode(false)
            } else {
                onChangeUIMode(true)
            }
        } else {
            // Fallback on earlier versions
        }
    }

    public func onChangeUIMode(_ isDarkMode: Bool) {}
    
    public func storyboard(by name:String) -> UIStoryboard{
        var storyboard: UIStoryboard!
        storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard
    }

}

