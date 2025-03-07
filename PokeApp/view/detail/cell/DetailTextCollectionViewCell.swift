//
//  DetailTextCollectionViewCell.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 7/3/25.
//

import UIKit

class DetailTextCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setText(txt : String) {
//        print("-----------")
//        print(txt)
        label.text = txt
    }

}
