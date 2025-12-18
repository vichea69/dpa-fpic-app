class Video {
  final int id;
  final String url;
  final String thumbnail;

  Video(this.id, this.url, this.thumbnail);

  Video.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['youtube_link'],
        thumbnail = json['thumbnail'] ?? "";
}
