import UIKit
import SDWebImage
import Cosmos


class DisplayDetailsViewController: UIViewController {

    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var genereValue: UILabel!
    @IBOutlet var yearValue: UILabel!
    @IBOutlet var titleValue: UILabel!
    @IBOutlet var imageDetails: UIImageView!

    
    var str:String = ""
   
    var selectedMovie: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        genereValue.text = selectedMovie?.genere.joined(separator: " , ")
        yearValue.text = String(selectedMovie?.year ?? 0)
        titleValue.text = selectedMovie?.title

        ratingView.rating = Double(selectedMovie?.rating ?? 0)
        ratingView.settings.fillMode = .full
        ratingView.isUserInteractionEnabled = false
        imageDetails.image = selectedMovie?.image
        self.imageDetails.frame.size.width = self.imageDetails.frame.size.height
        self.imageDetails.layer.cornerRadius = self.imageDetails.frame.width / 2
        self.imageDetails.clipsToBounds = true
        

        



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

