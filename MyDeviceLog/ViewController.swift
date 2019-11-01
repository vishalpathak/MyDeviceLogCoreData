//
//  ViewController.swift
//  MyDeviceLog
//
//  Created by vishal dilip pathak on 29/10/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var tblDeviceList: UITableView!
    var arrDevices = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblDeviceList.delegate = self
        tblDeviceList.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
       getDataFromCD()
    }
    func getDataFromCD() -> Void {
        CoreDataManager.sharedCDManager.getEntityData(entityName: "Devices", result: { (res) in
            print("All data\(res)")
            arrDevices =  res as! [NSManagedObject]
            tblDeviceList.reloadData()
        }) { (err) in
            print("Failed to get data")
        }
    }
    @IBAction func btnAddData(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "adddevice") as? AddDeviceVCViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return self.arrDevices.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let device: NSManagedObject
        device = arrDevices[indexPath.row]
        cell.detailTextLabel?.text = "\(device.value(forKey: "deviceBrand") as? String ?? "NA"), \(device.value(forKey: "deviceColour") as? String ?? "NC")"
        cell.textLabel?.text = device.value(forKey: "deviceModel") as? String

        return cell
    }
    
    
}
