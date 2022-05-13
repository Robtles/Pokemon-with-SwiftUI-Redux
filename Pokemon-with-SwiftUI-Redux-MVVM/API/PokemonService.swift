//
//  PokemonService.swift
//  FinalTestAPI
//
//  Created by Rob on 12/05/2022.
//

import Foundation
import Moya

// MARK: - Pokemon Service
/// Enumerates all the required Pokemon API endpoints
enum PokemonService {
    // MARK: Static Properties
    /// The API base URL
    fileprivate static let baseURL = "https://pokeapi.co/api/v2/"
    /// The request provider
    static let provider = MoyaProvider<PokemonService>()
    
    // MARK: Cases
    /// Fetches all the first 151 Pokemon
    case all
    /// Fetches the description of a specific Pokemon, identified by its index in Kanto's Pokedex
    case description(id: Int)
    /// Fetches the eventual evolution chains of a specific Pokemon.
    /// Important note: the id is not the one of the Pokemon,
    /// it is to be found instead from the `species` endpoint first!
    case evolution(id: Int)
    /// Fetches the description of a specific Pokemon species, identified by its index in Kanto's Pokedex
    case species(id: Int)

    // MARK: Fetch Helper
    /// Fetches all the 151 Pokemon of the Kanto region. This API only gets their name
    /// - Parameter completion: The result, either the fetched `Pokemon` list or an error
    static func fetchAllPokemons(_ completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        PokemonService.fetchAll { result in
            switch result {
            case .success(let response):
                completion(.success(
                    response
                        .results
                        .enumerated()
                        .map {
                            let pokemon = Pokemon($0.offset + 1)
                            pokemon.feed(with: $0.element)
                            return pokemon
                        }
                ))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Fully fetches a `Pokemon` information: its description and its
    /// species information, then its evolution chain info.
    /// `completion(pokemon)` is called after every API fetch result instead of waiting for the full data to return
    /// - Parameters:
    ///   - id: The Pokemon identifier in Kanto's Pokedex
    ///   - completion: The completion with the updated `Pokemon`
    static func fetch(pokemonWithId id: Int, _ completion: @escaping (Pokemon) -> Void) {
        let pokemon = Pokemon(id)
        PokemonService.fetchDescription(for: id) { result in
            switch result {
            case .success(let response):
                pokemon.feed(with: response)
            default:
                break
            }
            completion(pokemon)
        }
        PokemonService.fetchSpecies(for: id) { result in
            switch result {
            case .success(let response):
                pokemon.feed(with: response)
                fetch(pokemon, evolutionChainWith: response) {
                    print("")
                    completion($0)
                }
            default:
                break
            }
            completion(pokemon)
        }
    }
    
    // MARK: Internal Evolution Fetch Utility
    /// Fetches a `Pokemon` evolution chain from its id, which is to be found in the species result previously fetched
    /// - Parameters:
    ///   - pokemon: The `Pokemon` to fetch
    ///   - pokemonSpeciesResult: The passed species result
    ///   - completion: The completion with the newly fed Pokemon
    private static func fetch(
        _ pokemon: Pokemon,
        evolutionChainWith pokemonSpeciesResult: PokemonSpeciesResult,
        _ completion: @escaping (Pokemon) -> Void
    ) {
        guard let evolutionChainId = pokemonSpeciesResult.evolutionChain.url.extractedIdFromUrl else {
            completion(pokemon)
            return
        }
        PokemonService.fetchEvolutions(for: evolutionChainId) { evolutionChainResult in
            switch evolutionChainResult {
            case .success(let evolutionChainResponse):
                pokemon.feed(with: evolutionChainResponse)
            default:
                break
            }
            completion(pokemon)
        }
    }
    
    // MARK: Internal Fetch Methods
    /// Fetches all the 151 original Pokemon from Kanto
    private static func fetchAll(_ completion: @escaping (Result<PokemonAllResult, Error>) -> Void) {
        PokemonService.all.fetch(PokemonAllResult.self) { result in
            completion(result)
        }
    }
    
    /// Fetches the description of a Pokemon identified by its Kanto's Pokedex id
    /// - Parameters:
    ///   - id: The Pokemon Kanto's id
    ///   - completion: The fetch result
    private static func fetchDescription(
        for id: Int,
        _ completion: @escaping (Result<PokemonDescriptionResult, Error>) -> Void
    ) {
        PokemonService.description(id: id).fetch(PokemonDescriptionResult.self) { result in
            completion(result)
        }
    }
    
    /// Fetches a Pokemon evolution chain
    /// - Parameters:
    ///   - id: The Pokemon evolution chain id. Please note that this is not the Pokemon's Pokedex index!
    ///   You can fetch the Pokemon evolution chain id beforehand by calling `fetchSpecies(id)`
    ///   - completion: The fetch result
    private static func fetchEvolutions(
        for id: Int,
        _ completion: @escaping (Result<PokemonEvolutionResult, Error>) -> Void
    ) {
        PokemonService.evolution(id: id).fetch(PokemonEvolutionResult.self) { result in
            completion(result)
        }
    }
    
    /// Fetches the description of a Pokemon species identified by its Kanto's Pokedex id
    /// - Parameters:
    ///   - id: The Pokemon Kanto's id
    ///   - completion: The fetch result
    private static func fetchSpecies(
        for id: Int,
        _ completion: @escaping (Result<PokemonSpeciesResult, Error>) -> Void
    ) {
        PokemonService.species(id: id).fetch(PokemonSpeciesResult.self) { result in
            completion(result)
        }
    }
    
    /// A generic function to fetch the API with Moya in a uniform way
    /// - Parameters:
    ///   - type: The expected decoded JSON result type
    ///   - completion: The fetch result, containing either a decoded response or an error
    private func fetch<T: Codable>(
        _ type: T.Type,
        _ completion: @escaping (Result<T, Error>) -> Void
    ) {
        PokemonService.provider.request(self) { result in
            switch result {
            case .success(let response):
                guard response.statusCode == 200 else {
                    completion(.failure(PokemonAPIError.badStatusCode(response.statusCode)))
                    return
                }
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: response.data) else {
                    completion(.failure(PokemonAPIError.contentDecodingFailed))
                    return
                }
                completion(.success(decodedResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Moya TargetType Conformance
extension PokemonService: TargetType {
    var baseURL: URL {
        URL(string: PokemonService.baseURL)!
    }
    
    var path: String {
        switch self {
        case .all:
            return "pokemon"
        case .description(let id):
            return "pokemon/\(id)"
        case .evolution(let id):
            return "evolution-chain/\(id)"
        case .species(let id):
            return "pokemon-species/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .all:
            return .requestParameters(
                parameters: [
                    "limit": 151
                ],
                encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
