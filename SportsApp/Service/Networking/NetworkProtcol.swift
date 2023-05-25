//
//  NetworkProtcol.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
protocol NetworkProtocol{
    static func getData<T: Decodable>(met: String, sport: String, handler: @escaping (T?)-> Void)
}

