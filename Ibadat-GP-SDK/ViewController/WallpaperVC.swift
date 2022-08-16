//
//  WallpaperVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit

class WallpaperVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var wallpaperList : [WallpaperModel] = []
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(WallpaperCell.nib, forCellWithReuseIdentifier: WallpaperCell.identifier)
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
        APIService.instant.getWallpaper { result in
            self.loader.stopAnimating()
            switch result{
            case .success(let response):
                self.wallpaperList = response
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
extension WallpaperVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpaperList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCell.identifier, for: indexPath) as? WallpaperCell else{
            fatalError("Surah cell load failed")
        }
        cell.setupWallpaper(wall: wallpaperList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((UIScreen.main.bounds.width - 48) / 2 ).rounded()
        return CGSize(width: width, height: (width * 1.5).rounded())
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //download
        showAlert(title: nil, message: ConstantData.DOWNLOAD_ALERT, done: ConstantData.DOWNLOAD, cancel: ConstantData.CANCEL) {
            //start download
            self.downloadImage(from: URL(string: self.wallpaperList[indexPath.row].physicalURL)!)
        }
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

        @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                showAlert(title: ConstantData.DOWNLOAD_ERROR, message: error.localizedDescription, cancel: ConstantData.CANCEL) {
                    
                }
            }else{
                showAlert(title: ConstantData.DOWNLOAD_DONE, message: ConstantData.DOWNLOAD_DONE_MESSAGE, cancel: ConstantData.CANCEL) {
                    
                }
            }
        }
}

extension WallpaperVC{
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil,let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.writeToPhotoAlbum(image: img)
            }
        }
    }
    
}
