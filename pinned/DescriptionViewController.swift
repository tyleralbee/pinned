//
//  DescriptionViewController.swift
//  pinned
//
//  Created by Tyler Albee on 8/20/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBAction func pinButton(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeMapController") as? HomeMapController else {
            print("couldn't find view controller")
            return
        }
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
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
