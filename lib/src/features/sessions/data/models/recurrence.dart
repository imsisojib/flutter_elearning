class Recurrence {
  String? slug;
  String? en;
  String? ar;
  int? value;

  Recurrence({this.slug, this.en, this.ar, this.value});

  Recurrence.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    en = json['en'];
    ar = json['ar'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['en'] = this.en;
    data['ar'] = this.ar;
    data['value'] = this.value;
    return data;
  }
}