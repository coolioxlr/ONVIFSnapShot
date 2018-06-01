import UIKit

/**
 This controller plays the live stream through VLC of the URI passed by the previous view controller.
 */
class StreamViewController: UIViewController {
    
    var URI: String?
    @IBOutlet weak var movieView: UIView!
    var mediaPlayer = VLCMediaPlayer()
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Associate the movieView to the VLC media player
        mediaPlayer.drawable = self.movieView
        
        // Create `VLCMedia` with the URI retrieved from the camera
        if let URI = URI {
            let url = URL(string: URI)
            let media = VLCMedia(url: url)
            mediaPlayer.media = media
        }
        
        mediaPlayer.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mediaPlayer.stop()
    }
    
    @IBAction func snapshotClicked(_ sender: Any) {
        
        self.extractFrame()
    
    }
    
    func extractFrame(){
        
        
        let size = movieView.frame.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let rec = movieView.frame
        
        // Add navigation bar height
        let newRec = CGRect(x: rec.origin.x, y: rec.origin.y - 88, width: rec.size.width, height: rec.size.height)
        movieView.drawHierarchy(in: newRec, afterScreenUpdates: false)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        UIGraphicsEndImageContext();
    }
}
