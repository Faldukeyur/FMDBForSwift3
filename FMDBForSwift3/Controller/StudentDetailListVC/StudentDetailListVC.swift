//
//  StudentDetailListVC.swift
//  FMDBForSwift3
//
//  Created by keyur on 24/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

import UIKit

struct student {
    
    var id : NSInteger!
    var name : String!
    var email : String!
    var phone : String!
}

class StudentDetailListVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet var tblStudentList : UITableView!
    
    var studentDetail : [student]!
    var selectedMovieIndex: Int!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblStudentList.delegate = self
        tblStudentList.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studentDetail = DBManager.shared.selectStudentDetail()
        tblStudentList.reloadData()
    }
    
    // MARK: UITableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (studentDetail != nil) ? studentDetail.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentMovie = studentDetail[indexPath.row]
        
        cell.textLabel?.text = currentMovie.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMovieIndex = indexPath.row
        performSegue(withIdentifier: "idUpdateDetailVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if DBManager.shared.deleteStudent(withID: studentDetail[indexPath.row].id)
            {
                
                studentDetail.remove(at: indexPath.row)
                tblStudentList.reloadData()
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            
            if identifier == "idUpdateDetailVC" {
                
                let UpdateDetailVC = segue.destination as! UpdateDetailVC
                UpdateDetailVC.StudentId = studentDetail[selectedMovieIndex].id
            }
        }
    }
}
