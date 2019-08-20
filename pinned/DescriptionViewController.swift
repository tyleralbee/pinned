//
//  DescriptionViewController.swift
//  pinned
//
//  Created by Tyler Albee on 8/20/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBAction func pinButton(_ sender: Any) {
        let homeViewController:HomeMapController = HomeMapController()
        self.present(homeViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
