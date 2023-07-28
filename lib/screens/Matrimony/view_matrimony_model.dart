class ViewMatrimony {
  int? statusCode;
  List<Response>? response;

  ViewMatrimony({this.statusCode, this.response});

  ViewMatrimony.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  int? id;
  String? matId;
  String? userId;
  String? lookingFor;
  String? name;
  String? profession;
  String? gender;
  Null? email;
  String? mobile;
  String? profile;
  String? education;
  String? dob;
  String? birthTime;
  String? sunSign;
  String? moonSign;
  String? height;
  String? skinTone;
  String? about;
  String? gallery;
  String? address;
  String? subsId;
  String? subscribeStatus;
  String? verify;
  String? userStatus;
  String? status;
  String? trashData;
  String? createdAt;
  String? updatedAt;

  Response(
      {this.id,
      this.matId,
      this.userId,
      this.lookingFor,
      this.name,
      this.profession,
      this.gender,
      this.email,
      this.mobile,
      this.profile,
      this.education,
      this.dob,
      this.birthTime,
      this.sunSign,
      this.moonSign,
      this.height,
      this.skinTone,
      this.about,
      this.gallery,
      this.address,
      this.subsId,
      this.subscribeStatus,
      this.verify,
      this.userStatus,
      this.status,
      this.trashData,
      this.createdAt,
      this.updatedAt});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matId = json['mat_id'];
    userId = json['user_id'];
    lookingFor = json['looking_for'];
    name = json['name'];
    profession = json['profession'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    profile = json['profile'];
    education = json['education'];
    dob = json['dob'];
    birthTime = json['birth_time'];
    sunSign = json['sun_sign'];
    moonSign = json['moon_sign'];
    height = json['height'];
    skinTone = json['skin_tone'];
    about = json['about'];
    gallery = json['gallery'];
    address = json['address'];
    subsId = json['subs_id'];
    subscribeStatus = json['subscribe_status'];
    verify = json['verify'];
    userStatus = json['user_status'];
    status = json['status'];
    trashData = json['trash_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mat_id'] = this.matId;
    data['user_id'] = this.userId;
    data['looking_for'] = this.lookingFor;
    data['name'] = this.name;
    data['profession'] = this.profession;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile'] = this.profile;
    data['education'] = this.education;
    data['dob'] = this.dob;
    data['birth_time'] = this.birthTime;
    data['sun_sign'] = this.sunSign;
    data['moon_sign'] = this.moonSign;
    data['height'] = this.height;
    data['skin_tone'] = this.skinTone;
    data['about'] = this.about;
    data['gallery'] = this.gallery;
    data['address'] = this.address;
    data['subs_id'] = this.subsId;
    data['subscribe_status'] = this.subscribeStatus;
    data['verify'] = this.verify;
    data['user_status'] = this.userStatus;
    data['status'] = this.status;
    data['trash_data'] = this.trashData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
