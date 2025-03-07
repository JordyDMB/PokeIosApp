//
//  DetailHeaderReusableView.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 7/3/25.
//

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
