//
//  NetWorkManagert.swift
//  GitHubApi
//
//  Created by vishal dilip pathak on 10/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import UIKit

class NetWorkManagert: NSObject {
    
    static let sharedNetWork = NetWorkManagert()
    typealias ErrorHandler = (_ error: NSError?) -> Void
    
    func getDataFromUrl<T: Decodable>(url: String,completion: @escaping (T) -> (), error: @escaping ErrorHandler) -> Void {
        guard let url = URL(string: url) else{
            return
        }
//        SVProgressHUD.show(withStatus: "Please Wait")
//        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        URLSession.shared.dataTask(with: url) { (data, response, err) in
         //   SVProgressHUD.dismiss()
            if let err = err {
                error(err as NSError)
                //print("Failed to Fetch Data" ,err)
                return
            }
            guard let data = data else {
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result)
            } catch let jsonerror {
                error(err as NSError?)
                print("JSON: \(jsonerror)")
            }
            }.resume()
    }
    deinit {
        print("No retain cycle")
    }
}
