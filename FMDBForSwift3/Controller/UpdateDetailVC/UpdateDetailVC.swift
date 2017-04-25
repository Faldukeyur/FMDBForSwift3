//
//  UpdateDetailVC.swift
//  FMDBForSwift3
//
//  Created by keyur on 24/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

import UIKit

class UpdateDetailVC: UIViewController {

    @IBOutlet var txtname : UITextField!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtPhone : UITextField!
    
    @IBOutlet var btnUpdate : UIButton!
    
    
    var StudentId: NSInteger!
    
    var studentDetail : student!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let id = StudentId {
            
            DBManager.shared.SelectSingleRecord(withID: id, completionHandler: { (student) in
                DispatchQueue.main.async {
                    
                    if student != nil {
                        
                        self.studentDetail = student
                        self.setValuesToViews()
                    }
                }
            })
        }
    }
    @IBAction func onButtonClick(_ sender: UIButton) {
        
        if sender == btnUpdate {
            
          //  DBManager.shared.updat(withID: movieInfo.movieID, watched: movieInfo.watched, likes: movieInfo.likes)
            
            DBManager.shared.updateStudentDetail(withID: studentDetail.id, name:txtname.text!, email: txtEmail.text!, phone: txtPhone.text!)

            txtname.text = nil
            txtEmail.text = nil
            txtPhone.text = nil
            
        }
    }
    func setValuesToViews() {
        
        txtname.text = studentDetail.name
        txtEmail.text = studentDetail.email
        txtPhone.text = studentDetail.phone
        
    }
}
