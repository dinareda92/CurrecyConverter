//
//  UIViewController+extensions.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/25/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    
    func bind(textField: UITextField, to behaviorRelay: BehaviorRelay<String>, disposeBag:DisposeBag) {
        behaviorRelay.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        //textField.rx.text.unwrap().bind(to: behaviorRelay).disposed(by: disposeBag)
        //bind(to: behaviorRelay).disposed(by: disposeBag)
        
    }
}
