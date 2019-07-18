//
//  PinViewController.swift
//  
//
//  Created by Tyler Albee on 7/9/19.
//

import UIKit
import MapKit

var locationChosen = [CLLocationCoordinate2D]()

class PinViewController: UIViewController {

    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchCompleter.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        return 5
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            print(String(describing: coordinate))
            locationChosen.append(coordinate!)
            self.navigationController?.popViewController(animated: true)

            
        }
        
    }
}
