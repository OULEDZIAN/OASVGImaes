//
//  OACountry.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 07/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import Foundation

public struct Country: Codable {
    
    let capital: String?
    let name: String?
    let flag: URL?
    let population:Double?
    let currencies:[currencies]?
    let borders:[String]?
    let alpha3Code:String?
    
    enum CodingKeys: String, CodingKey {
        case capital
        case name
        case flag
        case population
        case currencies
        case borders
        case alpha3Code
    }
}

public struct currencies: Codable{
    let name: String?
}
