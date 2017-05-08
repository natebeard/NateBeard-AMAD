//
//  VRModeViewController.swift
//  pathos
//
//  Created by Siddharth on 4/30/17.
//  Copyright © 2017 pathos. All rights reserved.
//

import UIKit

class VRModeViewController: UIViewController, GVRWidgetViewDelegate, GVRVideoViewDelegate
{

    @IBOutlet var vrView: GVRVideoView!
    
    let videoURL = "https://s3-us-west-1.amazonaws.com/mybeautifulhome/Flat-Equirectangular_360.mp4"
    
    var isFinished = false //Set to true when video has finished playing
    var isError = false //Set to true if video fails to load
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        vrView.load(from: URL(string: videoURL))
        vrView.enableCardboardButton = true
        vrView.enableInfoButton = false
        
        vrView.delegate = self
        
        //This is what makes the video VR mode by default
        vrView.displayMode = GVRWidgetDisplayMode.fullscreenVR
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        let alert = UIAlertController(title: "Memory issue!!", message: "You don't have enough memory on your phone. Please clear some memeory and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Widget View
//    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!)
//    {
//    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!, withErrorMessage errorMessage: String!)
    {
        isError = true //There was an error loading the video. eg: no internet
        vrView.displayMode = GVRWidgetDisplayMode.embedded //The VR mode is exitted.
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode)
    {
        if(displayMode == GVRWidgetDisplayMode.embedded) //If the user is not in VR mode
        {
            vrView.pause()
            
            if(isFinished == true)
            {
                //User is taken to the about page after video finishes playing.
                self.performSegue(withIdentifier: "VRToAbout", sender: self)
            }
            else if(isError == true)
            {
                let alert = UIAlertController(title: "Oops", message: "Something went wrong with loading your video. Please go back and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            //User is in VR mode and the video should start playing
            vrView.play()
        }
    }
    
//    func widgetViewDidTap(_ widgetView: GVRWidgetView!)
//    {
//    }
    
    
    
    //MARK:- VideoView View
    func videoView(_ videoView: GVRVideoView!, didUpdatePosition position: TimeInterval)
    {
        if position >= videoView.duration()
        {
            //Video has finished playing.
            isFinished = true
            vrView.displayMode = GVRWidgetDisplayMode.embedded
        }
    }

}
