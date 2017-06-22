//
//  UserDetailViewController.swift
//  TribalscaleApp
//
//  Created by Ashish Mishra on 6/21/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var userInfo : UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.retreiveImageData(self.userInfo?.avatarMedUrl)
        self.title = self.userInfo?.name
        // Do any additional setup after loading the view.
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset = UIEdgeInsetsMake(containerView.bounds.size.height, 0.0, 0.0, 0.0)
        tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
        let headerImageYOffset:CGFloat =  88 + containerView.bounds.size.height - view.bounds.size.height
        var headerImageFrame:CGRect = containerView.frame
        
        headerImageFrame.origin.y = headerImageYOffset
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = self.userInfo?.gender
            cell.detailTextLabel?.text = "Gender"

        case 1:
            cell.textLabel?.text = self.userInfo?.cellNo
            cell.detailTextLabel?.text = "Cell Number"


        case 2:
            var dateFormatter = DateFormatter()
            cell.textLabel?.text = dateFormatter.dateOfBirthFromDate(dateString: (self.userInfo?.dob)!)
            cell.detailTextLabel?.text = "Date of Birth"


        case 3:
            cell.textLabel?.text = self.userInfo?.emailId
            cell.detailTextLabel?.text = "Email Id"

        default :
            cell.textLabel?.text = ""
        
        }
        
        return cell
    }
    
    
    func retreiveImageData(_ posterPath : String?) {
        
        let imgURL: URL = URL(string: posterPath!)!
        
        URLSession.shared.dataTask(with: imgURL, completionHandler: { (data, response, erro) -> Void in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.imageView.image = UIImage(data: data)
            })
        }) .resume()
        
    }
    
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset: CGFloat = -scrollView.contentOffset.y
        let yPos: CGFloat = scrollOffset - containerView.bounds.size.height
        
        self.containerView.frame = CGRect(x: 0, y: yPos, width: containerView.frame.size.width, height: containerView.frame.size.height)
        let alpha: CGFloat = 1.0 - (-yPos / containerView.frame.size.height)
        
        self.imageView.alpha = alpha
        let fontSize: CGFloat = 24 - (-yPos / 20)
    }

}

extension DateFormatter {
    
    func dateOfBirthFromDate(dateString : String)-> String {
        self.dateFormat = "yyyy-MM-ddHH:mm:ss";
        let date = self.date(from: dateString)
        
        self.dateFormat = "MMM d, yyyy"
        return self.string(from:date!)
    }
    
}

