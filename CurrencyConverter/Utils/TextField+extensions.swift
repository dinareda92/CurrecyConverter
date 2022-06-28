//
//  TextFieldError.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import Foundation
import UIKit
enum TextFieldTypes: Int {
    case pass = 1
    case idNumber = 2
    case date = 3
    case investor = 4
    case legalType = 5
    case licenseType = 6
    case activities = 7
    case ddl = 8
}
enum TextFieldIconDirection: Int {
    case left = 1
    case right = 2
}
extension UITextField {

    func setSearchicon() {
        let rightButton  = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "search"), for: .normal)
        rightButton.contentEdgeInsets =  UIEdgeInsets(top: 13, left: 18, bottom: 13, right: 18)
        rightButton.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        self.rightViewMode = .always
        self.rightView = rightButton
    }

    func setpasswordtoggleicon() {
        let rightButton  = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "ShowPassword"), for: .normal)
        rightButton.contentEdgeInsets =  UIEdgeInsets(top: 2, left: 14, bottom: 2, right: 14)
        rightButton.frame = CGRect(x: 0, y: 0, width: 44, height: 22)

        self.rightViewMode = .always
        self.rightView = rightButton
        rightButton.addTarget(self, action: #selector(self.iconAction(_:)), for: .touchUpInside)
        if !self.text!.isEmpty {
            rightButton.alpha = 1
        } else {
            rightButton.alpha = 0.5
        }
    }
    
    func removeCustomAccessories() {
        self.rightView = nil
        self.leftView = nil
    }
    
    func setCustomAccessories(tag: TextFieldTypes?,
                              icon: UIImage?,
                              iconDirection: TextFieldIconDirection?,
                              placeholder: String?,
                              fieldFont: UIFont? = nil,
                              placeDirection: TextFieldIconDirection? = nil,
                              notClickable: Bool? = false) -> UIButton {
        let rightButton  = UIButton(type: .custom)
        let rightPlace = UIButton(type: .custom)
        if let img = icon {
            rightButton.setImage(img, for: .normal)
            rightButton.contentEdgeInsets =  UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
            rightButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        }
        
        if notClickable ?? false {
            rightButton.isUserInteractionEnabled = false
        }

        if let direction = iconDirection {
            if direction == .right {
                self.rightViewMode = .always
                self.rightView = rightButton
            } else {
                self.leftViewMode = .always
                self.leftView = rightButton
            }
        }
        
        if let placeDirection = placeDirection {
            if placeDirection == .right {
                self.rightViewMode = .always
                self.rightView = rightPlace
                rightPlace.setTitle(placeholder, for: .normal)
//                rightPlace.setTitleColor(Asset._8e99a4.color, for: .normal)
//                rightPlace.titleLabel?.font = Globals.isRTL ? UIFont.cairoBold10 : UIFont.sfProTextBold10
                rightPlace.contentEdgeInsets =  UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
                rightPlace.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
            }
        }
        switch tag {
        case .ddl:
            rightButton.addTarget(self, action: #selector(self.iconActiondd(_:)), for: .touchUpInside)
        case .pass:
            rightButton.addTarget(self, action: #selector(self.iconActiondd(_:)), for: .touchUpInside)

        case .idNumber :
            break

        case .date:
            break

        default :
            break
            //self.becomeFirstResponder()
        }

        if placeDirection == nil {
            self.placeholder = placeholder
        }
        if let ffont = fieldFont {
            self.font = ffont
        }

        return rightButton
    }
    
    func setCustomAccessories(tag: TextFieldTypes?,
                              icon: UIImage?,
                              iconDirection: TextFieldIconDirection?,
                              fieldFont: UIFont? = nil,
                              placeDirection: TextFieldIconDirection? = nil,
                              notClickable: Bool? = false) -> UIButton {
        let rightButton  = UIButton(type: .custom)
        let rightPlace = UIButton(type: .custom)
        if let img = icon {
            rightButton.setImage(img, for: .normal)
            rightButton.contentEdgeInsets =  UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
            rightButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        }
        
        if notClickable ?? false {
            rightButton.isUserInteractionEnabled = false
        }

        if let direction = iconDirection {
            if direction == .right {
                self.rightViewMode = .always
                self.rightView = rightButton
            } else {
                self.leftViewMode = .always
                self.leftView = rightButton
            }
        }
        
        if let placeDirection = placeDirection {
            if placeDirection == .right {
                self.rightViewMode = .always
                self.rightView = rightPlace
                rightPlace.setTitle(placeholder, for: .normal)
//                rightPlace.setTitleColor(Asset._8e99a4.color, for: .normal)
//                rightPlace.titleLabel?.font = Globals.isRTL ? UIFont.cairoBold10 : UIFont.sfProTextBold10
                rightPlace.contentEdgeInsets =  UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
                rightPlace.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
            }
        }
        switch tag {
        case .ddl:
            rightButton.addTarget(self, action: #selector(self.iconActiondd(_:)), for: .touchUpInside)
        case .pass:
            rightButton.addTarget(self, action: #selector(self.iconActiondd(_:)), for: .touchUpInside)

        case .idNumber :
            break

        case .date:
            break

        default :
            break
            //self.becomeFirstResponder()
        }

//        if placeDirection == nil {
//            self.placeholder = placeholder
//        }
        if let ffont = fieldFont {
           // self.font = ffont
        }

        return rightButton
    }

    @objc func iconAction(_ sender: UIButton) {

        self.isSecureTextEntry.toggle()
    }
    @objc func iconActiondd(_ sender: UIButton) {
        self.becomeFirstResponder()
    }
    //    func validatedText(validationType: ValidatorType) throws -> String {
    //        let validator = VaildatorFactory.validatorFor(type: validationType)
    //        return try validator.validated(self.text!)
    //    }
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }

    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

}
