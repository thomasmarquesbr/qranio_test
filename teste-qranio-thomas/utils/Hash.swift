//
//  Hash.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 04/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation
import CommonCrypto

struct Hash {
    
    static func MD5(_ string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData
    }
    
    static func md5Hex(_ string: String) -> String {
        let md5Data = MD5(string)
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }
    
}
