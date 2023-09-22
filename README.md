# Cinemate

Cinemate is a native iOS application that allows users to discover and explore movies using The Movie Database (TMDb) API. It follows the VIPER architecture pattern and leverages Swift 5, UICollectionViewDiffableDataSource, UICollectionViewCompositionalLayout, and SDWebImage for efficient data management and beautiful movie displays.

| Home | Genres | Details |
|---|---|---|
| ![Cinemate Screenshot](https://github.com/chrisferdian/Cinemate/assets/24392359/2ded3349-ab5e-4512-8072-b244303b188d) | ![Cinemate Screenshot](https://github.com/chrisferdian/Cinemate/assets/24392359/9042328e-9870-4ef4-971b-1db233b74d60) | ![Cinemate Screenshot](https://github.com/chrisferdian/Cinemate/assets/24392359/f13c0e36-9dae-4191-a959-4e55e699d2fe) |

## Features

- **Genre Exploration:** Explore a list of official movie genres.
- **Discover Movies:** Discover movies by genre.
- **Movie Details:** View detailed information about a selected movie.
- **User Reviews:** Read user reviews for movies.
- **Trailers:** Watch movie trailers on YouTube.
- **Endless Scrolling:** Implement endless scrolling for lists of movies and user reviews.
- **Efficient Data Management:** Utilize UICollectionViewDiffableDataSource for smooth and efficient data handling.

## Architecture

Cinemate follows the VIPER architecture pattern, ensuring a clean separation of concerns and maintainability of code. The architecture components include:

- **View (MainViewController):** Responsible for displaying the user interface and handling user input.
- **Interactor (MainInteractor):** Handles business logic, data fetching, and processing.
- **Presenter (MainPresenter):** Acts as an intermediary between the view and interactor, handling data formatting and presentation logic.
- **Entity (MainEntity):** Contains data models for movies and responses.
- **Router (MainRouter):** Handles navigation and routing within the app.

## Design

Cinemate's design is inspired by the popular Netflix app. The user interface offers an intuitive and visually appealing experience for browsing and discovering movies.

![Design Preview](https://github.com/chrisferdian/Cinemate/assets/24392359/25ccb019-65b5-400e-9841-4cf46e3169bb)

For detailed design elements, you can refer to the [Figma Community Design](https://www.figma.com/community/file/928111079251292034/netflix) that served as the basis for Cinemate's UI.

## Installation

To run Cinemate locally, follow these steps:

1. Clone the repository:

git clone https://github.com/chrisferdian/Cinemate

2. Open the project in Xcode.

3. Build and run the app on a simulator or physical device.

4. Make sure to replace the API key for The Movie Database (TMDb) in the NetworkingManager with your own API key.

## Usage

- Launch the app and start exploring movies by genre.
- Select a movie to view its details, including user reviews and trailers.
- Scroll through the list of movies, and the app will load more automatically with endless scrolling.

## License

Cinemate is released under the [MIT License](LICENSE).

---

Enjoy exploring the world of movies with Cinemate! For questions or feedback, please [contact us](mailto:chris.ferdianl@gmail.com).
