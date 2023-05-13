//
//  BloodTypeAPI.swift
//  RandomUserAPI
//
//  Created by Conner on 2023/05/13.
//

import Foundation
import Alamofire


class BloodTypeAPI {
    static var shared = BloodTypeAPI()
    
    func load() {
        
        let url = "https://random-data-api.com/api/v2/blood_types"

        // Alamofire로 API 요청 보내기
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData{ response in
                switch response.result {
                case .success(let data):
                    NetworkUtil.showData(pData: data)
                    
                    do {
                        let bloodType = try BloodType(data: data)                        
                        UserDefaults.standard.setValue(bloodType.group, forKey: "bloodType")
                    } catch {
                        print("Blood Type parsing Error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}
