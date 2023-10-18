//
//  Keyboard + Ext.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.09.2023.
//

import Foundation
  import UIKit

   extension UIApplication {
       func addTapGestureRecognizer() {
           guard let window = windows.first else { return }
           let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
           tapGesture.requiresExclusiveTouchType = false
           tapGesture.cancelsTouchesInView = false
           tapGesture.delegate = self
           window.addGestureRecognizer(tapGesture)
       }
   }

   extension UIApplication: UIGestureRecognizerDelegate {
       public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           return true // set to `false` if you don't want to detect tap during other gestures
       }
   }
