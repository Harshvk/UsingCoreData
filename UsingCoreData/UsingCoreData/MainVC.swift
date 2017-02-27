//
//  MainVC.swift
//  UsingCoreData
//
//  Created by Appinventiv on 25/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {

    
    var dbHelper  = DBHelper()
    
    @IBOutlet weak var namesTable: UITableView!
    
    @IBOutlet weak var addInfoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        initialsetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        dbHelper.getData()
        self.namesTable.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    private func initialsetup(){
        
        self.namesTable.dataSource = self
        self.namesTable.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
    }

    @IBAction func addInfoButtonTapped(_ sender: UIButton) {
        
        guard let userInfoPage = self.storyboard?.instantiateViewController(withIdentifier: "UserInfoVCID") as? UserInfoVC else{ return }
        userInfoPage.previewMode = .no
        self.navigationController?.pushViewController(userInfoPage, animated: true)
        
    }
    
}

extension MainVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return dbHelper.people.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellID", for: indexPath) as? TableCell
            else { fatalError("cell not found") }
        
        cell.nameLabel.text = dbHelper.people[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let nextPage = self.storyboard?.instantiateViewController(withIdentifier : "UserInfoVCID") as! UserInfoVC
        
        self.navigationController?.pushViewController(nextPage, animated: true)
        
        nextPage.people = dbHelper.people[row]
        
        nextPage.previewMode = .yes
        
        nextPage.dbHelper.people = [dbHelper.people[row]]
        
        nextPage.personIndex = row
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        
        let edit = UITableViewRowAction(style: .normal,
                                        title: "Edit",
                                        handler: {(UITableViewRowAction, IndexPath) -> Void in
        
                                            let nextPage = self.storyboard?.instantiateViewController(withIdentifier : "UserInfoVCID") as! UserInfoVC
                                            
                                            self.navigationController?.pushViewController(nextPage, animated: true)
                                            
                                            nextPage.people = self.dbHelper.people[indexPath.row]
                                            
                                            nextPage.previewMode = .no
                                            
                                            nextPage.dbHelper.people = [self.dbHelper.people[indexPath.row]]
                                            
                                            nextPage.personIndex = indexPath.row
        
                                            })
        
        let delete = UITableViewRowAction(style: .normal,
                                          title: "Delete",
                                          handler: {(UITableViewRowAction, IndexPath) -> Void in
        
                                            self.dbHelper.deleteData(self.dbHelper.people[indexPath.row])
                                            self.dbHelper.getData()
                                            self.namesTable.reloadData()
        
        })
        
        return [edit,delete]
        
    }
    
}

class TableCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
}
