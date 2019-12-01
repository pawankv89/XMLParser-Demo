//
//  XMLParserAttributeManager.swift
//  XMLParser Demo
//
//  Created by Pawan kumar on 05/06/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit
import Foundation

@objc protocol XMLParserAttributeManagerDelegate{
    func parsingWasFinished()
}

class XMLParserAttributeManager: NSObject, XMLParserDelegate {
    
    var artcle : Article!
    var arrArtcle = [Article]()
    
    var foundCharacters = ""
    
    var delegate : XMLParserAttributeManagerDelegate?
    
    func startParsingWithContentsOfURL(rssURL: URL) {
        
        //Clear All Objects
        arrArtcle.removeAll()
        arrArtcle = [Article]()
        
        let parser = XMLParser(contentsOf: rssURL)
        parser!.delegate = self
        let success: Bool = parser!.parse()
        if success {
            print("Success")
            
        }else {
            print("Failed")
        }
    }
    
    func startParsingWithContentsOfURL(localPathURL: URL) {
        
        //Clear All Objects
        arrArtcle.removeAll()
        arrArtcle = [Article]()
        
        let parser = XMLParser(contentsOf: localPathURL)
        parser!.delegate = self
        let success: Bool = parser!.parse()
        if success {
            print("Success")
            
        }else {
            print("Failed")
        }
    }
    
    
    //MARK: XMLParserDelegate method implementation
    
    func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.parsingWasFinished()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item" {
            artcle = Article()
        }
        
        if artcle != nil {
        
            //Objects Attrbutes tems here
            if elementName == "title" {
                
                let titleAttrbute = Title()
                for stirng in attributeDict {
                    
                    let strvalue = stirng.value as NSString
                    
                    switch stirng.key {
                        
                    case "id":
                        titleAttrbute.id = strvalue as String
                        break
                        
                    case "name":
                        titleAttrbute.name = strvalue as String
                        break
                        
                    case "location":
                        titleAttrbute.location = strvalue as String
                        break
                        
                    default:
                        break
                    }
                }
                
                artcle.titleAttrbutes = titleAttrbute
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if artcle != nil {
            
            //Array List Start Object here
            if elementName == "item" {
                arrArtcle.append(artcle)
                artcle = nil
            }
            
            //Objects tems here
            if elementName == "title" {
                artcle.title = foundCharacters
            }
            if elementName == "link" {
                artcle.link = foundCharacters
            }
            if elementName == "description" {
                artcle.desc = foundCharacters
            }
            if elementName == "pubDate" {
                artcle.pubDate = foundCharacters
            }
            
            foundCharacters = ""
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        foundCharacters = string
    }
    
    
    private func parser(_ parser: XMLParser, parseErrorOccurred parseError: NSError!) {
        print(parseError.description)
    }
    
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print(validationError.localizedDescription)
    }
    
}
