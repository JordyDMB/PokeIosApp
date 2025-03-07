//
//  AbilityDetail.swift
//  PokeApp
//
//  Created by MacBookTicsInplanet on 6/3/25.
//
struct AbilityDetail: Codable {
    let id: Int
    let name: String
    let isMainSeries: Bool
    let generation: NamedAPIResource
    var effectEntries: [VerboseEffect] = [VerboseEffect]()
    var effectChanges: [AbilityEffectChange] = [AbilityEffectChange]()
    var flavorTextEntries: [AbilityFlavorText] = [AbilityFlavorText]()
    var names: [Name]
    var pokemon: [AbilityPokemon] = [AbilityPokemon]()

    enum CodingKeys: String, CodingKey {
        case id, name
        case isMainSeries = "is_main_series"
        case generation
        case effectEntries = "effect_entries"
        case effectChanges = "effect_changes"
        case flavorTextEntries = "flavor_text_entries"
        case names, pokemon
    }
}

// MARK: - NamedAPIResource
struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

// MARK: - VerboseEffect
struct VerboseEffect: Codable {
    let effect: String
    let shortEffect: String
    let language: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case effect
        case shortEffect = "short_effect"
        case language
    }

    
    static func from(effect : EffectChange) -> VerboseEffect {
        return VerboseEffect(effect: effect.effect, shortEffect: "", language: effect.language)
    }
    
    static func from(flavor : AbilityFlavorText) -> VerboseEffect {
        return VerboseEffect(effect: flavor.flavorText, shortEffect: "", language: flavor.language)
    }
    
}

// MARK: - AbilityEffectChange
struct AbilityEffectChange: Codable {
    let effectEntries: [EffectChange]
    let versionGroup: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case versionGroup = "version_group"
    }
}

// MARK: - EffectChange
struct EffectChange: Codable {
    let effect: String
    let language: NamedAPIResource
}

// MARK: - AbilityFlavorText
struct AbilityFlavorText: Codable {
    let flavorText: String
    let language: NamedAPIResource
    let versionGroup: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}

// MARK: - Name
struct Name: Codable {
    let name: String
    let language: NamedAPIResource
}

// MARK: - AbilityPokemon
struct AbilityPokemon: Codable {
    let isHidden: Bool
    let slot: Int
    let pokemon: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, pokemon
    }
}
