//
//  Bundle++.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import Foundation

extension Bundle{
    static var ibadat : Bundle?{
        return Bundle(identifier: "com.gakkMedia.Ibadat-GP-SDK")
    }
    static var bundle : Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: IbadatSdkCore.self)
        #endif
    }
}
