

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionAbilities: UICollectionView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    let viewModel = PokemonPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupViewModel()
        viewModel.fetchAbilities()
    }
    
    
    func setupUi(){
        title = "Habilidades"
        collectionAbilities.delegate = self
        collectionAbilities.dataSource = self
        collectionAbilities.register(UINib(nibName: "AbilityCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "AbilityCollectionViewCell")
    }
    
    func setupViewModel(){
        viewModel.onUpdate = { [weak self] in
            self?.collectionAbilities.reloadData()
            self?.progress.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail_segue" {
            if let vc = segue.destination as? DetailViewController {
                if let data = sender as? AbilityResponse {
                    vc.ability = data
                }
            }
        }
    }

}


extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfAbilities()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AbilityCollectionViewCell", for: indexPath) as! AbilityCollectionViewCell
        cell.setName(ability: viewModel.ability(at: indexPath.row).name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfAbilities() - 1 {
            self.progress.isHidden = false
            viewModel.fetchAbilities()
        }
    }

    
}


extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ability = viewModel.ability(at: indexPath.row)
        self.performSegue(withIdentifier: "detail_segue", sender: ability)
        
    }
    
}


extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 50)
    }
    
}
