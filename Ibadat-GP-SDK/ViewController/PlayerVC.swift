//
//  PlayerVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 17/8/22.
//

import UIKit
import MediaPlayer
import AVKit

class PlayerVC: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoId : String?
    //MARK:- Initial with nib name
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
        // Do any additional setup after loading the view.
        guard let videoId = videoId else {
            return
        }

        if playerView.load(withVideoId: videoId){
            print("video load success")
        }else{
            print("video load failed")
        }
        
    }
    @IBAction func onBackPressed(_ sender: Any) {
        playerView.stopVideo()
        navigationController?.popViewController(animated: true)
    }
    
}
