//
//  OADataManager.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 07/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import Alamofire

class OADataManager: NSObject {
    private let urlcountries:String = "https://restcountries.eu/rest/v2/all?fields=name;capital;flag;population;currencies;borders;alpha3Code"
    
    func getCountryDataWithResponse(complition: @escaping (_ countries: [Country]?,_ error:Error?) -> Void) {
        
        Alamofire.request(URL(string: urlcountries)!)
            .validate()
            .response { (response) in
                if let error = response.error {
                    complition(nil,error)
                }
                guard let data = response.data else {
                    complition(nil,NSError(domain:NSLocalizedString("No data received!", comment: "") , code: 0, userInfo: nil))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let countries = try decoder.decode([Country].self, from: data)
                    complition(countries,nil)
                } catch {
                    complition(nil,NSError(domain: NSLocalizedString("Error parsing JSON!", comment: ""), code: 1, userInfo: nil))
                }
        }
    }
}
