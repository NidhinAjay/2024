import 'dart:convert';

MusicDataResponse musicDataResponseFromJson(String str) => MusicDataResponse.fromJson(json.decode(str));

String musicDataResponseToJson(MusicDataResponse data) => json.encode(data.toJson());

class MusicDataResponse {
    MusicDataResponse({
        required this.totalTrackCount,
        required this.duration,
        required this.image,
        required this.site,
        required this.trackNumber,
        required this.artist,
        required this.album,
        required this.genre,
        required this.id,
        required this.source,
        required this.title,
    });

    int totalTrackCount;
    int duration;
    String image;
    String site;
    int trackNumber;
    String artist;
    String album;
    String genre;
    String id;
    String source;
    String title;

    factory MusicDataResponse.fromJson(Map<dynamic, dynamic> json) => MusicDataResponse(
        totalTrackCount: json["totalTrackCount"],
        duration: json["duration"],
        image: json["image"],
        site: json["site"],
        trackNumber: json["trackNumber"],
        artist: json["artist"],
        album: json["album"],
        genre: json["genre"],
        id: json["id"],
        source: json["source"],
        title: json["title"],
    );

    Map<dynamic, dynamic> toJson() => {
        "totalTrackCount": totalTrackCount,
        "duration": duration,
        "image": image,
        "site": site,
        "trackNumber": trackNumber,
        "artist": artist,
        "album": album,
        "genre": genre,
        "id": id,
        "source": source,
        "title": title,
    };
}
