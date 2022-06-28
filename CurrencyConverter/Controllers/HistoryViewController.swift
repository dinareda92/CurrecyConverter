//
//  HistoryViewController.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/26/22.
//


import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: BaseViewController {
    
    @IBOutlet weak var baseCurrency_lbl: UILabel!
    @IBOutlet weak var latestCurrenciesTableView: UITableView!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    private var network = NetworkManager()
    fileprivate lazy var useCase = CurrencyUseCase(networkManager: network)
    var viewModel: CurrencyConverter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            viewModel = CurrencyConverter(useCase: useCase)
        }
        initView()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getLatest()
        getHistoryRecord()
    }
    
    func initView() {
        latestCurrenciesTableView.register(UINib(nibName: "latestTableViewCell", bundle: nil), forCellReuseIdentifier: "latestTableViewCell")
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    func getHistoryRecord() {
        if let data = UserDefaults.standard.data(forKey: "HistoryRecords") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode history
                let records = try decoder.decode([HistoryRecordElement].self, from: data)
                viewModel.history.accept(records)
                //let filtered = Array(Dictionary(grouping:records){$0.date}.values)
                
            } catch {
                print("Unable to Decode history (\(error))")
            }
        }
       

    }
    
    func bindViewModel() {
        viewModel.latest.bind(to: self.latestCurrenciesTableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            self.baseCurrency_lbl.text = "Base Currency: EUR"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "latestTableViewCell", for: indexPath) as? latestTableViewCell else {
                return UITableViewCell()
            }
            
            cell.currencyKey.text = element.key ?? ""
            cell.currencyRate.text = "\(element.value ?? 0)"
              
            return cell
        }.disposed(by: disposeBag)
        
        viewModel.history.bind(to: self.historyTableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
           
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else {
                return UITableViewCell()
            }
            
            cell.date.text = element.date
            cell.from.text = element.from! + " <To>"
            cell.to.text = element.to
              
            return cell
        }.disposed(by: disposeBag)
        
    }
    
    
    
}
