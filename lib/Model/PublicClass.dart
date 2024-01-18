class Public {
  int? count;
  List<Entries>? entries;

  Public({this.count, this.entries});

  Public.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['entries'] != null) {
      entries = <Entries>[];
      json['entries'].forEach((v) {
        entries!.add(Entries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.entries != null) {
      data['entries'] = this.entries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entries {
  String? api;
  String? description;
  String? auth;
  bool? https;
  String? cors;
  String? link;
  String? category;

  Entries({
    this.api,
    this.description,
    this.auth,
    this.https,
    this.cors,
    this.link,
    this.category,
  });

  Entries.fromJson(Map<String, dynamic> json) {
    api = json['API'];
    description = json['Description'];
    auth = json['Auth'];
    https = json['HTTPS'];
    cors = json['Cors'];
    link = json['Link'];
    category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['API'] = this.api;
    data['Description'] = this.description;
    data['Auth'] = this.auth;
    data['HTTPS'] = this.https;
    data['Cors'] = this.cors;
    data['Link'] = this.link;
    data['Category'] = this.category;
    return data;
  }
}
