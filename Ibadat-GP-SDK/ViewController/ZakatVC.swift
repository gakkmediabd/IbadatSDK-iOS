//
//  ZakatVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 10/8/22.
//

import UIKit

class ZakatVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnZakatCalculator: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var zakatInfo : [ZakatModel] = []
    var selectedIndex : IndexPath = IndexPath(row: 0, section: 0)
    
    //MARK:- Initial with nib name
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnZakatCalculator.layer.cornerRadius  = 8
        btnZakatCalculator.backgroundColor = .tintColor
        
        tableView.register(ZakatTopCell.nib, forCellReuseIdentifier: ZakatTopCell.identifier)
        tableView.register(ZakatCalculatorOptionsCell.nib, forCellReuseIdentifier: ZakatCalculatorOptionsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        loader.color = .tintColor
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.startAnimating()
        APIService.instant.getZakat { result in
            self.loader.stopAnimating()
            switch result{
            case .success(let response):
                self.zakatInfo  = response
                self.tableView.reloadData()
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
                break
            }
        }
    }
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onZakatCalculatorPressed(_ sender: Any) {
        self.navigationController?.pushViewController(ZakatCalculationVC(), animated: true)
    }
    

}
extension ZakatVC : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zakatInfo.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell : ZakatTopCell = tableView.dequeueReusableCell(withIdentifier: ZakatTopCell.identifier, for: indexPath) as! ZakatTopCell
            cell.discriptionCell.text = ConstantData.txt_calculation_header
            return cell
            
        }else{
            let cell : ZakatCalculatorOptionsCell = tableView.dequeueReusableCell(withIdentifier: ZakatCalculatorOptionsCell.identifier, for: indexPath) as! ZakatCalculatorOptionsCell
            
            let data = self.zakatInfo[indexPath.row - 1]
            
            cell.bindOptions(categoryData: data)
            
            if selectedIndex == indexPath{
                cell.optionDetailsLbl.isHidden = false
                cell.expandBtn.setTitle("-", for: .normal)
            }else{
                cell.optionDetailsLbl.isHidden = true
                cell.expandBtn.setTitle("+", for: .normal)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex == indexPath{
            selectedIndex = IndexPath(row: 0, section: 0)
        }else{
            selectedIndex = indexPath
        }
        
        tableView.reloadData()
    }
}
