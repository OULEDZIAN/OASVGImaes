//
//  OACountriesViewController.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 07/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import UIKit
import SDWebImage



class OACountriesViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingPageView: UIView!
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    let searchController = UISearchController(searchResultsController: nil)
     

    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        setupSearchController()
        setupSearchController()
        reloadData()
        
        //add SVG coder to SDWebimage
        let coder = OASDWebImageSVGCoder()
        SDWebImageCodersManager.sharedInstance().addCoder(coder)
        
        
    }
    
    // Setup the tableview Controller
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView?.register(OACountryTableViewCell.nib, forCellReuseIdentifier: OACountryTableViewCell.identifier)
        
    }

    // Setup the Search Controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // get filtered list of coutry
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCountries = countries.filter({( country : Country) -> Bool in
            guard let countryName = country.name else {
                return false
            }
            guard let countryCapital = country.capital else {
                return countryName.lowercased().contains(searchText.lowercased())
            }
            return countryName.lowercased().contains(searchText.lowercased()) || countryCapital.lowercased().contains(searchText.lowercased())
            
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    
    // update data
    
    func reloadData() {
        OADataManager().getCountryDataWithResponse(complition: {countries,error in
            if let error = error {
                self.showAlertWithMessage(error.localizedDescription)
                return
            }
            if let countries = countries {
                self.countries = countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingPageView.removeFromSuperview()
                }
                
            }
        })
    }
    
    func showAlertWithMessage(_ message:String?) {
        let alert = UIAlertController(title: "Error", message:message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func pushToDetailOfCountry (_ country:Country) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OACountryViewController") as? OACountryViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
            viewController.country = country
            viewController.delegate = self
        }
    }
   
}

//*****************************************************************
// MARK: - t OACountryViewController delegat
//*****************************************************************

extension OACountriesViewController: OACountryViewControllerDelegate {
    func showDetailCountryWithalpha3Code(alpha3Code: String) {
        var filtredCountryCode = countries.filter({( country : Country) -> Bool in
            guard let codeCountry = country.alpha3Code else {
                return false
            }
            return codeCountry.lowercased().contains(alpha3Code.lowercased())
            
        })
        guard filtredCountryCode.count > 0 else {
            return
        }
        pushToDetailOfCountry(filtredCountryCode[0])
    }
}

//*****************************************************************
// MARK: - tableview delegat
//*****************************************************************

extension OACountriesViewController: UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCountries.count
        }
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OACountryTableViewCell.identifier, for: indexPath) as! OACountryTableViewCell
        
        let country: Country
        if isFiltering() {
            country = filteredCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        
        if let countryName = country.name, !countryName.isEmpty{
            cell.nameLabel!.text = countryName
        }
        
        if let countryCapital = country.capital, !countryCapital.isEmpty{
            cell.capitalLabel!.text = countryCapital
        }
        
        if let urlImage = country.flag {
            cell.flagImageView.sd_setImage(with: urlImage, placeholderImage: #imageLiteral(resourceName: "Default_flag"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let country: Country
        if isFiltering() {
            country = filteredCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        pushToDetailOfCountry(country)
    }
    
    
}

//*****************************************************************
// MARK: - UISearchBar delegat
//*****************************************************************

extension OACountriesViewController: UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
