//
//  NetworkManger.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
import Alamofire



class NetworkManager: NetworkProtocol{
    static func getData<T>(met: String,sport: String, handler: @escaping (T?) -> Void) where T : Decodable {
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=\(met)&APIkey=a7c764b36a5f79c1edc8f47fcc2d5daa677f49cda65f952bec3e78ca28aba2a4", method: .get).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                print("Data Recieved")
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
        
    }
    
}
