class MovieDetails {
  final bool adult;
  final String backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<String> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime? releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String posterUrl;
  final String trailerUrl;
  final List<Providers> providersList;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.posterUrl,
    required this.trailerUrl,
    required this.providersList,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<String>.from(json["genres"].map((x) => x['name'])),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
          json["production_companies"].map(
            (x) => ProductionCompany.fromJson(x),
          ),
        ),
        productionCountries: List<ProductionCountry>.from(
          json["production_countries"].map(
            (x) => ProductionCountry.fromJson(x),
          ),
        ),
        releaseDate: json["release_date"].isNotEmpty
            ? DateTime.parse(json["release_date"])
            : null,
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(
          json["spoken_languages"].map(
            (x) => SpokenLanguage.fromJson(x),
          ),
        ),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        posterUrl: json["poster_url"],
        trailerUrl: json["trailerUrl"],
        providersList: List<Providers>.from(
          json["providers"].map(
            (x) => Providers.fromJson(x),
          ),
        ),
      );
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );
}

class Providers {
  final String logo;
  final String providerName;

  Providers({
    required this.logo,
    required this.providerName,
  });

  factory Providers.fromJson(Map<String, dynamic> json) => Providers(
        logo: json["logo_path"],
        providerName: json["provider_name"],
      );
}
