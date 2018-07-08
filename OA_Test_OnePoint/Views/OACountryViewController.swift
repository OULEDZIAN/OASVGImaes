//
//  OACountryViewController.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 07/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import UIKit

protocol OACountryViewControllerDelegate: AnyObject {
    func showDetailCountryWithalpha3Code(alpha3Code: String)
}

class OACountryViewController: UIViewController {

   weak var delegate: OACountryViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    var country: Country? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    
    
    func configureView() {
        if let country = country {
            self.title = country.name
        }
    }
    
    // Setup the tableview Controller
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView?.register(OADetailCountryTableViewCell.nib, forCellReuseIdentifier: OADetailCountryTableViewCell.identifier)
        tableView?.register(OASimpleTextTableViewCell.nib, forCellReuseIdentifier: OASimpleTextTableViewCell.identifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//*****************************************************************
// MARK: - tableview delegat
//*****************************************************************

extension OACountryViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let _ = country {
            if let borders = country?.borders, borders.count > 0 {
                return borders.count + 2
            }
            return 1
         }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if let borders = country?.borders, indexPath.row > 0 {
            let cellBorders = tableView.dequeueReusableCell(withIdentifier: OASimpleTextTableViewCell.identifier, for: indexPath) as! OASimpleTextTableViewCell
            if indexPath.row == 1 {
                cellBorders.titleLabel!.text = "borders :"
            }else {
                cellBorders.titleLabel!.text = "        " + borders[indexPath.row - 2]
            }
            return cellBorders
        }
       
        let cell = tableView.dequeueReusableCell(withIdentifier: OADetailCountryTableViewCell.identifier, for: indexPath) as! OADetailCountryTableViewCell
        if let country = country {
            if let countryCapital = country.capital, !countryCapital.isEmpty{
                cell.capitalLabel!.text = countryCapital
            }
            
            if let population = country.population {
                cell.PopulationLabel!.text = String(format:"%.0f", population)
            }
            
            if let currencies = country.currencies {
                let currenciesString = currencies.map { $0.name! }.joined(separator: ", ")
                cell.currenciesLabel!.text = currenciesString
            }
            
            if let urlImage = country.flag {
                cell.flagImageView.sd_setImage(with: urlImage, placeholderImage: #imageLiteral(resourceName: "Default_flag"))
            }
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if let borders = country?.borders, indexPath.row > 0 {
            self.tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.row > 1 {
                delegate?.showDetailCountryWithalpha3Code(alpha3Code: borders[indexPath.row - 2])
            }
        }
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
  
    
}
