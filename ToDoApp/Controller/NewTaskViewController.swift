//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 18.12.2021.
//

import UIKit

class NewTaskViewController: UIViewController {
    @IBOutlet var titleTextfield: UITextField!
    @IBOutlet var locationTextfield: UITextField!
    @IBOutlet var dateTextfield: UITextField!
    @IBOutlet var adressTextfield: UITextField!
    @IBOutlet var descriptionTextfield: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancellButton: UIButton!
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
