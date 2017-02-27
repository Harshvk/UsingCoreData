//
//  UserInfoVC.swift
//  UsingCoreData
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

class UserInfoVC: UIViewController {

    var people : Person!
    let dbHelper = DBHelper()
    var previewMode : PreviewModeEnabled!
    var personIndex = Int()

    
    @IBOutlet weak var userInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userInfoTable.dataSource = self
        self.userInfoTable.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneButtonTapped(_ sender: UIButton) {
        
        userInfoTable.endEditing(true)
        dbHelper.saveData()
        _ = self.navigationController?.popViewController(animated: true)
        
    }



}

extension UserInfoVC : UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableCellID", for: indexPath) as? DetailsTableCell else{ fatalError("Cell not found") }
        
        
        
            cell.infoTextField.delegate = self
       
            switch indexPath.row {
            
            case 0: cell.tilteLabel.text = "Name"
            
            case 1: cell.tilteLabel.text = "Email"
            
            case 2: cell.tilteLabel.text = "Phone"
            
            case 3: cell.tilteLabel.text = "Age"
    
            default: print("error")
            
            }
    
        if people != nil{
            
            switch indexPath.row {
            
            case 0 : cell.infoTextField.text = people.name
            
            case 1 : cell.infoTextField.text  = people.email
            
            case 2 : cell.infoTextField.text = "\(people.phone)"
            
            case 3 : cell.infoTextField.text  = "\(people.age)"
            
            default : print("error")
            
            }
        }
        
        if previewMode == .yes{
            
            cell.infoTextField.isEnabled = false
            
        }
        
            return cell
    }
    

    func textFieldDidEndEditing(_ textField: UITextField){
        
        
        let cell =  textField.superview?.superview as? DetailsTableCell
        
        guard let indexPath = userInfoTable.indexPath(for: (cell)!) else {   return   }
        
        guard let  cellData = textField.text else {   return   }
            
            switch indexPath.row {
                
            case 0: dbHelper.name = cellData
                
            case 1: dbHelper.email = cellData
                
            case 2: dbHelper.phone = Int64(cellData)!
                
            case 3: dbHelper.age = Int64(cellData)!
                
                
            default: print("error")
                
            }

    }
    
    

}

class DetailsTableCell : UITableViewCell {
    
    @IBOutlet weak var tilteLabel: UILabel!
    
    @IBOutlet weak var infoTextField: UITextField!
    
}

enum PreviewModeEnabled {
    case yes,no
}

