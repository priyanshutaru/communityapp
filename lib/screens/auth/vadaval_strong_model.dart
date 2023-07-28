class vadava_strong_modal {
  List<Strong>? data;

  vadava_strong_modal({this.data});

  vadava_strong_modal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Strong>[];
      json['data'].forEach((v) {
        data!.add(new Strong.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Strong {
  String? name;
  String? img;
  int? count;

  Strong({this.name, this.img, this.count});

  Strong.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    data['count'] = this.count;
    return data;
  }
}
