const KEY = "3fd2be6f0c70a2a598f084ddfb75487c";
const API_URL = `https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=${KEY}&page=1`;
const IMG_PATH = "https://image.tmdb.org/t/p/w1280";
const SEARCH_API = `https://api.themoviedb.org/3/search/movie?api_key=${KEY}&query=`;

const main = document.getElementById("main");
const form = document.getElementById("form");
const search = document.getElementById("search");

const getClassByRate = (vote) => {
  if (vote >= 7.5) return "green";
  else if (vote >= 5) return "orange";
  else return "red";
};

const toggleLike = async (movieId, movieTitle) => {
  const likeButton = document.getElementById(`like-button-${movieId}`);
  const liked = JSON.parse(sessionStorage.getItem(`liked-${movieId}`)) || false;

  if (liked) {
    likeButton.style.color = "black"; // Unliked, set color to black
    likeButton.textContent = "Unliked"; // Change button text to "Unliked"
    sessionStorage.setItem(`liked-${movieId}`, JSON.stringify(false));
    // Redirect to remove_liked_movie.jsp with movie title as a query parameter
    window.location.href = `remove_liked_movie.jsp?movieId=${movieId}&movieTitle=${encodeURIComponent(movieTitle)}`;
  } else {
    likeButton.style.color = "red"; // Liked, set color to red
    likeButton.textContent = "Liked"; // Change button text to "Liked"
    sessionStorage.setItem(`liked-${movieId}`, JSON.stringify(true));
    // Redirect to add_liked_movie.jsp with movie title as a query parameter
    window.location.href = `add_liked_movie.jsp?movieId=${movieId}&movieTitle=${encodeURIComponent(movieTitle)}`;
  }
};


const showMovies = (movies) => {
  main.innerHTML = "";
  movies.forEach((movie) => {
    const { id, title, poster_path, vote_average, overview } = movie;
    const movieElement = document.createElement("div");
    
    movieElement.classList.add("movie");
    movieElement.innerHTML = `
    <img
      src="${IMG_PATH + poster_path}"
      alt="${title}"
    />
    <div class="movie-info">
      <h3>${title}</h3>
      <span class="${getClassByRate(vote_average)}">${vote_average}</span>
    </div>
    <div class="overview">
      <h3>Overview</h3>
      ${overview}
    </div>
    <button class="like-button" id="like-button-${id}" onclick="toggleLike(${id}, '${title}')"></button>
  `;
    main.appendChild(movieElement);

    const liked = JSON.parse(sessionStorage.getItem(`liked-${id}`)) || false;
    if (liked) {
      const likeButton = document.getElementById(`like-button-${id}`);
      likeButton.style.color = "red"; // Set color to red if liked
    }
  });
};

const getMovies = async (url) => {
  const res = await fetch(url);
  const data = await res.json();
  showMovies(data.results);
};

getMovies(API_URL);

form.addEventListener("submit", (e) => {
  e.preventDefault();
  const searchTerm = search.value;
  if (searchTerm && searchTerm !== "") {
    getMovies(SEARCH_API + searchTerm);
    search.value = "";
  } else {
    history.go(0);
  }
});