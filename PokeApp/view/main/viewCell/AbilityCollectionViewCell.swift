

import UIKit

class AbilityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameAbility: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setName(ability : String){
        nameAbility.text = ability.capitalized
    }

}
