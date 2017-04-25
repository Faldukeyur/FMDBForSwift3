//
//  ViewController.swift
//  FMDBForSwift3
//
//  Created by keyur on 24/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtSerialNo : UITextField!
    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtPhone : UITextField!
    
    @IBOutlet var btnSave : UIButton!
    @IBOutlet var btnStudentDetial : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        
        if sender == btnSave {
            
            let stringNumber = txtSerialNo.text
            let numberFromString = Int(stringNumber!)

            DBManager.shared.insertStudentDetail(id: numberFromString, name: txtName.text, email: txtEmail.text, phone: txtPhone.text)
            
            txtSerialNo.text = nil
            txtName.text = nil
            txtEmail.text = nil
            txtPhone.text = nil

        }
        else if sender == btnStudentDetial
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let registerVC = storyboard.instantiateViewController(withIdentifier:"StudentDetailListVC")
            self.navigationController?.pushViewController(registerVC, animated: true)        }
    }
}

