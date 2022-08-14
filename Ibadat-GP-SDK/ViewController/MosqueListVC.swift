//
//  MosqueListVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import UIKit

class MosqueListVC: UIViewController {
    @IBOutlet weak var btn1km: UIButton!
    @IBOutlet weak var btn5km: UIButton!
    @IBOutlet weak var btn10km: UIButton!
    @IBOutlet weak var topView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var refreshControl : UIRefreshControl!
    
    private var mosqueList : [MosqueModel] = []
    private var nextToken : String?
    private var radius : String = "1000"
    private var mapView : MapViewVC?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MosqueCell.nib, forCellWithReuseIdentifier: MosqueCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .tintColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        loader.color = .tintColor
        
        if let map = tabBarController?.viewControllers![1]  as? MapViewVC{
            self.mapView = map
        }
        topView.clipsToBounds = true
        topView.layer.shadowColor = UIColor.grayColor.cgColor
        topView.layer.shadowOffset = .zero
        topView.layer.shadowRadius = 1
        topView.layer.shadowOpacity = 0.4
        topView.layer.cornerRadius  = 8
        topView.layer.masksToBounds = false
        
        btn1km.layer.cornerRadius = 8
        btn10km.layer.cornerRadius = 8
        
        if #available(iOS 11.0, *) {
            btn1km.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
            btn10km.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        
        btn1km.setTitleColor(.appWhite, for: .selected)
        btn1km.setTitleColor(.tintColor, for: .normal)
        btn5km.setTitleColor(.appWhite, for: .selected)
        btn5km.setTitleColor(.tintColor, for: .normal)
        btn10km.setTitleColor(.appWhite, for: .selected)
        btn10km.setTitleColor(.tintColor, for: .normal)
        btn1km.isSelected = true
        btn1km.backgroundColor = .tintColor
        btn5km.backgroundColor = .buttonBackgroundColor
        btn10km.backgroundColor = .buttonBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMosque()
    }

    @IBAction func on1kmPressed(_ sender: Any) {
        radius = "1000"
        btn1km.isSelected = true
        btn5km.isSelected = false
        btn10km.isSelected = false
        
        btn1km.backgroundColor = .tintColor
        btn5km.backgroundColor = .buttonBackgroundColor
        btn10km.backgroundColor = .buttonBackgroundColor
        
        loadMosque()
    }
    @IBAction func on5kmPressed(_ sender: Any) {
        radius = "5000"
        btn1km.isSelected = false
        btn5km.isSelected = true
        btn10km.isSelected = false
        btn1km.backgroundColor = .buttonBackgroundColor
        btn5km.backgroundColor = .tintColor
        btn10km.backgroundColor = .buttonBackgroundColor
        loadMosque()
    }
    @IBAction func on10kmPressed(_ sender: Any) {
        radius = "10000"
        btn1km.isSelected = false
        btn5km.isSelected = false
        btn10km.isSelected = true
        btn1km.backgroundColor = .buttonBackgroundColor
        btn5km.backgroundColor = .buttonBackgroundColor
        btn10km.backgroundColor = .tintColor
        loadMosque()
    }
    @objc func refreshData() {
        // API Call
        print("refresh")
        loadMoreMosque()
     }
    private func loadMosque(){
        if refreshControl.isRefreshing{
            refreshControl.endRefreshing()
        }
        loader.startAnimating()
        APIService.instant.getMosque(radius: radius) { list, token, error in
            self.loader.stopAnimating()
            if let error = error {
                #if DEBUG
                print(error)
                #endif
                return
            }
            self.mosqueList = list
            self.nextToken = token
            self.collectionView.reloadData()
            self.sendDataToMapVC()
        }
    }
    private func loadMoreMosque(){
        if refreshControl.isRefreshing{
            refreshControl.endRefreshing()
        }
        guard let nextToken = nextToken else {
            return
        }
        self.loader.startAnimating()
        APIService.instant.getNextMosque(token: nextToken) { list, token, error in
            self.loader.stopAnimating()
            if let error = error {
                #if DEBUG
                print(error)
                #endif
                return
            }
            self.nextToken = token
            self.mosqueList.insert(contentsOf: list, at: 0)
            self.collectionView.reloadData()
            self.sendDataToMapVC()
            
        }
    }
    func sendDataToMapVC(){
        guard let mapView = mapView else {
            return
        }
        
        mapView.mosqueList =  self.mosqueList
    }
}
extension MosqueListVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mosqueList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: MosqueCell.identifier, for: indexPath) as? MosqueCell else{
            fatalError("Surah cell load failed")
        }
        cell.setMosque(mosque: mosqueList[indexPath.row])
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
        return CGSize(width: width, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //download
    }
}

