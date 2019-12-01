//
//  ThirdViewController.swift
//  XMLParser Demo
//
//  Created by Pawan kumar on 05/06/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

//Resource
//https://www.apple.com/rss/

import UIKit
import Foundation

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  XMLParserAttributeManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var xmlParser : XMLParserAttributeManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set Title
        self.tabBarController?.navigationItem.title = "RSS Load From Local With Attributes"
        
        //WithOut Nib
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "article")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        
        //With Nib
        let nib = UINib.init(nibName: ArticleTableCell.identifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ArticleTableCell.identifier)
        
        //Load File
        if let path = Bundle.main.url(forResource: "AppleDeveloperNewsAttributes", withExtension: "xml") {
            
            xmlParser = XMLParserAttributeManager()
            xmlParser.delegate = self
            xmlParser.startParsingWithContentsOfURL(localPathURL: path)
        }
    }
    
    
    // MARK: XMLParserManagerDelegate method implementation
    
    func parsingWasFinished() {
        self.tableView.reloadData()
        print("parsingWasFinished")
        print("List items:- \(xmlParser.arrArtcle)")
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if xmlParser == nil {
            return 0
        }
        
        return xmlParser.arrArtcle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableCell.identifier, for: indexPath as IndexPath) as!  ArticleTableCell
        
        let article = xmlParser.arrArtcle[indexPath.row] as Article
        
        cell.titleLabel!.text = "Title:- \(article.title) Id:- \(article.titleAttrbutes.id) Name:- \(article.titleAttrbutes.name) Location:- \(article.titleAttrbutes.location)"
        cell.dateLabel!.text = article.pubDate
        cell.descLabel!.text = article.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        //print(dictionary)
        
        let article = xmlParser.arrArtcle[indexPath.row] as Article
        //print(article.pubDate)
        print(article.titleAttrbutes.location)
    }
    
}

