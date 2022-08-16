//
//  IslamicCalenderVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit

class IslamicCalenderVC: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var holidayList : [IslamicHolidayModel] = []
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CalenderCell.nib, forCellWithReuseIdentifier: CalenderCell.identifier)
        collectionView.register(HolidayCell.nib, forCellWithReuseIdentifier: HolidayCell.identifier)
        collectionView.register(HolidayHeader.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HolidayHeader.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .appWhite
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIService.instant.getIslamicHoliday { result in
            switch result{
            case .success(let holidays):
                self.holidayList = holidays.data
                self.collectionView.reloadData()
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
extension IslamicCalenderVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return holidayList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalenderCell.identifier, for: indexPath) as? CalenderCell else{
                fatalError("Calender cell load failed")
            }
            cell.localeIdentifier =  "bn"
            return cell
        }
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: HolidayCell.identifier, for: indexPath) as? HolidayCell else{
            fatalError("Surah cell load failed")
        }
        cell.setHoliday(holiday: holidayList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        
        return CGSize(width: width, height: indexPath.section  == 0 ? CalenderCell.height  :  56)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HolidayHeader.identifier, for: indexPath) as? HolidayHeader else {
                fatalError()
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return .zero
        }
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: 70)
    }
    
}
