class CatFact {
  String? fact;
  int? length;

  CatFact({this.fact, this.length});

  CatFact.fromjson(Map<String, dynamic> json) {
    fact = json['fact'] ?? "";
    length = json['length'] ?? 0;
  }


}
