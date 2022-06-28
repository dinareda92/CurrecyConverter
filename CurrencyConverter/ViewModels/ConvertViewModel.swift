//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    
}

class CurrencyConverter:BaseViewModel {
    // From
    var fromCurrencyList = BehaviorRelay<[String]>(value:[""])
    var fromCurrencyListObservable : Observable<[String]>
    var fromCurrencyRate = BehaviorRelay<Double>(value:0)
    var fromCurrencyName = BehaviorRelay<String>(value:"")
    var FromValue = BehaviorRelay<String>(value:"1")
    
    // To
    var toCurrencyList = BehaviorRelay<[String]>(value:[])
    var toCurrencyListObservable : Observable<[String]>
    var toCurrencyRate = BehaviorRelay<Double>(value:0)
    var toCurrencyName = BehaviorRelay<String>(value:"")
    var toValue = BehaviorRelay<String>(value:"")
    var convertionResult = PublishSubject<String>()
    
    //history and latest rates
    var latest = BehaviorRelay<[LatestElement]>(value: [LatestElement(key: "", value: 0)])
    var convertionDirection = BehaviorRelay<CurrencyPickerTag>(value:.From)
    let useCase: CurrencyUseCaseType
    var latestArray = [LatestElement]()
    var history = BehaviorRelay<[HistoryRecordElement]>(value: [HistoryRecordElement(date: "", from: "", to: "")])
    
    init(useCase:CurrencyUseCaseType) {
        self.useCase = useCase
        fromCurrencyListObservable = fromCurrencyList.asObservable()
        toCurrencyListObservable = toCurrencyList.asObservable()
    }

    func getLatest () {
        
        let apiResult = useCase.getLatest(base: "EUR").map( {
            
            $0.rates
        })
        apiResult.map({
           
            let values = Array($0!.values)
            let keys = Array($0!.keys)
            for (index,item) in keys.enumerated() {
                self.latestArray.append(LatestElement(key: item, value: values[index]))
            }
            self.latest.accept(self.latestArray)

        }).subscribe().disposed(by: disposeBag)
       
    }
    
}

