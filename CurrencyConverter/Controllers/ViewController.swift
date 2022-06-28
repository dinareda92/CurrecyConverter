//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController : UIViewController {
    var disposeBag = DisposeBag()
    
    func AddToUserDefaultes(value:Any ,Key:String) {
        UserDefaults.standard.setValue(value, forKey: Key)
    }
    
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
}

class ViewController: BaseViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var fromCurrencyDDL: RoundDDL!
    @IBOutlet weak var toCurrencyDDL: RoundDDL!
    @IBOutlet weak var switchCurrencyBtn: RoundButton!
    
    @IBOutlet weak var fromCurrencyValue: RoundTextField!
    
    @IBOutlet weak var toCurrencyValue: RoundTextField!
    
    // variables
    var fromCurrencyPickerView:UIPickerView!
    var toCurrencyPickerView:UIPickerView!
    private var network = NetworkManager()
    fileprivate lazy var useCase = CurrencyUseCase(networkManager: network)
    var viewModel: CurrencyConverter!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureInputs()
        configurePicker()
        fromCurrencyValue.delegate = self
        toCurrencyValue.delegate = self
        if viewModel == nil {
            viewModel = CurrencyConverter(useCase: useCase)
        }
        self.showLoader()
        viewModel.getLatest()
        bindViewModel()
    }
    
    //MARK:- Binding ViewModel
    
    func bindViewModel() {
        bind(textField: fromCurrencyDDL, to: viewModel.fromCurrencyName, disposeBag: disposeBag)
        bind(textField: toCurrencyDDL, to: viewModel.toCurrencyName, disposeBag: disposeBag)
        bind(textField: fromCurrencyValue, to: viewModel.FromValue, disposeBag: disposeBag)
        bind(textField: toCurrencyValue, to: viewModel.toValue, disposeBag: disposeBag)
        
        viewModel.latest.bind(to:
                fromCurrencyPickerView.rx.itemTitles
        ){ _, item in
            return item.key
            
        }.disposed(by: disposeBag)
        
        viewModel.latest.bind(to:
                toCurrencyPickerView.rx.itemTitles
        ){ _, item in
            return item.key
            
        }.disposed(by: disposeBag)
        
        setUpCellhandling()
        
        viewModel.convertionResult.subscribe({ val in
            if self.viewModel.convertionDirection.value == .From {
                self.toCurrencyValue.text = val.element
            }else{
                self.fromCurrencyValue.text = val.element
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.latest.asObservable().bind { value in
            if value.count > 0 {
                DispatchQueue.main.async {
                    self.dismiss(animated: false, completion: nil)
                }
               
            }
        }.disposed(by: disposeBag)
    }
    
    func setUpCellhandling() {
        fromCurrencyPickerView.rx.modelSelected(LatestElement.self)
            .subscribe(onNext:{ [weak self] result in
                self?.fromCurrencyDDL.text = result[0].key
                self?.viewModel.fromCurrencyName.accept(result[0].key ?? "")
                self?.viewModel.fromCurrencyRate.accept(result[0].value ?? 0)
                self?.AddToUserDefaultes(value: result[0].key ?? "", Key: "fromCurrencySymbol")
                self?.AddToUserDefaultes(value: result[0].value ?? 0, Key: "fromCurrencyRate")
                self?.handleConvertion()
            }).disposed(by: disposeBag)
        
        toCurrencyPickerView.rx.modelSelected(LatestElement.self)
            .subscribe(onNext:{ [weak self] result in
                self?.toCurrencyDDL.text = result[0].key
                self?.viewModel.toCurrencyName.accept(result[0].key ?? "")
                self?.viewModel.toCurrencyRate.accept(result[0].value ?? 0)
                self?.AddToUserDefaultes(value: result[0].key ?? "", Key: "toCurrencySymbol")
                self?.AddToUserDefaultes(value: result[0].value ?? 0, Key: "toCurrencyRate")
                self?.handleConvertion()
            }).disposed(by: disposeBag)
    }
    
    func handleConvertion() {
        if (viewModel.toCurrencyName.value != "" && viewModel.fromCurrencyName.value != "") && (viewModel.FromValue.value != "" || viewModel.toValue.value != "" ){
             
            convert(fromRate: viewModel.fromCurrencyRate.value, toRate: viewModel.toCurrencyRate.value, amount: viewModel.FromValue.value, convertionDirection:viewModel.convertionDirection.value)
            
        }
    }
    //MARK:- Switch Currency Button Action
    
    @IBAction func SwitchCurrency(_ sender: Any) {
        let toSymbol = UserDefaults.standard.object(forKey: "toCurrencySymbol") as! String
        let toRate = UserDefaults.standard.object(forKey: "toCurrencyRate") as! Double
        fromCurrencyDDL.text = toSymbol
        viewModel.fromCurrencyName.accept(toSymbol)
        viewModel.fromCurrencyRate.accept(toRate)
        AddToUserDefaultes(value: viewModel.fromCurrencyName.value, Key: "fromCurrencySymbol")
        AddToUserDefaultes(value:  viewModel.fromCurrencyRate.value, Key: "fromCurrencyRate")
        let fromSymbol = UserDefaults.standard.object(forKey: "fromCurrencySymbol") as! String
        let fromRate = UserDefaults.standard.object(forKey: "fromCurrencyRate") as! Double
        toCurrencyDDL.text = fromSymbol
        viewModel.toCurrencyName.accept(fromSymbol)
        viewModel.toCurrencyRate.accept(fromRate)
        AddToUserDefaultes(value: viewModel.toCurrencyName.value, Key: "toCurrencySymbol")
        AddToUserDefaultes(value:viewModel.toCurrencyRate.value, Key: "toCurrencyRate")
        toCurrencyPickerView.reloadAllComponents()
        fromCurrencyPickerView.reloadAllComponents()
    }
    
    //MARK:- convert business
    
    func convert(fromRate: Double, toRate: Double, amount: String, convertionDirection:CurrencyPickerTag) {
        self.viewModel.convertionDirection.accept(convertionDirection)
        let Amount = Double(amount)
        var convertedValue = 0.0
        if convertionDirection == .From {
            convertedValue = toRate / (Amount ?? 1 * fromRate)
        }else{
            convertedValue = fromRate / (Amount ?? 1 * toRate) 
        }
        self.viewModel.convertionResult.onNext("\(convertedValue)")
        
        self.addHistoryToUserDefaults()
    }
    
    func addHistoryToUserDefaults() {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let str = df.string(from: Date())
        if let data = UserDefaults.standard.data(forKey: "HistoryRecords") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode history
                var records = try decoder.decode([HistoryRecordElement].self, from: data)
                records.append(HistoryRecordElement(date:str , from: viewModel.fromCurrencyName.value , to: viewModel.toCurrencyName.value ))
                do {
                    // Create JSON Encoder
                    let encoder = JSONEncoder()

                    // Encode history
                    let data = try encoder.encode(records)

                    // Write/Set Data
                    UserDefaults.standard.set(data, forKey: "HistoryRecords")

                } catch {
                    print("Unable to Encode Array of history (\(error))")
                }
            } catch {
                print("Unable to Decode history (\(error))")
            }
        }else{
            do {
                let record = HistoryRecordElement(date:str, from: viewModel.fromCurrencyName.value, to: viewModel.toCurrencyName.value )
                // Create JSON Encoder
                let encoder = JSONEncoder()

                // Encode history
                let data = try encoder.encode([record])

                // Write/Set Data
                UserDefaults.standard.set(data, forKey: "HistoryRecords")

            } catch {
                print("Unable to Encode Array of history (\(error))")
            }
        }
    }
   
    
    @objc func toolbarpresdone(sender: AnyObject?) {
            self.view.endEditing(true)
            switch sender?.tag {
                
            case CurrencyPickerTag.From.rawValue:
                if !viewModel.latest.value.isEmpty && viewModel.fromCurrencyName.value == "" {
                    viewModel.fromCurrencyName.accept(viewModel.latest.value[0].key ?? "")
                    fromCurrencyDDL.text = viewModel.latest.value[0].key
                    viewModel.fromCurrencyRate.accept(viewModel.latest.value[0].value ?? 0)
                }
               
        case CurrencyPickerTag.To.rawValue:
            if !viewModel.latest.value.isEmpty && viewModel.toCurrencyName.value == ""
                {
                viewModel.toCurrencyName.accept(viewModel.latest.value[0].key ?? "")
                toCurrencyDDL.text = viewModel.latest.value[0].key
                viewModel.toCurrencyRate.accept(viewModel.latest.value[0].value ?? 0)
                }
            print("")
                
            default:
                break
                
            }
        }
}

