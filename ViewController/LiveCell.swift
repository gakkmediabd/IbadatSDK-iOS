//
//  LiveCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import UIKit

class LiveCell: UICollectionViewCell {
    static let identifier : String = "LiveCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.backgroundColor  =  .backgroundColor
    }

    func setImage(url : String){
        guard let imgUrl = URL(string: url) else{
            return
        }
        loader.startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imgUrl) else {
                self?.loader.stopAnimating()
                return
            }
            
            if let image = UIImage(data: data,scale: 1){
                DispatchQueue.main.async {
                    guard let self = self else {return}
                    self.imageView.backgroundColor =  .clear
                    self.loader.stopAnimating()
                    self.imageView.image = image
                }
            }
        }
    }
    
}
