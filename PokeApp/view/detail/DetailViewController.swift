//
//  DetailViewController.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 6/3/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var ability : AbilityResponse?
    let viewModel = DetailViewModel()
    @IBOutlet weak var collectionDetail: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mAbility = ability {
            title = mAbility.name.capitalized
            viewModel.setAbility(ability: mAbility)
            viewModel.fetchDetail()
            setupCollectionView()
            setupViewModel()
        }
    }
    
    func setupCollectionView(){
        collectionDetail.delegate = self
        collectionDetail.dataSource = self
        collectionDetail.register(UINib(nibName: "DetailTextCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "DetailTextCollectionViewCell")
        collectionDetail.register(UINib(nibName: "DetailHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeaderReusableView")
        
    }
    
    func setupViewModel(){
        viewModel.onUpdate = { [weak self] in
            self?.collectionDetail.reloadData()
        }
        viewModel.onError =  { [weak self] in
            self?.showAlertError()
        }
    }
    
    func showAlertError(){
        let alert = UIAlertController(title: "Error!", message: "Revise su conexión a internet y vuelva a intentar.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entiendo", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}



extension DetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
    }
    
}

extension DetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTextCollectionViewCell", for: indexPath) as? DetailTextCollectionViewCell
        switch indexPath.section{
        case 0:
            let entry = viewModel.getEffectEntries()[indexPath.row]
            cell?.setText(txt: entry.effect)
        case 1:
            let change = viewModel.getEffectChanges()[indexPath.row]
            cell?.setText(txt: change.effectEntries.map { $0.effect }.joined())
        case 2:
            let fText = viewModel.getFlavorText()[indexPath.row]
            cell?.setText(txt: fText.flavorText)
        case 3:
            let name = viewModel.getnames()[indexPath.row]
            cell?.setText(txt: name.name)
        default:
            cell?.setText(txt: "none")
            break
        }
        return cell!
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.getEffectEntries().count
        case 1:
            return viewModel.getEffectChanges().count
        case 2:
            return viewModel.getFlavorText().count
        case 3:
            return viewModel.getnames().count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailHeaderReusableView", for: indexPath) as! DetailHeaderReusableView
            switch indexPath.section {
            case 0:
                header.setTitle(txt: "Effect Entries")
            case 1:
                header.setTitle(txt: "Effect Changes")
            case 2:
                header.setTitle(txt: "Flavor Text")
            case 3:
                header.setTitle(txt: "Names")
            default:
                break
            }
            return header
        }
        return UICollectionReusableView()
    }
    
}
