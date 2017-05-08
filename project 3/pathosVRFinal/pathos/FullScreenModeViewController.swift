//
//  StreamPreviewViewController.swift
//  pathos
//
//  Created by Siddharth on 4/16/17.
//  Copyright © 2017 pathos. All rights reserved.
//

import UIKit

class FullScreenModeViewController: UIViewController, GVRWidgetViewDelegate, GVRVideoViewDelegate
{

    @IBOutlet weak var videoVRView: GVRVideoView!
    
    let videoURL = "https://s3-us-west-1.amazonaws.com/mybeautifulhome/Flat-Equirectangular_360.mp4"
    
    var isFinished = false //Set to true when video finishes playing
    var isError = false //Set to true if video fails to load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        videoVRView.load(from: URL(string: videoURL))
        
        videoVRView.enableFullscreenButton = true
        videoVRView.enableInfoButton = false
        
        videoVRView.delegate = self
        
        //This is what makes the view fullscreen by default
        videoVRView.displayMode = GVRWidgetDisplayMode.fullscreen
    }

    
    override func didReceiveMemoryWarning() {
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
        videoVRView.displayMode = GVRWidgetDisplayMode.embedded //The fullscreen mode is exitted.
    }

    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode)
    {
        if(displayMode == GVRWidgetDisplayMode.embedded) //If the user is not in full screen mode
        {
            videoVRView.pause()
            if(isFinished == true)
            {
                //User is taken to the about page after video finishes playing.
                self.performSegue(withIdentifier: "FullscreenToAbout", sender: self)
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
            //User is in fullscreen mode and video should start playing.
            videoVRView.play()
        }
    }

    // platy/pause func
//    func widgetViewDidTap(_ widgetView: GVRWidgetView!)
//    {
//    }
    
    
    
    
    
    //MARK:- Video View
    func videoView(_ videoView: GVRVideoView!, didUpdatePosition position: TimeInterval)
    {
        if position >= videoView.duration()
        {
            //Video has finished playing. 
            isFinished = true
            videoVRView.displayMode = GVRWidgetDisplayMode.embedded
        }
    }
}











