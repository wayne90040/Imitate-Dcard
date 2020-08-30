//
//  ViewController.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/16.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, DismissDelegate {
    var id = Int(), dcards = [Dcard]()
    var catalog = String()
    var limit = Int()
    let viewcontrollerUtils = ViewControllerUtils()

    // MARK: - view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "DcardTableViewCell", bundle: nil), forCellReuseIdentifier: "DcardCell")
        tableView.rowHeight = 120
        if catalog == ""{ catalog = "posts" }
        
        limit = 20
        fetchArticle(limit)
        
    }
    
    func fetchArticle(_ limit: Int){
        DispatchQueue.main.async {
            self.viewcontrollerUtils.showActivityIndicator(uiView: self.view)
        }
        
        DcardController.shared.fetchItems(type: catalog, limit: limit){ (dcards) in
            if let dcards = dcards{
                self.updateUI(with: dcards)
            }else{
                DispatchQueue.main.async {
                    self.viewcontrollerUtils.hideActivityIndicator(uiView: self.view)
                }
            }
        }
    }
    
    func updateUI(with dcards: [Dcard]) {
        DispatchQueue.main.async {
            self.dcards = dcards
            self.tableView.reloadData()
            self.viewcontrollerUtils.hideActivityIndicator(uiView: self.view)
        }
    }
    
    func refresh(){
        
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dcards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DcardCell", for: indexPath) as! DcardTableViewCell
        configure(cell, forItemAt: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dcard = dcards[indexPath.row]
        id = dcard.id
        performSegue(withIdentifier: "toContext", sender: nil)
    }
    
    func configure(_ cell: DcardTableViewCell, forItemAt indexPath: IndexPath){
        let dcard = dcards[indexPath.row]
        
        if dcard.mediaMeta.count != 0{
            let imageURL = dcard.mediaMeta[0].url
            URLSession.shared.dataTask(with: imageURL){(data, response, error) in
                if let data = data{
                    DispatchQueue.main.async {
                        cell.mediaImage.isHidden = false
                        cell.mediaImage.image = UIImage(data: data)
                        cell.mediaImage.layer.cornerRadius = 10
                        cell.mediaImage.clipsToBounds = true
                    }
                }
            }.resume()
        }else{
            cell.mediaImage.isHidden = true
        }
        
        cell.forumLabei.text = dcard.forumName
        cell.titleLabel.text = dcard.title
        cell.stateLabel.text = dcard.excerpt
        cell.commitLabel.text = ""
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.height > scrollView.contentSize.height){
            limit += 20
            fetchArticle(limit)
        }
    }

    
    // MARK: - DismissDelegate
    
    func sendCatalogs(senderData: String) {
        catalog = senderData
        limit = 20
        DcardController.shared.fetchItems(type: catalog, limit: limit){ (dcards) in
            if let dcards = dcards{
                self.updateUI(with: dcards)
            }else{
            }
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toCatalogs":
            let vc = segue.destination as! DcardCatalogViewController
            vc.delegate = self
            
        case "toContext":
            let vc = segue.destination as! DcardContextViewController
            vc.id = self.id
            
        default:
            break
        }
        
    }
}

