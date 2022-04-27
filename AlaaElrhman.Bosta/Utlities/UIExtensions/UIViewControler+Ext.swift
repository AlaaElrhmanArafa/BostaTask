//
//  UIViewControler+Ext.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation
import UIKit


extension UIViewController{
    func startAnimate(){
        let size = CGSize(width: 60, height: 60)
        let activity = UIActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: size))
        activity.tag = 101010101
        activity.style = .medium
        activity.hidesWhenStopped = true
        self.view.addSubview(activity)
    }
    
    func stopAnimate(){
        if let activity = self.view.viewWithTag(101010101) as? UIActivityIndicatorView{
            activity.stopAnimating()
            activity.removeFromSuperview()
        }
    }
    
    func alertError(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { action in
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
