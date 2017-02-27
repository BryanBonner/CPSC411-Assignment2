//
//  ViewController.swift
//  LabelLab
//
//  Created by CampusUser on 2/6/17.
//  Copyright © 2017 CPSC411. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var height: Float = 0.0
    var weight: Float = 0.0
    var metric: Bool = false
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var metricLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        resultImageView.image = UIImage(named: "default")
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        weightTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == nameTextField) {
            height = Float(textField.text!)!
        }
        if(textField == weightTextField){
            weight = Float(textField.text!)!
        }
    }
    
    //MARK: Actions
    @IBAction func calculateBMI(_ sender: Any) {
        print(height)
        print(weight)
        let result: Float = calcBMI(w: weight, h: height, m: metric)
        resultLabel.text = result.description
        switch result {
            case 0..<18.5:
                resultImageView.image = UIImage(named: "underweight")
            case 18.5..<25.00:
                resultImageView.image = UIImage(named: "normal")
            case 25.00..<30.00:
                resultImageView.image = UIImage(named: "over")
            case 30.00..<40.00:
                resultImageView.image = UIImage(named: "obese")
            case 40.00..<100.00:
                resultImageView.image = UIImage(named: "morbid")
            default:
                resultImageView.image = UIImage(named: "default")
        }
        
    }
    @IBAction func switchMetric(_ sender: UISwitch) {
        if sender.isOn {
            metric = true
            nameTextField.text = ""
            nameTextField.placeholder = "centemeters"
            weightTextField.text = ""
            weightTextField.placeholder = "kilograms"
        }
        else {
            metric = false
            nameTextField.text = ""
            nameTextField.placeholder = "inches"
            weightTextField.text = ""
            weightTextField.placeholder = "lbs"
        }
    }

    //Logic
    //@param m: on/off flag for metric conversion
    //@return: bmi value
    func calcBMI(w: Float, h: Float, m: Bool) ->Float {
        if (m == false) {
            return w * 703 / pow(h, 2)
        }
        else {
            return w / pow(h/100, 2)
        }
    }
}

