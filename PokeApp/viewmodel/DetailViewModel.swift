//
//  DetailViewModel.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 6/3/25.
//

import Foundation
import Alamofire

class DetailViewModel {
    
    private var detail : AbilityDetail?
    
    private var ability : AbilityResponse?
    private var detailSpanish : AbilityDetail?
    var onUpdate : (()->Void)?
    var onError : (()->Void)?
    private let spanish = "es"
    
    
    func setAbility(ability : AbilityResponse){
        self.ability = ability
    }
    
    func fetchDetail(){
        if ability == nil { return }
        AF.request(ability!.url, method: .get)
            .validate()
            .responseDecodable(of: AbilityDetail.self) { response in
                switch response.result{
                case .success(var result):
                    result.effectEntries = result.effectEntries.filter { $0.language.name == self.spanish}
                    result.effectChanges = result.effectChanges.filter{ change in
                        change.effectEntries.first { $0.language.name == self.spanish } != nil
                    }
                    result.flavorTextEntries = result.flavorTextEntries.filter { $0.language.name == self.spanish }
                    result.names = result.names.filter { $0.language.name == self.spanish }
                    self.detail = result
                    DispatchQueue.main.async {
                        self.onUpdate?()
                    }
                case .failure(let error):
                    print("El error es \(error)")
                    DispatchQueue.main.async {
                        self.onError?()
                    }
                }
            }
    }
    
    
    func getEffectEntries() -> [VerboseEffect] {
        return detail?.effectEntries ?? []
    }
    
    func getEffectChanges() -> [AbilityEffectChange] {
        return detail?.effectChanges ?? []
    }
    
    func getFlavorText() -> [AbilityFlavorText] {
        return detail?.flavorTextEntries ?? []
    }
        
    func getnames() -> [Name] {
        return detail?.names ?? []
    }
    
    
    
}
