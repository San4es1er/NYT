//
//  HeadersTableViewController.swift
//  NYT
//
//  Created by Alex Lebedev on 12.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

class HeadersTableViewController: UITableViewController {
    // MARK: - Properties
    let headers = ["Arts","Automobiles", "Books",
                   "Business", "Food", "Health", "Magazine", "Movies", "National",  "Obituaries", "Opinion", "Science", "Sports", "Technology", "Theater", "Travel", "World"]
    
    // MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = headers[indexPath.item]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 23)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc: ArticlesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Articles")
        
        vc.category = headers[indexPath.row]
        navigationController?.show(vc, sender: self)
    }
}
