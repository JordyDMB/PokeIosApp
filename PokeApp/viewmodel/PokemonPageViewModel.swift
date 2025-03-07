//
//  PokemonPageViewModel.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 6/3/25.
//

import Foundation
import Alamofire


class PokemonPageViewModel {
    
    private var abilities: [AbilityResponse] = []
    private var nextURL: String? = "https://pokeapi.co/api/v2/ability/?limit=10"
    var onUpdate: (() -> Void)?
    
    func fetchAbilities() {
        guard let urlString = nextURL, let url = URL(string: urlString) else { return }
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: PokemonPageResponse.self) { response in
                switch response.result{
                case .success(let result):
                    self.abilities.append(contentsOf: result.results)
                    self.nextURL = result.next
                    DispatchQueue.main.async {
                        self.onUpdate?()
                    }
                case .failure(let error):
                    print("El error es \(error)")
                }
                
            }
    }
    
    func numberOfAbilities() -> Int {
        return abilities.count
    }
    
    func ability(at index: Int) -> AbilityResponse {
        return abilities[index]
    }
    
}
