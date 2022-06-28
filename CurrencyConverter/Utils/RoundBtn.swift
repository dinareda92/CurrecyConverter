//
//  RoundBtn.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import UIKit

public enum FontStyle: String {
    case sfProTextLight32
    case sfProTextRegular11
    case sfProTextRegular12
    case sfProTextRegular13
    case sfProTextRegular14
    case sfProTextRegular15
    case sfProTextRegular16
    case sfProTextRegular18
    case sfProTextRegular20
    
    case sfProTextBlack12
    case sfProTextBlack13
    case sfProTextBlack14
    case sfProTextBlack16
    case sfProTextBlack17
    case sfProTextBlack20
    case sfProTextBlack22
    case sfProTextBlack32
    
    case sfProTextHeavy12
    case sfProTextHeavy13
    case sfProTextHeavy14
    case sfProTextHeavy18
    
    case sfProTextBold10
    case sfProTextBold11
    case sfProTextBold12
    case sfProTextBold13
    case sfProTextBold14
    case sfProTextBold16
    case sfProTextBold18
    case sfProTextBold20
    case sfProTextBold24
    
    case sfProTextMedium10
    case sfProTextMedium12
    case sfProTextMedium13
    case sfProTextMedium14
    case sfProTextMedium16
    case sfProTextMedium17
    case sfProTextMedium20
    
    case sfProTextSemiBold17
    case sfProTextSemiBold16
    case sfProTextSemiBold12
    case sfProDisplayMedium10
    case sfProDisplayMedium11
    case sfProDisplayMedium12
    case sfProDisplayMedium13
    case sfProDisplayMedium14
    case sfProDisplayMedium17
    case sfProDisplayMedium16
    case sfProTextLight48
    
    
    case cairoBold9
    case cairoBold10
    case cairoBold11
    case cairoBold12
    case cairoBold13
    case cairoBold14
    case cairoBold16
    case cairoBold17
    case cairoBold18
    case cairoBold20
    case cairoBold40
    
    
    public init() {
        self = .sfProTextBlack16
    }
}

@IBDesignable class RoundButton: UIButton {
    var _format: FontStyle = FontStyle()
    @IBInspectable
    var fontStyleName: String = FontStyle.sfProTextBlack16.rawValue {
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
            } else if(self.fontStyleName == FontStyle.sfProDisplayMedium14.rawValue ) {
                self._format = FontStyle.sfProDisplayMedium14
            } else if(self.fontStyleName == FontStyle.sfProTextHeavy18.rawValue ) {
                self._format = FontStyle.sfProTextHeavy18
            } else if(self.fontStyleName == FontStyle.sfProTextRegular13.rawValue ) {
                self._format = FontStyle.sfProTextRegular13
            } else if(self.fontStyleName == FontStyle.sfProTextBold11.rawValue ) {
                self._format = FontStyle.sfProTextBold11
            } else if(self.fontStyleName == FontStyle.cairoBold14.rawValue ) {
                self._format = FontStyle.cairoBold14
            } else if(self.fontStyleName == FontStyle.sfProTextBold16.rawValue ) {
                self._format = FontStyle.sfProTextBold16
            } else if(self.fontStyleName == FontStyle.cairoBold17.rawValue ) {
                self._format = FontStyle.cairoBold17
            } else if(self.fontStyleName == FontStyle.cairoBold16.rawValue ) {
                self._format = FontStyle.cairoBold16
            } else if(self.fontStyleName == FontStyle.sfProTextSemiBold17.rawValue ) {
                self._format = FontStyle.sfProTextSemiBold17
            } else if(self.fontStyleName == FontStyle.sfProTextSemiBold12.rawValue ) {
                self._format = FontStyle.sfProTextSemiBold12
            }
            //setStyleAndText(value: localizeKey)
            self.setNeedsDisplay()

        }
    }
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            refreshBorder(borderWidth)
        }
    }

    func refreshBorder(_ borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
    }
    @IBInspectable var customBorderColor: UIColor = UIColor.init(red: 231/255, green: 231/255, blue: 231/255, alpha: 1) {
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
        //setStyleAndText(value: localizeKey)
    }
//    func setStyleAndText(value: String) {
//       // print("buttton :" + value)
//
//        if Globals.getcurrentlangauage() == Lang.AR {
//            self.semanticContentAttribute = .forceRightToLeft
//            self.titleLabel?.textAlignment = .right
//            self.titleLabel?.font =  UIFont.cairoBold13
//            if btnViewControllerOwnerFlag == "NotificationByViewController" {
//                self.titleEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
//                self.imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
//            }
//        } else {
//            self.semanticContentAttribute = .forceLeftToRight
//            self.titleLabel?.textAlignment = .left
//            self.titleLabel?.font =  _format.FontFormat()
//        }
//    }
}
