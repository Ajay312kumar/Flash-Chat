

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    let textFlash = "⚡️FlashChat"
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        for letter in textFlash {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(index), repeats: false) {(timer) in
                
                self.titleLabel.text?.append(letter)
            }
            index += 1
        }
        
    }
    

}
