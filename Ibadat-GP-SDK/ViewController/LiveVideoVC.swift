//
//  LiveVideoVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import UIKit
import SafariServices
import AVFoundation
import AVKit

class LiveVideoVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var liveList : [LiveVideo]  = []
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.ibadat)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LiveCell.nib, forCellWithReuseIdentifier: LiveCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loader.color = .tintColor
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loader.startAnimating()
        APIService.instant.getLiveVideo { result in
            self.loader.stopAnimating()
            switch  result{
            case .success(let videos):
                self.liveList = videos
                self.collectionView.reloadData()
            case .failure(let error):
                //show alert
                #if DEBUG
                print(error.localizedDescription)
                #endif
                break
            }
        }
    }

}
extension LiveVideoVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: LiveCell.identifier, for: indexPath) as? LiveCell else{
            fatalError("Surah cell load failed")
        }
        cell.setImage(url: liveList[indexPath.row].previewImage)
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
        return CGSize(width: width, height: (width / 2).rounded())
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = liveList[indexPath.row]
        let str = "https://www.youtube.com/embed/\(obj.videoLink)?modestbranding=1&amp;autoplay=1&amp;controls=0&amp;showinfo=0&amp;rel=0&amp;enablejsapi=1&amp;version=3&amp;playerapiid=iframe_YTP_1525952728130&amp;origin=http://mygp.ibadat.co&amp;allowfullscreen=true&amp;wmode=transparent&amp;iv_load_policy=3&amp;playsinline=0&amp;html5=1&amp;widgetid=\(obj.videoLink)"
        guard let url = URL(string: str) else {
            return
        }
        let web = SFSafariViewController(url: url)
        self.present(web, animated: true )
        
//        let player = AVPlayer(url: url)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }

    }
}

