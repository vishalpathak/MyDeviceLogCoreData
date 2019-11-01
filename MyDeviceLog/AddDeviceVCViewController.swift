//
//  AddDeviceVCViewController.swift
//  MyDeviceLog
//
//  Created by vishal dilip pathak on 29/10/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

class AddDeviceVCViewController: UIViewController {

    @IBOutlet weak var txtfDeviceOwner: UITextField!
    
    @IBOutlet weak var txtfDeviceBrand: UITextField!
    
    @IBOutlet weak var txtfDeviceModel: UITextField!
    
    @IBOutlet weak var imgDevice: UIImageView!
    
    @IBOutlet weak var btnDeviceImage: UIButton!
    
    @IBOutlet weak var txtfDevicePrice: UITextField!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        txtfDeviceBrand.delegate = self
        txtfDeviceModel.delegate = self
        txtfDevicePrice.delegate = self
        txtfDeviceOwner.delegate = self
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        let params:[String: Any] = ["devicePrice": txtfDevicePrice.text ?? 0, "deviceModel":txtfDeviceModel.text ?? "NA", "deviceBrand": txtfDeviceBrand.text ?? "NA", "deviceColour": txtfDeviceOwner.text ?? "NC"]
        CoreDataManager.sharedCDManager.saveEntityData(entityParams: params as [String : AnyObject], entityName: "Devices") { (result) in
            let fetchResult = result as! Bool
            if fetchResult == true{
                print("all data saved")
            }
        }
    }
    
    @IBAction func btnDeviceImageClicked(_ sender: Any) {
    }
   

}
extension AddDeviceVCViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return false
    }
}
