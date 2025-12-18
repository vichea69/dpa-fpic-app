class Photo {
  final int id;
  final String name;
  final String url;
  final String thumbnail;

  Photo(this.id, this.name, this.url, this.thumbnail);

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        thumbnail = json['thumbnail'];
}
