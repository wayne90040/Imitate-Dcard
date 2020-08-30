//
//  DcardCatalogViewController.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/16.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import UIKit

class DcardCatalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    let catalogs = DcardCatalogs().catalogs
    var catalog = ""
    var delegate: DismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = 50
    }
    
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = catalogs[indexPath.row].name
//        cell.imageView?.image?.size = CGSize(width: 30, height: 30)
      
        cell.imageView?.layer.cornerRadius = 25
        cell.imageView?.clipsToBounds = true
        cell.imageView?.image = UIImage(named: catalogs[indexPath.row].logoImg)
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sendCatalogs(senderData: catalogs[indexPath.row].url)
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

protocol DismissDelegate {
     func sendCatalogs(senderData: String)
}
 
