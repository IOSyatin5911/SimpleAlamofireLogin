//
//  ViewController.swift
//  demoAlamofire
//
//  Created by Mac User6 on 31/03/17.
//  Copyright © 2017 xyz. All rights reserved.


import UIKit
import Alamofire


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var txtUsername:
    UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var collView: UICollectionView!
    

    
    var arr = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
    let patientIdUrl = "Your Api (URL)"
    let dict = ["parameter1": txtUsername.text!,"parameter2": txtPassword.text!]
        
    let str : String = (self.txtUsername.text == "") ? "Please Enter Username" : (self.txtPassword.text == "") ? "Please Enter Password" : ""

        if str == ""{
            Alamofire.request(patientIdUrl, method: .post, parameters: dict, encoding: URLEncoding.default, headers: nil)
                        .responseJSON { response in
            print(response.result.value as Any)
            let value = response.result.value as! NSDictionary
            let str = value.object(forKey: "message") as! NSString
            let alertController = UIAlertController(title: "Notice", message: str as String, preferredStyle:.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
        else{
            let alertController = UIAlertController(title: "Notice", message: str, preferredStyle:.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let acell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCell
        
        let str = arr[indexPath.row] as! String
        
        let escapedString = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        DispatchQueue.main.async(){
            
            let url = NSURL(string: escapedString!)
            let data = NSData(contentsOf: url! as URL)
            acell.imgView.image =  UIImage(data: data! as Data)
        }
        
        return acell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

