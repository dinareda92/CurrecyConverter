//
//  RoundDDL.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import Foundation
import UIKit

@IBDesignable class RoundDDL: UITextField {

    var isFocusedBefore: Bool = false
    
    var _format: FontStyle = FontStyle()
    @IBInspectable
    var fontStyleName: String = FontStyle.sfProTextBlack12.rawValue {
        didSet {
            if self.fontStyleName == FontStyle.sfProTextRegular18.rawValue {
                self._format = FontStyle.sfProTextRegular18
            } else if(self.fontStyleName == FontStyle.sfProTextBlack16.rawValue ) {
                self._format = FontStyle.sfProTextBlack16
            } else if(self.fontStyleName == FontStyle.sfProTextHeavy14.rawValue ) {
                self._format = FontStyle.sfProTextHeavy14
            } else if(self.fontStyleName == FontStyle.sfProTextBold14.rawValue ) {
                self._format = FontStyle.sfProTextBold14
            } else if(self.fontStyleName == FontStyle.sfProTextHeavy13.rawValue ) {
                self._format = FontStyle.sfProTextHeavy13
            } else if(self.fontStyleName == FontStyle.cairoBold13.rawValue ) {
                self._format = FontStyle.cairoBold13
            } else if(self.fontStyleName == FontStyle.sfProTextBold13.rawValue ) {
                self._format = FontStyle.sfProTextBold13
            } else if(self.fontStyleName == FontStyle.sfProDisplayMedium13.rawValue ) {
                self._format = FontStyle.sfProDisplayMedium13
            } else if(self.fontStyleName == FontStyle.sfProTextMedium12.rawValue ) {
                self._format = FontStyle.sfProTextMedium12
            } else if(self.fontStyleName == FontStyle.sfProTextMedium10.rawValue ) {
                self._format = FontStyle.sfProTextMedium10
            } else if(self.fontStyleName == FontStyle.sfProTextBold12.rawValue ) {
                self._format = FontStyle.sfProTextBold12
            } else if(self.fontStyleName == FontStyle.sfProTextBlack12.rawValue ) {
                self._format = FontStyle.sfProTextBlack12
            }
            //setStyleAndText()
            //self.setNeedsDisplay()
        }
    }

    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
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

    func showtoolbar(_ piker: UIPickerView) -> UIToolbar {

        self.inputView = piker

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
        return toolBar
    }
    func removeToolbar() {
        self.inputView = nil
        self.inputAccessoryView = nil
        self.removeCustomAccessories()
    }
    func showtoolbar(_ piker: UIDatePicker) -> UIToolbar {

        self.inputView = piker

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar

        return toolBar
    }
    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            refreshBorder(borderWidth: borderWidth)
        }
    }

    func refreshBorder(borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
    }

    @IBInspectable var customBorderColor: UIColor = UIColor.red {
        didSet {
            refreshBorderColor(colorBorder: customBorderColor)
        }
    }

    func refreshBorderColor(colorBorder: UIColor) {
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
        refreshCorners(value: cornerRadius)
        refreshBorderColor(colorBorder: customBorderColor)
        refreshBorder(borderWidth: borderWidth)
        //setStyleAndText()
    }

//    func setStyleAndText() {
//        self.textColor = Asset.textColor.color
//        if Globals.getcurrentlangauage() == Lang.AR {
//            self.attributedPlaceholder = NSAttributedString(
//                string: self.placeholder ?? "",
//                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.cairoBold13 ])
//            self.font = UIFont.cairoBold12
//
//        } else {
//            self.attributedPlaceholder = NSAttributedString(
//                string: self.placeholder ?? "",
//                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.sfProTextRegular13 ])
//            self.font = _format.FontFormat()
//        }
//    }

}
