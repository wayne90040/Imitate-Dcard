//
//  DcardContextViewController.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/19.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import UIKit

class DcardContextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    var id = Int()
    var content: Content?
    var comments: [Comment]?
    let viewcontrollerUtils = ViewControllerUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .singleLine
        
        mainTableView.register(UINib(nibName: "DcardContextTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        mainTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        
        DispatchQueue.main.async {
            self.viewcontrollerUtils.showActivityIndicator(uiView: self.view)
        }
    
        DcardController.shared.fetchContent(id: id){(content) in
            if let content = content{
                self.updateUI(with: content)
            }else{
                DispatchQueue.main.async {
                    self.viewcontrollerUtils.hideActivityIndicator(uiView: self.view)
                }
            }
        }
        
        DcardController.shared.fetchComment(id: id){(comments) in
            if let comments = comments{
                self.updateComments(with: comments)
            }else{
                DispatchQueue.main.async {
                    self.viewcontrollerUtils.hideActivityIndicator(uiView: self.view)
                }
            }
        }
    }
    
    
    func updateUI(with content: Content){
        DispatchQueue.main.async {
            self.content = content
            self.mainTableView.reloadData()
            self.viewcontrollerUtils.hideActivityIndicator(uiView: self.view)
        }
    }
    
    func updateComments(with comments: [Comment]){
        DispatchQueue.main.async {
            self.comments = comments
            self.mainTableView.reloadData()
        }
        
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return comments?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DcardContextTableViewCell
            configure_normal(cell, forItemAt: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
            configure_comments(cell, forItemAt: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            return cell!
        }
    }
    
    func configure_normal(_ cell: DcardContextTableViewCell, forItemAt indexPath: IndexPath){
        
        let containArray = (content?.content ?? "")?.split(separator: "\n").map(String.init)
        let mutableString = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 10.0
        
        containArray?.forEach{ line in
            if line.contains("http"){
                guard let url = URL(string: line) else {return}
                UIImage.image(from: url) {(image) in
                    guard let image = image else {return}
                    let scaleImg = image.scale(with: UIScreen.main.bounds.width / image.size.width * 0.8)
                    let attachment = NSTextAttachment()
                    
                    attachment.image = scaleImg
                    mutableString.append(NSAttributedString(attachment: attachment))
                    mutableString.append(NSAttributedString(string: "\n"))
                }
            }else{
                mutableString.append(NSAttributedString(string: line + "\n", attributes: [.font: UIFont.systemFont(ofSize: 15), .paragraphStyle: paragraphStyle]))
            }
        }
       
        cell.titleLabel.text = content?.title
        cell.forumLabel.text = content?.forumName
        cell.dateTimeLabel.text = content?.getCreatedAt()
        cell.schoolLabel.text = content?.school ?? "匿名"
        
        switch content?.gender {
        case "F":
            cell.genderLabel.text = "女同學"
            cell.profileImg.image = UIImage(named: "woman.png")
        case "M":
            cell.genderLabel.text = "男同學"
            cell.profileImg.image = UIImage(named: "man.png")
        default:
            cell.profileImg.image = UIImage(named: "man.png")
            cell.genderLabel.text = "匿名"
        }
        
        cell.contextTxtView.attributedText = mutableString
    }
    
    func configure_comments(_ cell: CommentTableViewCell, forItemAt indexPath: IndexPath){
        
        let comment = comments?[indexPath.row]
        let floor = comment?.floor ?? 0
        
        switch comment?.gender {
        case "F":
            cell.profileImg.image = UIImage(named: "woman.png")
        case "M":
            cell.profileImg.image = UIImage(named: "man.png")
        default:
            cell.profileImg.image = UIImage(named: "man.png")
        }
        
        cell.schoolLabel.text = comment?.school ?? "匿名"
        cell.floorLabel.text = "B" + floor.description + ", " + (comment?.createdAt ?? "")
        cell.commentTxtView.text = comment?.content
    
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

extension UIImage{
    func scale(with scale: CGFloat) -> UIImage?{
        let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
        
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func image(from url: URL, handle: @escaping (UIImage?) -> ()) {
        guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
            handle(nil)
            return
        }
        handle(image)
    }
}
