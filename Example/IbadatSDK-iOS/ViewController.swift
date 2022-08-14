//
//  ViewController.swift
//  IbadatSDK-iOS
//
//  Created by MD Azizur Rahman on 08/11/2022.
//  Copyright (c) 2022 MD Azizur Rahman. All rights reserved.
//

import UIKit
import IbadatSDK_iOS
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onButtonPressed(_ sender: Any) {
        IbadatSdkCore.shared.openFeature(by: .TASBIH, presentController: self)
    }
    
}

//https://www.youtube.com/watch?v=LqPCpAZaCME
//https://medium.com/@jeantimex/create-your-own-cocoapods-library-da589d5cd270
//https://guides.cocoapods.org/making/using-pod-lib-create
