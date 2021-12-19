//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 18.12.2021.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    @IBOutlet var titleTextfield: UITextField!
    @IBOutlet var locationTextfield: UITextField!
    @IBOutlet var dateTextfield: UITextField!
    @IBOutlet var adressTextfield: UITextField!
    @IBOutlet var descriptionTextfield: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancellButton: UIButton!
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var dateFormater : DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    @IBAction func save() {
        let titleString = titleTextfield.text
        let locationString = locationTextfield.text
        let date = dateFormater.date(from: dateTextfield.text!)
        let descriptionString = descriptionTextfield.text
        let adressString = adressTextfield.text
        
        geocoder.geocodeAddressString(adressString!) {[unowned self]placemarks, error in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString!, coordinates: coordinate)
            let task = Task(title: titleString!, date: date, description: descriptionString, location: location)
            self.taskManager.add(task: task)
        }
        
    }
}
