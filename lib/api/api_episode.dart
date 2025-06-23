class EpisodeResponse {
  EpisodeResponse({required this.info, required this.results});

  final Info? info;
  final List<Result> results;

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeResponse(
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }
}

class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  final int? count;
  final int? pages;
  final String? next;
  final dynamic prev;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json["count"],
      pages: json["pages"],
      next: json["next"],
      prev: json["prev"],
    );
  }
}

class Result {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime? created;

  Result({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json["id"],
      name: json["name"],
      airDate: json["air_date"],
      episode: json["episode"],
      characters: json["characters"] == null
          ? []
          : List<String>.from(json["characters"]!.map((x) => x)),
      url: json["url"],
      created: DateTime.tryParse(json["created"] ?? ""),
    );
  }
}
