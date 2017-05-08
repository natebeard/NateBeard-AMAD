//
//  Experiences.swift
//  pathos
//
//  Created by Nathan Beard on 5/7/17.
//  Copyright © 2017 pathos. All rights reserved.
//

import Foundation
import Firebase

class Experiences {
    

    var text: String
    var url: String
    // var image: String
    // do the same thing as text and URL
    
    init(newText: String, newURL: String){
        text = newText
        url = newURL
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: String]
        text = snapshotValue["text"]!
        url = snapshotValue["URL"]!
    }
    

    
    
    // for full struct:
//    var experienceImage: UIImage?
//    var experienceText: String
//    var experienceURL: String
//    
//    
//    init(experienceImage: UIImage, experienceText: String, experienceURL: String) {
//        self.experienceImage = experienceImage
//        self.experienceText = experienceText
//        self.experienceURL = experienceURL
//    }
    
    
}














// Trying to pass strings for images:
//    var vrImages = [URL]()
//
//    private func putShitIN() {
////        let image1 = UIImage(named: "beautifulhomebottonshape")
////        let image2 = UIImage(named: "comingsoon")
//
//        if let path = Bundle.main.resourcePath {
//
//            let imagePath = path + "/images"
//            let url = NSURL(fileURLWithPath: imagePath)
//            let fileManager = FileManager.default
//
//            let properties = [URLResourceKey.localizedNameKey,
//                              URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
//
//            do {
//                let imageURLs = try fileManager.contentsOfDirectory(at: url as URL, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
//
//                print("image URLs: \(imageURLs)")
//                // Create image from URL
//                // ME: Too much shit to create a descriptor from Asset images...
//                var myImage =  UIImage(data: NSData(contentsOfURL: imageURLs[vrImages])!)
//
//            } catch let error1 as NSError {
//                print(error1.description)
//            }
//        }
//
//    }



