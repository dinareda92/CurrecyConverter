//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import Foundation
import RxSwift

protocol NetworkService {
    func load<T: Codable>(endpoint: Endpoint, Params: [String:String]?) -> Observable<T>
}

struct NetworkManager: NetworkService {
    
    func load<T: Codable>(endpoint: Endpoint, Params: [String:String]?) -> Observable<T> {
        //let url = endpoint.url!
        var items = [URLQueryItem]()
        var myURL = URLComponents(string:  endpoint.url!.absoluteString)
        let param = Params
        for (key,value) in param ?? ["":""] {
            items.append(URLQueryItem(name: key, value: value))
            }
            myURL?.queryItems = items
        
        var request = URLRequest(url: (myURL?.url)! ,timeoutInterval: Double.infinity)
        request.addValue(endpoint.headers, forHTTPHeaderField: "apikey")
        
        return Observable.create { observer -> Disposable in
            let dataTask: URLSessionDataTask = URLSession.shared
                .dataTask(with: request)
                 {  (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let dataOb = data else {
                    observer.onError(NSError(domain: "parsing Error", code: -1, userInfo: [:]))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(T.self, from: dataOb)
                    observer.onNext(response)
                } catch (let error) {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
}

