//
//  ViewController.swift
//  TribalscaleApp
//
//  Created by Ashish Mishra on 6/21/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var serviceCommunicator : ServiceCommunicator?
    @IBOutlet var userListTable : UITableView!
    var userList : [UserInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "TribalScale Users"
        
        self.serviceCommunicator = ServiceCommunicator()
        self.serviceCommunicator?.fetchUsers(completionBlock: { (users, error) in
            
            self.userList = users!
            
            DispatchQueue.main.async {
                self.userListTable.reloadData()
            }
            
        })
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        
        let currentCellInfo = self.userList[indexPath.row] as UserInfo
        
        cell.userName.text = currentCellInfo.name
        
        if let avatarURL = currentCellInfo.avatarMedUrl {
            self.retreiveImageData(avatarURL, indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ListToDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListToDetail" {
            let destination = segue.destination as! UserDetailViewController
            let indexPath = sender as! IndexPath
            destination.userInfo = self.userList[indexPath.row]
        }
    }
    
    func retreiveImageData(_ posterPath : String?, indexPath: IndexPath) {
      
        let imgURL: URL = URL(string: posterPath!)!
        
        URLSession.shared.dataTask(with: imgURL, completionHandler: { (data, response, erro) -> Void in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let cell : UserListCell = self.userListTable.cellForRow(at: indexPath) as? UserListCell {
                    cell.userAvatar.image = UIImage(data: data)
                    cell.setNeedsLayout()
                }
            })
        }) .resume()
        
    }
    
}

