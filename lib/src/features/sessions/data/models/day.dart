class Day {
  String? slug;
  String? en;
  String? ar;

  Day({this.slug, this.en, this.ar});

  Day.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}