//MARK:- Pickers configrations
extension ViewController {
    
    func configureInputs() {
        _ = self.fromCurrencyDDL.setCustomAccessories(
            tag: .ddl,
            icon: UIImage(systemName: "arrowtriangle.down.fill"),
            iconDirection: .right)
        
        _ = self.toCurrencyDDL.setCustomAccessories(
            tag: .ddl,
            icon: UIImage(systemName: "arrowtriangle.down.fill"),
            iconDirection: .right)
        
        fromCurrencyValue.keyboardType = .asciiCapableNumberPad
        fromCurrencyValue.tag = 0
        toCurrencyValue.keyboardType = .asciiCapableNumberPad
        toCurrencyValue.tag = 1
    }
    
    func configurePicker() {
                
                self.fromCurrencyPickerView = UIPickerView(width: self.view.frame.size.width)
                fromCurrencyPickerView.tag = CurrencyPickerTag.From.rawValue

                self.toCurrencyPickerView = UIPickerView(width: self.view.frame.size.width)
                toCurrencyPickerView.tag = CurrencyPickerTag.To.rawValue
                
                let toolBarFrom = self.fromCurrencyDDL.showtoolbar(fromCurrencyPickerView)
                let toolBarTo = self.toCurrencyDDL.showtoolbar(toCurrencyPickerView)
                
                toolBarFrom.barTintColor = UIColor.blue
                toolBarTo.barTintColor = UIColor.blue

                initToolbarAction(toolbar: toolBarFrom, tag: CurrencyPickerTag.From.rawValue)
                initToolbarAction(toolbar: toolBarTo, tag: CurrencyPickerTag.To.rawValue)
                
            }
            
            func initToolbarAction(toolbar: UIToolbar, tag: Int) {
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.toolbarpresdone))
                doneButton.tag = tag
                doneButton.title = "Done"
                doneButton.width = UIScreen.main.bounds.width
                toolbar.sizeToFit()
                doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
                toolbar.setItems([doneButton], animated: false)
            }
}

enum CurrencyPickerTag:Int{
    case From = 1
    case To = 2
}

extension ViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            if  viewModel.toCurrencyName.value != "" &&  viewModel.fromCurrencyName.value != "" {
                self.convert(fromRate: viewModel.fromCurrencyRate.value, toRate: viewModel.toCurrencyRate.value, amount: fromCurrencyValue.text!, convertionDirection: .From)
            }
        case 1:
            if  viewModel.toCurrencyName.value != "" &&  viewModel.fromCurrencyName.value != "" {
                self.convert(fromRate: viewModel.toCurrencyRate.value, toRate: viewModel.fromCurrencyRate.value, amount: toCurrencyValue.text!, convertionDirection: .To)
            }
        default:
            break
        }
        return true
    }
}
