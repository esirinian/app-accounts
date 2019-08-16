//
//  ViewController.swift
//  app-accounts
//
//  Created by Eric Sirinian on 8/10/19.
//  Copyright © 2019 Eric Sirinian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {


    var pickerData: [String] = [String]()

    var attendant: String! = "Leandro"
    var referenceNumber: String! = ""
    var grade: String! = "Regular"
    var gasSale: Double! = 0.0
    var gallonsSold: Double! = 0.0
    
    var regularPrice: Double = 2.70
    var plusPrice: Double = 2.90
    var premiumPrice: Double = 3.10
    var ultraPrice: Double = 3.25
    
    
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var referenceNumberTextField: UITextField!
    @IBOutlet weak var gasSaleTextField: UITextField!
    @IBOutlet weak var gallonsSoldTextField: UITextField!
    @IBOutlet weak var printButton: UIButton!
    
    @IBOutlet weak var previewReferenceNumberLabel: UILabel!
    @IBOutlet weak var previewGradeLabel: UILabel!
    @IBOutlet weak var preveiwGallonsLabel: UILabel!
    @IBOutlet weak var previewSaleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerData = ["Leandro", "Eric", "Sarven", "Adrienne"]
        
        referenceNumberTextField.delegate = self
        gasSaleTextField.delegate = self
        
        self.previewReferenceNumberLabel.text = "XXXXXXX"
        self.previewGradeLabel.text = "Regular"
        self.preveiwGallonsLabel.text = "0.00"
        self.previewSaleLabel.text = "$ 0.00"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView:UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView:UIPickerView, didSelectRow row:Int, inComponent component:Int){
        self.attendant = pickerData[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField( _ textField: UITextField, moveDistance:Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    @IBAction func referenceNumberTextFieldEditingEnd(_ sender: Any) {
        if let input = referenceNumberTextField.text {
            previewReferenceNumberLabel.text = input
            self.referenceNumber = input
        }
    }
    
    func updateGallonsSold() {
        if self.grade == "Regular" {
            self.gallonsSold = self.gasSale / self.regularPrice
        }
        else if self.grade == "Plus" {
            self.gallonsSold = self.gasSale / self.plusPrice
        }
        else if self.grade == "Premium" {
            self.gallonsSold = self.gasSale / self.premiumPrice
        }
        else if self.grade == "Ultra" {
            self.gallonsSold = self.gasSale / self.ultraPrice
        }
        
        self.gallonsSold = Double(round(1000*self.gallonsSold) / 1000)
        
        self.gallonsSoldTextField.text = String(self.gallonsSold)
        self.preveiwGallonsLabel.text = self.gallonsSoldTextField.text
    }
    
    @IBAction func gasSaleTextFieldEditingEnd(_ sender: Any) {
        if let input = gasSaleTextField.text {
            let formatInput: Double! = Double(input)
            previewSaleLabel.text = String(format:"%.2f", formatInput)
            gasSaleTextField.text = String(format:"%.2f", formatInput)
            self.gasSale = formatInput
            
            updateGallonsSold()
        }
    }
    
    @IBAction func gradeSegmentedControlIndexChanged(_ sender: Any) {
        switch gradeSegmentedControl.selectedSegmentIndex {
        case 0:
            previewGradeLabel.text = "Regular"
            self.grade = "Regular"
        case 1:
            previewGradeLabel.text = "Plus"
            self.grade = "Plus"
        case 2:
            previewGradeLabel.text = "Premium"
            self.grade = "Premium"
        case 3:
            previewGradeLabel.text = "Ultra"
            self.grade = "Ultra"
        default:
            break
        }
        
        updateGallonsSold()
    }
    @IBAction func printButtonPressed(_ sender: Any) {
        print(attendant)
        print(grade)
        print(gallonsSold)
        print(gasSale)
    }
    
}

