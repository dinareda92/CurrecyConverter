//
//  CurrencyUseCase.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/25/22.
//

import Foundation

import RxSwift

protocol CurrencyUseCaseType {
    func getLatest(base:String) ->Observable<Latest>
}

final class CurrencyUseCase: CurrencyUseCaseType {
   
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func getLatest(base:String) -> Observable<Latest> {
        networkManager.load(endpoint: CurrencyAPI.latest , Params: ["base":base] )
    }
    
}
