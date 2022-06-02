# Pokemon-with-SwiftUI-Redux

This is a simple, playground project where I will try to build a Pokedex app. This app will use the combine the following patterns and frameworks:
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) (targeting iOS 14.0)
- [Redux](https://redux.js.org) for app state management
- ~~[MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)~~

Every step will be documented in this file.

## Dependencies

- `SwiftLint`: to ensure keeping a clean syntax, I will use SwiftLint as a dependency. As it does not handle Swift Package Manager yet, I will use CocoaPods instead to add it to the project.
- `Moya`: all the API requests will be simplified with Moya, which itself also embeds `Alamofire` - see API section below.
- `Kingfisher`: will be used for image downloading/caching.
- `SwiftUIFlux`: serves as Redux's implementation.

## Expected design

I will try to reproduce [AC1Design's work](https://dribbble.com/shots/15128634-Pokemon-Pokedex-Website-Redesign-Concept), in a mobile way (the specific Pokemon sheet will appear as a modal above the list).

![test](https://user-images.githubusercontent.com/25252204/168324402-3d39370e-c367-4393-8279-ab9f692bf709.jpg)

## Model

The main object of the model will be of course the one representing a `Pokemon`. The following information will be fetched from the API : name, description, abilities, height, weight, stats, type and evolution chain. 

Some subtypes will also exist and evolve to follow the design needs: `PokemonType`, `PokemonStat`, `PokemonEvolutionItem` and `PokemonEvolutionType`.

The id of the Pokemons will be inferred at first. The image URLs will be inferred from the Pokemon ids.

## API

To fetch all the required data, I will use the [PokeAPI](https://pokeapi.co/docs/v2) as it provides full and exhaustive data and does not require any key.

Two main calls are to be made, each of them corresponding to the two main views of the app:
- An initial call which will actually be a succession of calls for each of the 18 existing Pokemon types. These calls will gather information for the Pokemon types, but will also tell us which Pokemon correspond to each type, with their name and Pokedex index. This is how the initial Pokemon list will be fetched (the Pokemon's image URL will be inferred from their id).
- Some `.description(id)`, `.species(id)` and `.evolution(id)` endpoints which will gather more data to display all the required information for a given Pokemon. Please note that this information can be found through several endpoints only, so they will be called concurrently. Also, for the `.evolution(id)` endpoint, the `id` parameter does not correspond to the Pokemon id but to its specific evolution chain. This information is to be found in the `.species(id)` endpoint previously.

Moya dependency will help a lot to simplify these calls, it will return a response with some JSON content that I will map into Swift structs thanks to the [Codable](https://developer.apple.com/documentation/swift/codable) protocol.

## Redux

I choosed to use [Dimillian](https://github.com/Dimillian)'s implementation of Redux in SwiftUI: [SwiftUIFlux](https://github.com/Dimillian/SwiftUIFlux). The main changes are the following:
- The main view is embedded in a `StoreProvider` with the app store passed as a parameter. Any update to the store will then be automatically reflected on the views.
- The views whose content is related to the store (`PokemonList`, `PokemonView`...) will be `ConnectedView` objects for a better separation of concerns.

The project then contains the usual Redux pattern elements:
- **State**: represents the app state, with any update being dispatched to the views.
- **Reducer**: contains the reducer functions which is where the app logic is kept and the state values updated.
- **Action**: the possible actions which may update the app state. Note that there are both `Action` objects and `AsyncAction` objects for asynchronous purposes (usually API calls).

## ~~MVVM~~

The initial plan was to also use MVVM in this project. However, after some thinking and research, I decided not to do so as I think it will only add complexity and will probably not benefit a SwiftUI project.

See: https://developer.apple.com/forums/thread/699003
