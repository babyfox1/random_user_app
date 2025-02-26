class UsersParamsModel {
  int? results;
  String? gender;

  UsersParamsModel({this.results, this.gender});

  UsersParamsModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    data['gender'] = gender;
    return data;
  }
}
