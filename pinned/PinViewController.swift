//
//  PinViewController.swift
//  
//
//  Created by Tyler Albee on 7/9/19.
//

import UIKit
import MapKit



class PinViewController: UIViewController {

    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchCompleter.delegate = self
    }
    
}

extension PinViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchCompleter.queryFragment = searchText
    }
}

extension PinViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
        
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle errors
    }
}

extension PinViewController : UITableViewDataSource {
    func numberOfRows(inSection: Int) -> Int {
        return searchResults.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
        
    }
}

extension PinViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            
            
            let pinner = MKPointAnnotation()
            pinner.coordinate = coordinate!
            print(String(describing: pinner.coordinate))
            

            
            toPin.latitude = pinner.coordinate.latitude
            toPin.longitude = pinner.coordinate.longitude
            
            
            
            guard let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "DescriptionViewController") as? DescriptionViewController else {
                print("couldn't find view controller")
                return
            }
            
            self.navigationController?.pushViewController(destinationViewController, animated: true)
            //let descriptionViewController:DescriptionViewController = DescriptionViewController()

        }
        
    }
}
