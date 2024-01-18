class Student {
  String? name;
  String? country;
  String? alphaTwoCode;
  List<String>? domains;
  List<String>? webPages;
  String? stateProvince;

  Student(
      {this.name,
        this.country,
        this.alphaTwoCode,
        this.domains,
        this.webPages,
        this.stateProvince});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    alphaTwoCode = json['alpha_two_code'];
    domains = json['domains'].cast<String>();
    webPages = json['web_pages'].cast<String>();
    stateProvince = json['state-province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['domains'] = this.domains;
    data['web_pages'] = this.webPages;
    data['state-province'] = this.stateProvince;
    return data;
  }
}
