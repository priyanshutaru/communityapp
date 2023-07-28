class get_news_comment_model {
  List<NewsComment>? data;

  get_news_comment_model({this.data});

  get_news_comment_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NewsComment>[];
      json['data'].forEach((v) {
        data!.add(new NewsComment.fromJson(v));
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

class NewsComment {
  String? id;
  String? newsId;
  String? commentId;
  String? userId;
  String? comment;
  String? date;
  String? time;
  String? userStatus;
  String? adminStatus;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImg;
  String? countryId;
  String? mobile;
  String? otp;
  String? email;
  String? gender;
  String? dob;
  String? nativShakha;
  String? aali;
  String? curntShakha;
  Null? country;
  String? bio;
  String? sksMembership;
  String? sPostPer;
  String? kycStatus;
  String? verificationStatus;
  String? loginStatus;
  String? trashUser;

  NewsComment(
      {this.id,
        this.newsId,
        this.commentId,
        this.userId,
        this.comment,
        this.date,
        this.time,
        this.userStatus,
        this.adminStatus,
        this.trashStatus,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.middleName,
        this.lastName,
        this.profileImg,
        this.countryId,
        this.mobile,
        this.otp,
        this.email,
        this.gender,
        this.dob,
        this.nativShakha,
        this.aali,
        this.curntShakha,
        this.country,
        this.bio,
        this.sksMembership,
        this.sPostPer,
        this.kycStatus,
        this.verificationStatus,
        this.loginStatus,
        this.trashUser});

  NewsComment.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    newsId = json['news_id'];
    commentId = json['comment_id'];
    userId = json['user_id'];
    comment = json['comment'];
    date = json['date'];
    time = json['time'];
    userStatus = json['user_status'];
    adminStatus = json['admin_status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    countryId = json['country_id'];
    mobile = json['mobile'];
    otp = json['otp'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    nativShakha = json['nativ_shakha'];
    aali = json['aali'];
    curntShakha = json['curnt_shakha'];
    country = json['country'];
    bio = json['bio'];
    sksMembership = json['sks_membership'];
    sPostPer = json['s_post_per'];
    kycStatus = json['kyc_status'];
    verificationStatus = json['verification_status'];
    loginStatus = json['login_status'];
    trashUser = json['trash_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_id'] = this.newsId;
    data['comment_id'] = this.commentId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['time'] = this.time;
    data['user_status'] = this.userStatus;
    data['admin_status'] = this.adminStatus;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['profile_img'] = this.profileImg;
    data['country_id'] = this.countryId;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['nativ_shakha'] = this.nativShakha;
    data['aali'] = this.aali;
    data['curnt_shakha'] = this.curntShakha;
    data['country'] = this.country;
    data['bio'] = this.bio;
    data['sks_membership'] = this.sksMembership;
    data['s_post_per'] = this.sPostPer;
    data['kyc_status'] = this.kycStatus;
    data['verification_status'] = this.verificationStatus;
    data['login_status'] = this.loginStatus;
    data['trash_user'] = this.trashUser;
    return data;
  }
}
