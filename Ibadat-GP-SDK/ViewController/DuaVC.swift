//
//  DuaVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import UIKit

class DuaVC: UIViewController {
    
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var duaList : [DuaModel] = []
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
        
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.startAnimating()
        APIService.instant.allDua { result in
            self.loader.stopAnimating()
            switch result{
            case .success(let arr):
                self.duaList = arr
                self.collectionView.reloadData()
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    
    @IBAction func onbackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
extension DuaVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return duaList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else{
            fatalError("Surah cell load failed")
        }
        cell.duaSetup(indx: indexPath.row + 1, obj: duaList[indexPath.row])
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
        vc.duaList = duaList
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
