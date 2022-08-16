//
//  HadithVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import UIKit

class HadithVC: UIViewController {

    
    @IBOutlet weak var btnBacl: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var hadithList : [HadithModel] = []
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
        loader.color = .tintColor
        btnBacl.setImage(AppImage.back.uiImage, for: .normal)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.startAnimating()
        APIService.instant.allHadith { result in
            self.loader.stopAnimating()
            switch result{
            case .success(let arr):
                self.hadithList = arr
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
extension HadithVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hadithList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else{
            fatalError("Surah cell load failed")
        }
        cell.hadithSetup(indx: indexPath.row + 1, obj: hadithList[indexPath.row])
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
        let vc = DuaHadithDetailsVC()
        vc.index = indexPath.row
        vc.hadithList = hadithList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
