//
//  NetworkUtil.swift
//  ExLocalNotification
//
//  Created by Conner on 2023/05/13.
//

import Foundation

final class NetworkUtil {
    
    public class func showJson(_ pDic: [String : Any]){
        
        guard let json = try? JSONSerialization.data(withJSONObject: pDic, options: [.prettyPrinted]) else{
            return
        }
        guard let jsonText = String(bytes: json, encoding: String.Encoding.utf8) else{
            return
        }
        print()
        print(jsonText)
        print()
        
    }
    
    public class func stringToJson(_ pData: String) -> [String : Any]?{
        
        guard let uData = pData.data(using: .utf8) else{
            return nil
        }
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: uData, options : .allowFragments) as? [String : Any]
            {
                return jsonArray
            } else {
                return nil
            }
        } catch  {
            return nil
        }
    }
    
    public class func showData(pData: Data){
        guard let json = try? JSONSerialization.jsonObject(with: pData, options: []) as? [String : Any] else{
            return
        }
        self.showJson(json)
    }
}
