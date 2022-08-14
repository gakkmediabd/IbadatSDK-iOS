//
//  WallpaperCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit

class WallpaperCell: UICollectionViewCell {
    static let identifier : String = "WallpaperCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.ibadat)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.downloadLabel.textColor =  .appWhite
        self.downloadLabel.backgroundColor = .tintColor
        self.downloadLabel.text = "ডাউনলোড"
        clipsToBounds = true
        layer.shadowColor = UIColor.grayColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.cornerRadius  = 8
        layer.masksToBounds = false
        
        downloadLabel.clipsToBounds = true
        imageView.clipsToBounds = true
        downloadLabel.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
        if #available(iOS 11.0, *) {
            downloadLabel.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            imageView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }

    
    func setupWallpaper(wall : WallpaperModel){
        self.imageView.image = nil
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: wall.previwURL),let data = try? Data(contentsOf: url) else {
                return
            }
            
            if let image = UIImage(data: data,scale: 1){
                DispatchQueue.main.async {
                    //here is a crush for force unwrap self
                    guard let self = self else {return}
                    self.imageView.image = image
                }
            }
        }
        
    }
    
}
