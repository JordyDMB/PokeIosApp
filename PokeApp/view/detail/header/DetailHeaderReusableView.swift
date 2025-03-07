

import UIKit

class DetailHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(txt : String) {
        label.text = txt
    }
    
}
