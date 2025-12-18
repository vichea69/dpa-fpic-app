class Document {
  final int id;
  final String name;
  final String url;

  Document(this.id, this.name, this.url);

  Document.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        url = json['url'];
}
