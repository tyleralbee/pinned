//
//  NotificationViewController.swift
//  pinned
//
//  Created by Tyler Albee on 8/19/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit


class NotificationViewController: UIViewController {
    
    var notificationResults = [String]()

    @IBOutlet weak var notifTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        notifTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        db.collection("pins").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let newNotif = document.data()["latitude"]
                    self.notificationResults.append("\(newNotif)")
                    print("notification added!")
                    self.notifTableView.reloadData()
                }

            }
        }
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

extension NotificationViewController : UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationResult = notificationResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = notificationResult
        cell.detailTextLabel?.text = notificationResult
        
        return cell
        
    }
}
