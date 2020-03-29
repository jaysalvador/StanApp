# Stan App

Demo App for Stan displaying Movies and Series available

<p align="left">
  <img src="https://github.com/jaysalvador/StanApp/blob/master/images/01.png" width="150" alt="accessibility text">

  <img src="https://github.com/jaysalvador/StanApp/blob/master/images/04.png" width="150" alt="accessibility text">

  <img src="https://github.com/jaysalvador/StanApp/blob/master/images/02.png" width="150" alt="accessibility text">

  <img src="https://github.com/jaysalvador/StanApp/blob/master/images/03.png" width="150" alt="accessibility text">
</p>

## StanLib

Created a static library `StanLib` that handles data retrieval and serialisation of the Stan data.

Implemented `HttpClient` class to handle HTTP requests to the API and decodes the response to any `Decodable` type object.

All API responses will be conforming to this closure, using the `Result` type:
>  `HttpCompletionClosure<T> = ((Result<T, HttpError>) -> Void)`

`T` would need to conform to `Decodable` protocol, and errors will be extended using the `HttpError` enum states

## Client-side App

The app architecture is built using the MVVM pattern and Protocol-oriented programming and Dependency Injection principles.

### Cocoapods Dependency

- [Dwifft](https://github.com/jflinter/Dwifft) 
  - library has been used in this project to handle `UICollectionView` reloading and refreshing. `Section` and `Item` types are provided to define the `UICollectionView` sections and items, and must adhere to `Equatable` protocol. These types will be used within the `Dwifft` library to easily compare and reload the collection and its cells.
  - `JCollectionViewController` 
     - is class that extends `UIViewController` and implements `UICollectionView` delegates, and adheres to the `Dwifft` library implementation. 
     - The class provides easier access to sections and items of the collectionView by overriding the `UICollectionView` standard delegate functions to provide `Section` and `Item` type objects, abstracting the searching of the binded data using `IndexPath`
- [Hero](https://github.com/HeroTransitions/Hero)
  - used for transitions
- [Kingfisher](https://github.com/onevcat/Kingfisher)
  - used for loading images
  
## Testing

`UnitTest`
- `testMovies`
  - testing mock json data from the API, loaded from `DataHelper`
  
`UITests`
- `testUI`
  - Testing scrolling and tapping on movie item


#### * Coding Style

My coding style tends to have more indentation and spacing, similar to writing a term paper for easier reading.

For more queries, please feel free to contact me at jay.andrae.salvador@gmail.com
