//
//  SurahVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import UIKit

internal class SurahVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var surahList = ConstantData.getAllSurah()
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ListCell.nib, forCellWithReuseIdentifier: ListCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .appWhite
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
    }

    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension SurahVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surahList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else{
            fatalError("Surah cell load failed")
        }
        cell.surahSetup(indx: indexPath.row + 1, surah: surahList[indexPath.row])
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
        return CGSize(width: width, height: 56)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = SurahDetailsVC()
        vc.index = indexPath.row
        vc.surahList = surahList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
