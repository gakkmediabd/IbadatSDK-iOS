//
//  ZakatCalculationVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 10/8/22.
//

import UIKit
struct ZakatItem {
    var name : String
    var value : Double
    var indexPath : IndexPath
}

class ZakatCalculationVC: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var saveBtn: UIButton!
    fileprivate var netAsset : Double = 0.0
    fileprivate var zakatPay : Double = 0.0
    
    fileprivate var zakatItems : [ZakatItem] = []
    
    fileprivate var parameter : [String : Any] = [:]
    
    
    private var currencyUnit : String{
        return "TK"
    }
    //MARK:- Initial with nib name
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .appWhite
        self.populateZakatItems()
        self.configureTableView()
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                var inset = self.tableView.contentInset
                inset.bottom  =  keyboardHeight - 50
                self.tableView.contentInset = inset
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { notification in
            var inset = self.tableView.contentInset
            inset.bottom  =  0
            self.tableView.contentInset = inset
        }
        
    }
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension ZakatCalculationVC : UITableViewDelegate, UITableViewDataSource{
    
    func configureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NewCalculationHeaderCell.nib, forCellReuseIdentifier: NewCalculationHeaderCell.identifier)
        self.tableView.register(SectionHeaderCell.nib, forCellReuseIdentifier: SectionHeaderCell.identifier)
        self.tableView.register(ZakatInputCell.nib, forCellReuseIdentifier: ZakatInputCell.identifier)
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = .zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1,2,3,4,5,6:
            return 2
        case 8:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell : NewCalculationHeaderCell = tableView.dequeueReusableCell(withIdentifier: NewCalculationHeaderCell.identifier, for: indexPath) as! NewCalculationHeaderCell
            cell.totalAssetLbl.text = ConstantData.txt_total_asset + " : \(currencyUnit) \(self.netAsset)"
            cell.zakatDueLbl.text = ConstantData.txt_jakat_baki + " : \(currencyUnit) \(self.zakatPay)"
            cell.headerInfoLbl.text = ConstantData.txt_title_total_asset
            return cell
        default:
            let cell : ZakatInputCell = tableView.dequeueReusableCell(withIdentifier: ZakatInputCell.identifier, for: indexPath) as! ZakatInputCell
            cell.currencyLbl.text = currencyUnit
            cell.inputTextField.addTarget(self, action: #selector(onInputTextFieldEditingChange(textfield:)), for: .editingChanged)
            
            if let item = zakatItems.first(where: {$0.indexPath == indexPath}){
                if item.value > 0{
                    cell.inputTextField.text =  "\(item.value)"
                }else{
                    cell.inputTextField.text = ""
                }
            }
            
            switch indexPath.section {
            case 1,2,3,4,5,6:
                let item = self.zakatItems.filter { $0.indexPath.section == indexPath.section }
                switch indexPath.row {
                default:
                    cell.titleLbl.text = item[indexPath.row].name
//                    cell.inputTextField.text = item[indexPath.row].value.toSingleDecimaString()
                }
            case 7:
                let item = self.zakatItems.filter { $0.indexPath.section == indexPath.section }
                cell.titleLbl.text = item[indexPath.row].name
//                cell.inputTextField.text = item[indexPath.row].value.toSingleDecimaString()
            case 8:
                let item = self.zakatItems.filter { $0.indexPath.section == indexPath.section }
                switch indexPath.row {
                default:
                    cell.titleLbl.text = item[indexPath.row].name
//                    cell.inputTextField.text = item[indexPath.row].value.toSingleDecimaString()
                }
            default:
                cell.titleLbl.text = ConstantData.title_nogod_taka
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return NewCalculationHeaderCell.height
        default:
            return ZakatInputCell.height
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier) as! SectionHeaderCell
        
        switch section {
        case 1:
            headerCell.titleLbl.text = ConstantData.title_nogod_taka
        case 2:
            headerCell.titleLbl.text = ConstantData.txt_the_amount_of_gold_and_silver
        case 3:
            headerCell.titleLbl.text = ConstantData.title_investment
        case 4:
            headerCell.titleLbl.text = ConstantData.title_asset
        case 5:
            headerCell.titleLbl.text = ConstantData.title_business
        case 6:
            headerCell.titleLbl.text = ConstantData.title_other
        case 7:
            headerCell.titleLbl.text = ConstantData.title_farming
        case 8:
            headerCell.titleLbl.text = ConstantData.title_lialibility
            headerCell.titleLbl.textColor = .red
        default:
            headerCell.titleLbl.text = ""
        }
        
        return headerCell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 8{
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
            footer.backgroundColor = .appWhite
            let btnDone = UIButton(frame:CGRect(x: 16, y: 5, width: tableView.bounds.width - 32, height: 40))
            btnDone.layer.cornerRadius  = 8
            btnDone.backgroundColor = .tintColor
            btnDone.setTitle("ফলাফল", for: .normal)
            btnDone.setTitleColor(.appWhite, for: .normal)
            btnDone.addTarget(self, action: #selector(onZakatCalulationDone), for: .touchDown)
            footer.addSubview(btnDone)
            return footer
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 8{
            return 50
        }
        return 0
    }
    @objc
    func onZakatCalulationDone(){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    fileprivate func updateHeader() {
        let tAsset = self.totalAsset()
        let tLiabilities = self.totalLiabilities()
        let totalAsset =  tAsset - tLiabilities
        self.netAsset = totalAsset
        let zakat = self.calculateZakat(newAsset: self.totalAsset() - self.totalLiabilities())
        self.zakatPay = zakat
        
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NewCalculationHeaderCell {
            cell.totalAssetLbl.text = ConstantData.txt_total_asset + " : \(currencyUnit) \(self.netAsset)"
            cell.zakatDueLbl.text = ConstantData.txt_jakat_baki + " : \(currencyUnit) \(self.zakatPay)"
        }
    }
    
    fileprivate func calculateZakat(newAsset: Double)-> Double {
        let zakat = newAsset * 2.5
        return zakat / 100.0
    }
    
    fileprivate func totalAsset() -> Double {
        var totalAsset : Double = 0.0
        for item in self.zakatItems{
            if item.indexPath.section != 8{
                totalAsset += item.value
            }
        }
        return totalAsset
    }
    
    fileprivate func totalLiabilities() -> Double {
        var totalLiabilities : Double = 0.0
        for item in self.zakatItems{
            if item.indexPath.section == 8{
                totalLiabilities += item.value
            }
        }
        return totalLiabilities
    }
    
    @objc
    func onInputTextFieldEditingChange(textfield: UITextField){
        var v : UIView = textfield
        repeat { v = v.superview! } while !(v is UITableViewCell)
        let cell = v as! ZakatInputCell
        let ip = self.tableView.indexPath(for: cell)!
        let value = textfield.text?.toDouble ?? 0.0
        self.onInputTextfieldEditing(indexPath: ip, value: value)
    }
    
    func onInputTextfieldEditing(indexPath : IndexPath, value: Double){
        for (index,item) in self.zakatItems.enumerated(){
            if item.indexPath == indexPath{
                self.zakatItems[index].value = value
            }
        }
        self.updateHeader()
    }
    
    private func prepareParameters() -> [String : Any]{
        let year = Calendar.current.component(.year, from: Date())
        parameter["year"] = year
        for (index,item) in self.zakatItems.enumerated(){
            switch index {
            case 0:
                parameter["cash"] = item.value
            case 1:
                parameter["cashInBankaccount"] = item.value
            case 2:
                parameter["valueOfGold"] = item.value
            case 3:
                parameter["valueOfSilver"] = item.value
            case 4:
                parameter["stockMarketInvestment"] = item.value
            case 5:
                parameter["otherInvestments"] = item.value
            case 6:
                parameter["houseRent"] = item.value
            case 7:
                parameter["property"] = item.value
            case 8:
                parameter["cashInBusiness"] = item.value
            case 9:
                parameter["products"] = item.value
            case 10:
                parameter["pension"] = item.value
            case 11:
                parameter["otherCapital"] = item.value
            case 12:
                parameter["agriculture"] = item.value
            case 13:
                parameter["creditCardPayment"] = item.value
            case 14:
                parameter["carPayment"] = item.value
            case 15:
                parameter["businessPayment"] = item.value
            case 16:
                parameter["familyloan"] = item.value
            case 17:
                parameter["otherLoans"] = item.value
            
            default:
                print("nothing to add")
            }
        }
        
        parameter["isActive"] = true
        parameter["language"] = "bn"
        return parameter
    }
}


extension ZakatCalculationVC{
    func populateZakatItems(){
        let cash = ZakatItem(name: ConstantData.title_nogod_taka, value: 0.0, indexPath: IndexPath(row: 0, section: 1))
        let cashInBankAccount = ZakatItem(name: ConstantData.title_bank_nogod_taka, value: 0.0, indexPath: IndexPath(row: 1, section: 1))
        let gold = ZakatItem(name: ConstantData.text_gold_amount, value: 0.0, indexPath: IndexPath(row: 0, section: 2))
        let silver = ZakatItem(name: ConstantData.text_silver_amount, value: 0.0, indexPath: IndexPath(row: 1, section: 2))
        let shareMarket = ZakatItem(name: ConstantData.text_share_market, value: 0.0, indexPath: IndexPath(row: 0, section: 3))
        let otherInvestment = ZakatItem(name: ConstantData.text_other_investment, value: 0.0, indexPath: IndexPath(row: 1, section: 3))
        let houseRent = ZakatItem(name: ConstantData.text_house_rent, value: 0.0, indexPath: IndexPath(row: 0, section: 4))
        let asset = ZakatItem(name: ConstantData.title_asset, value: 0.0, indexPath: IndexPath(row: 1, section: 4))
        let cardBusiness = ZakatItem(name: ConstantData.text_nogod_business, value: 0.0, indexPath: IndexPath(row: 0, section: 5))
        let product = ZakatItem(name: ConstantData.text_product, value: 0.0, indexPath: IndexPath(row: 1, section: 5))
        let pension = ZakatItem(name: ConstantData.text_pension, value: 0.0, indexPath: IndexPath(row: 0, section: 6))
        let othersCapital = ZakatItem(name: ConstantData.text_other_capital, value: 0.0, indexPath: IndexPath(row: 1, section: 6))
        let amountOfMoney = ZakatItem(name: ConstantData.title_farming, value: 0.0, indexPath: IndexPath(row: 0, section: 7))
        let creditCardPayment = ZakatItem(name: ConstantData.text_credit_card_payment, value: 0.0, indexPath: IndexPath(row: 0, section: 8))
        let carPayment = ZakatItem(name: ConstantData.text_car_payment, value: 0.0, indexPath: IndexPath(row: 1, section: 8))
        let businessPayment = ZakatItem(name: ConstantData.text_business_payment, value: 0.0, indexPath: IndexPath(row: 2, section: 8))
        let familyLoan = ZakatItem(name: ConstantData.text_family_loan_liability, value: 0.0, indexPath: IndexPath(row: 3, section: 8))
        let otherLoan = ZakatItem(name: ConstantData.text_other_loan, value: 0.0, indexPath: IndexPath(row: 4, section: 8))
        

        self.zakatItems = [cash, cashInBankAccount, gold,silver,shareMarket,otherInvestment,houseRent,asset,cardBusiness,product,pension,othersCapital,amountOfMoney,creditCardPayment,carPayment,businessPayment,familyLoan,otherLoan]
        
    }
}

