//
//  SurahDetailsVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit
import AVFoundation

class SurahDetailsVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var playerProgress: UISlider!
    @IBOutlet weak var volumProgress: UISlider!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var currentDurationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var ayatList : [AyatModel] = []
    
    var index : Int = 0
    var surahList : [SurahModel]?
    
    private var audioPlayer : AVPlayer?
    private var playerItem : AVPlayerItem?
    private var volume : Float = 0.5
    private var updater : CADisplayLink! = nil
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.textColor = .tintColor
        titleLabel.textColor =  .titleColot
        subtitleLabel.textColor = .subTitleColot
        playerProgress.tintColor = .tintColor
        volumProgress.tintColor = .tintColor
        loader.color = .tintColor
        
        totalDurationLabel.textColor =  .subTitleColot
        currentDurationLabel.textColor = .subTitleColot
        totalDurationLabel.adjustsFontSizeToFitWidth = true
        currentDurationLabel.adjustsFontSizeToFitWidth = true
        
        contentView.clipsToBounds = true
        contentView.layer.shadowColor = UIColor.grayColor.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.cornerRadius  = 8
        contentView.layer.masksToBounds = false
        
        
        let t = CGAffineTransform(scaleX: 0.8, y: 0.8)
        playerProgress.transform = t
        volumProgress.transform = t
        btnPlayPause.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        
        collectionView.register(AyatCell.nib, forCellWithReuseIdentifier: AyatCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let iconPlay = UIImage(named: "icon_play", in: Bundle.bundle, compatibleWith: nil)
        let iconPause = UIImage(named: "icon_pause", in: Bundle.bundle, compatibleWith: nil)
        self.btnPlayPause.setImage(iconPlay, for: .normal)
        self.btnPlayPause.setImage(iconPause, for: .selected)
        
        ayatLoad()
        playerSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let audioPlayer = audioPlayer else {
            return
        }

        if audioPlayer.rate > 0 {
            audioPlayer.pause()
        }
    }
    
    
    
    @IBAction func onAudioProgressChange(_ sender: Any) {
        guard let audioPlayer = audioPlayer else {
            return
        }
        audioPlayer.seek(to: CMTime(seconds: Double(playerProgress.value), preferredTimescale: 1))
    }
    @IBAction func onnVolumProgressChange(_ sender: Any) {
        guard let audioPlayer = audioPlayer else {
            return
        }
        self.volume = volumProgress.value
        audioPlayer.volume = self.volume
    }
    @IBAction func onPreviousPressed(_ sender: Any) {
        index -= 1
        if index < 0{
            index = 113
        }
        guard let audioPlayer = audioPlayer else {
            return
        }
        if audioPlayer.rate != 0 {
            audioPlayer.pause()
            self.btnPlayPause.isSelected = false
        }
        ayatLoad()
        playerSetup()
        
    }
    @IBAction func onNextPressed(_ sender: Any) {
        guard let surahList = surahList else {
            return
        }
        index += 1
        if index >= surahList.count {
            index = 0
        }
        guard let audioPlayer = audioPlayer else {
            return
        }
        if audioPlayer.rate != 0 {
            audioPlayer.pause()
            self.btnPlayPause.isSelected = false
        }
        ayatLoad()
        playerSetup()
    }
    @IBAction func onPlayPausePressed(_ sender: Any) {
        guard let audioPlayer = audioPlayer,let playerItem = self.playerItem else {
            return
        }
        if  audioPlayer.rate == 0{
            audioPlayer.play()
            self.btnPlayPause.isSelected = true
            
            let secound = playerItem.duration.seconds
            
            if !secound.isNaN{
                self.playerProgress.maximumValue = Float(secound)
                self.totalDurationLabel.text = playerItem.duration.positionalTime
            }
            updater = CADisplayLink(target: self, selector: #selector(trackAudio))
            if #available(iOS 15.0, *) {
                updater.preferredFrameRateRange = CAFrameRateRange(minimum: 1, maximum: 1)
            } else {
                // Fallback on earlier versions
                updater.frameInterval = 1
            }
            updater.add(to: .main, forMode: RunLoopMode.commonModes)
        }else{
            audioPlayer.pause()
            self.btnPlayPause.isSelected = false
            updater.invalidate()
        }
    }
    
}
extension SurahDetailsVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ayatList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: AyatCell.identifier, for: indexPath) as? AyatCell else{
            fatalError("Surah cell load failed")
        }
        let obj = ayatList[indexPath.row]
        cell.titleLabel.text  = obj.text
        cell.subtitleLabel.text = obj.textInArabic
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32 - 16
        
        let obj = ayatList[indexPath.row]
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        label.text = "\(obj.text) \n \(obj.textInArabic)"
        label.numberOfLines = 0
        label.sizeToFit()
        return CGSize(width: width, height: label.bounds.height + 8)
    }
}

extension SurahDetailsVC{
    private func playerSetup(){
        guard let url = URL(string: URLConstant.SURAH_PLAY_URL("\(index + 1)")) else {
            fatalError("play url not load")
        }
        playerItem =  AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.volume = volume
        self.playerProgress.minimumValue = 0
        self.playerProgress.value = 0
    }
    func ayatLoad(){
        guard let surahList = surahList else {return}
        let sura = surahList[index]
        self.titleLabel.text = sura.surhaName
        self.subtitleLabel.text = sura.ayetCount
        self.countLabel.text = "\(index + 1)"
        loader.startAnimating()
        ayatList.removeAll()
        collectionView.reloadData()
        APIService.instant.getSurahDetails(id: "\(index+1)") { result in
            self.loader.stopAnimating()
            switch result{
            case .success(let response):
                self.ayatList = response.data
                self.collectionView.reloadData()
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    @objc
    func trackAudio() {
        guard let playerItem = playerItem else {
            return
        }
        let secound = playerItem.currentTime().seconds
        self.playerProgress.value = Float(secound)
        self.totalDurationLabel.text = playerItem.duration.positionalTime
        self.currentDurationLabel.text = playerItem.currentTime().positionalTime
        if !playerItem.duration.seconds.isNaN{
            self.playerProgress.maximumValue = Float(playerItem.duration.seconds)
        }
        
    }
}


extension CMTime {
    var roundedSeconds: TimeInterval {
        return !seconds.isNaN ? seconds.rounded() : 0.0
    }
    var hours:  Int { return Int(roundedSeconds / 3600) }
    var minute: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 60)) }
    var positionalTime: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
}
