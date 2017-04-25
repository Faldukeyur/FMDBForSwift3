//
//  DBManager.swift
//  FMDBForSwift3
//
//  Created by keyur on 24/04/17.
//  Copyright © 2017 Keyur. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    let student_ID     = "id"
    let student_name   = "name"
    let student_email  = "email"
    let student_Phone  = "phone"
    
    static let shared:DBManager = DBManager()
    
    let dataBaseFileName = "student.sqlite"
    
    var pathToDatabase : String!
    
    var dataBase :FMDatabase!
    
    override init(){
        
        super.init()
        
        let documentDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentDirectory.appending("/\(dataBaseFileName)")
        
        print(documentDirectory)
    }
/*
     Create Table
*/
    
    func createDatabaseTable() -> Bool {
        
        print(pathToDatabase)
        
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            
            dataBase = FMDatabase(path:pathToDatabase!)
            if dataBase != nil {
                
                if dataBase.open() {
                    
                    
                    let createstudentTable = "create table student(\(student_ID) INTEGER Not Null ,\(student_name) TEXT Not Null,\(student_email) TEXT Not Null,\(student_Phone) TEXT Not Null)"
                    
                    do{
                        
                        try dataBase.executeUpdate(createstudentTable, values: nil)
                        created = true
                        
                    }
                    catch{
                        
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    dataBase.close()
                }
                else{
                    
                    print("Could not open the database.")
                }
            }
        }
        return created
    }
/*
     OpenDataBase
*/
    func openDataBase() -> Bool {
        
        if dataBase == nil {
            
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                
                dataBase = FMDatabase(path:pathToDatabase)
                print(dataBase)
            }
        }
        
        if dataBase != nil {
            
            if dataBase.open() {
                
                return true
            }
        }
        return false
    }
/*
     Insert Student Detail
     let student_ID     = "id"
     let student_name   = "name"
     let student_email  = "email"
     let student_Phone  = "phone"
*/
    func insertStudentDetail(id : NSInteger!,name : String!,email : String!,phone : String!) {
        
        if openDataBase() {
            
            let val_id = id!
            let val_name = name!
            let val_email = email!
            let val_phone = phone!
            
            print(val_id)
            print(val_name)
            print(val_email)
            print(val_phone)
            
            let  insertStudentDetail = "insert into student(\(student_ID),\(student_name),\(student_email),\(student_Phone)) values ('\(val_id)','\(val_name)','\(val_email)','\(val_phone)');"
            do{
                
                try dataBase.executeUpdate(insertStudentDetail, values: nil)
                
            }
            catch{
                
                print("Could not Insert Detail.")
                print(error.localizedDescription)
            }
        }
        dataBase.close()
    }
/*
     Select Student Detail
     let student_ID     = "id"
     let student_name   = "name"
     let student_email  = "email"
     let student_Phone  = "phone"
*/
    func selectStudentDetail() -> [student] {
        
        var  studentInfo :[student]!
        
        if openDataBase() {
            
            let selectStudentDetail = "select * from student"
            
            do{
                let result = try dataBase.executeQuery(selectStudentDetail, values: nil)
                
                while result.next() {
                    
                    let studentDetail = student(id : NSInteger(result.int(forColumn: student_ID)),name:String(result.string(forColumn: student_name)),email:String(result.string(forColumn: student_email)),phone:String(result.string(forColumn: student_Phone)))
                    
                    if studentInfo == nil {
                        
                        studentInfo = [student]()
                    }
                    studentInfo.append(studentDetail)
                }
            }
            catch{
             
                print(error.localizedDescription)

            }
            dataBase.close()
        }
        return studentInfo
    }
    
/*
     Update Student Detail
     let student_ID     = "id"
     let student_name   = "name"
     let student_email  = "email"
     let student_Phone  = "phone"
*/
    func updateStudentDetail(withID ID: Int, name: String, email: String,phone: String) {
        
        if openDataBase() {
            
            let updateStudentDetail = "update student set \(student_name)=?,\(student_email)=?,\(student_Phone)=? where \(student_ID)=?"
            
            do{
                try dataBase.executeUpdate(updateStudentDetail, values:[name,email,phone,ID])
            }
            catch{
                
                print(error.localizedDescription)
            }
            dataBase.close()
        }
    }
    
/*
     Select Single Student Record
     let student_ID     = "id"
     let student_name   = "name"
     let student_email  = "email"
     let student_Phone  = "phone"
*/
    func SelectSingleRecord(withID ID:Int, completionHandler:(_ studentDetail:student?) -> Void) {
        
        var sudentInfo: student!
        
        if openDataBase() {
            
            let query = "select * from student where \(student_ID)=?"

            do{
                
                let result = try dataBase.executeQuery(query, values: [ID])
                
                if result.next() {
                    
                    sudentInfo = student(id : NSInteger(result.int(forColumn: student_ID)),name:String(result.string(forColumn: student_name)),email:String(result.string(forColumn: student_email)),phone:String(result.string(forColumn: student_Phone)))
                }
                else {
                    print(dataBase.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            dataBase.close()
        }
        completionHandler(sudentInfo)
    }
    
/*
     Delete  Student Record
     let student_ID     = "id"
     let student_name   = "name"
     let student_email  = "email"
     let student_Phone  = "phone"
*/
    func deleteStudent(withID ID : Int) -> Bool {
        
        var  deleted = false
        
        if openDataBase() {
            
            let query = "delete from student where \(student_ID)=?"

            do{
                
                try dataBase.executeUpdate(query, values: [ID])
                deleted = true

            }
            catch {
                
                print(error.localizedDescription)
            }
            
            dataBase.close()
        }
        return deleted
    }
}
