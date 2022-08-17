//
//  NearestMosqueVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import UIKit

class NearestMosqueVC: UITabBarController {

    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let list = UITabBarItem(title: "মসজিদ", image: AppImage.mosque.uiImage, tag: 0)
        let listVC = MosqueListVC()
        listVC.tabBarItem = list
        let map = UITabBarItem(title: "মানচিত্র", image: AppImage.map.uiImage, tag: 1)
        let mapVC = MapViewVC()
        mapVC.tabBarItem = map
        viewControllers = [listVC,mapVC]
        tabBar.tintColor = .tintColor
    }

}
