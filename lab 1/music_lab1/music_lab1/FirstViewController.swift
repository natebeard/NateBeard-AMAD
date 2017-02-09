//
//  FirstViewController.swift
//  music_lab1
//
//  Created by Nathan Beard on 2/2/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var artistAblumLabel: UILabel!
    @IBOutlet weak var artistAlbumpicker: UIPickerView!
    
    //
    let artistComponent = 0
    let albumComponent = 1
    
    var artistAlbums = [String: [String]]()
    var artists = [String]()
    var albums = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // call data file (getDataFile func defined below), to handle the potential error in the first "else" statement 
        guard let path = getDataFile() else{
            print("Error loading file")
            return
            // if nil, then fail, else return true
        }
        // this is the "if" statement:
        // use NSDictionary to load the plist and cast ("as!") to a Swift Dictionary defined above (structure of plist), which is more specific
        artistAlbums =  NSDictionary(contentsOfFile: path) as! [String:[String]]
        
        // Once casted as a disctionary, get Dictionary keys and assign to the artists array
        artists = Array(artistAlbums.keys)
        // assign all the albums for the first artist in the albums array
        albums = artistAlbums[artists[0]]! as [String]
    }
    
    
    func getDataFile() -> String? {
        // need path to file so we can get the data (Bundle object)
        // don't want it to crash if there's an error, so use guard statement
        guard let pathString = Bundle.main.path(forResource: "artistalbums", ofType: "plist")
            else {
                return nil
        }
        print(pathString)
        return pathString
    }
    
    
    
    // Next three methods to implement picker: 2 columns, rows = artist/album array count and titles for rows of those arrays
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == artistComponent{
            return artists.count
        } else {
            return albums.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == artistComponent {
            return artists[row]
        } else {
            return albums[row]
        }
    }
    
    
    // Function for dependent picker:
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == artistComponent{
            let selectedArtist = artists[row] // get selected artist
            albums = artistAlbums[selectedArtist]! // gets albums for artists selected
            artistAlbumpicker.reloadComponent(albumComponent)
            artistAlbumpicker.selectRow(0, inComponent: albumComponent, animated: true)
        }
        let artistrow = pickerView.selectedRow(inComponent: artistComponent)
        let albumrow = pickerView.selectedRow(inComponent: albumComponent)
        artistAblumLabel.text = "You like \(albums[albumrow]) by \(artists[artistrow])"
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

