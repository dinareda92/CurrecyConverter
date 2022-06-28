//
//  RoundTextField.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import UIKit
import JMMaskTextField_Swift

@IBDesignable class RoundTextField: MyJMMaskTextField {

    var isFocusedBefore: Bool = false
    
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: paddingValue, bottom: 0, right: paddingValue)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    @IBInspectable var paddingValue: CGFloat = 14

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            refreshBorder(borderWidth)
        }
    }
    
    @IBInspectable var leftImagePadding: CGFloat = 0
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    func refreshBorder(_ borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
    }
    
    var languageCode:String? {
            didSet {
                if self.isFirstResponder {
                    self.resignFirstResponder()
                    self.becomeFirstResponder()
                }
            }
        }

        override var textInputMode: UITextInputMode? {
            if let language_code = self.languageCode {
                for keyboard in UITextInputMode.activeInputModes {
                    if let language = keyboard.primaryLanguage {
                        let locale = Locale.init(identifier: language)
                        if locale.languageCode == language_code {
                            return keyboard
                        }
                    }
                }
            }
            return super.textInputMode;
        }

    @IBInspectable var customBorderColor: UIColor = UIColor.white {
        didSet {
            refreshBorderColor(customBorderColor)
        }
    }

    func refreshBorderColor(_ colorBorder: UIColor) {
        layer.borderColor = colorBorder.cgColor
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        // Common logic goes here
        refreshCorners(value: cornerRadius)
        refreshBorderColor(customBorderColor)
        refreshBorder(borderWidth)
       // self.textColor = Asset.textColor.color
        //setStyleAndText()
    }

//    func setStyleAndText() {
//        if Globals.getcurrentlangauage() == Lang.AR {
//            self.attributedPlaceholder = NSAttributedString(
//                string: self.placeholder ?? "",
//                attributes: [NSAttributedString.Key.foregroundColor: Asset._8e99a4.color, NSAttributedString.Key.font: UIFont.cairoBold13 ])
//            self.font = UIFont.cairoBold12
//
//        } else {
//            self.attributedPlaceholder = NSAttributedString(
//                string: self.placeholder ?? "",
//                attributes: [NSAttributedString.Key.foregroundColor: Asset._8e99a4.color, NSAttributedString.Key.font: UIFont.sfProTextMedium12 ])
//            self.font = UIFont.sfProTextMedium12
//        }
//    }

}

private var maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let res = maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return res
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let txt = textField.text {
            textField.text = String(txt.prefix(maxLength))
        }
    }
}

extension RoundTextField {
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftImagePadding
        return textRect
    }
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}
