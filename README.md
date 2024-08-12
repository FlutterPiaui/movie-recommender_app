# CineMatch

Get personalized movie and TV show recommendations with the help of Google Gemini. This project was developed as part of the [Gemini API Developer Competition](https://ai.google.dev/competition).
## How is Gemini used in this project?
Our application uses the Gemini API to recommend movies based on an initial prompt provided by the user. This prompt can be of any type, including movie categories, actor names, awards, or any other parameter the user wishes. The Gemini API processes the prompt and curates a list of movies that best align with the given criteria.

We leverage Google Cloud Functions to handle the submission of the search prompt. Once the prompt is received, the Gemini API processes it and selects a list of movies that best align with the provided criteria.
## Other integrations
- The Movie Database (TMDB) API: Used to display movies and TVshows data.
- Our own backend is built on Node.js with TypeScript, ensuring robust and scalable performance. [Backend repo code](https://github.com/FlutterPiaui/cloud_funtions).


Link APK 🔗 - https://l1nk.dev/FroCd