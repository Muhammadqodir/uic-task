class Audiotrack {
  String? id;
  String? sectionNumber;
  String? title;
  String? listenUrl;
  String? language;
  String? playtime;
  Null? fileName;

  Audiotrack({
    this.id,
    this.sectionNumber,
    this.title,
    this.listenUrl,
    this.language,
    this.playtime,
    this.fileName,
  });

  Audiotrack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionNumber = json['section_number'];
    title = json['title'];
    listenUrl = json['listen_url'];
    language = json['language'];
    playtime = json['playtime'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_number'] = this.sectionNumber;
    data['title'] = this.title;
    data['listen_url'] = this.listenUrl;
    data['language'] = this.language;
    data['playtime'] = this.playtime;
    data['file_name'] = this.fileName;
    return data;
  }
}
