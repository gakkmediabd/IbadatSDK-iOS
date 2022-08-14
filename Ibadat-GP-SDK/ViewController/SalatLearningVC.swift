//
//  SalatLearningVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit

class SalatLearningVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var salatLearningList : [SalatLearningModel] = []
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.ibadat)
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
        
        loader.color = .tintColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.startAnimating()
        APIService.instant.getSalatLearningList(id: "1") { result in
            self.loader.stopAnimating()
            switch result{
            case .success(let response):
                self.salatLearningList = response
                self.collectionView.reloadData()
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    

}
extension SalatLearningVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return salatLearningList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else{
            fatalError("Surah cell load failed")
        }
        cell.salatLearningSetup(indx: indexPath.row, salat: salatLearningList[indexPath.row])
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
        
        let vc = SalatLearningNextVC()
        vc.salat = salatLearningList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
