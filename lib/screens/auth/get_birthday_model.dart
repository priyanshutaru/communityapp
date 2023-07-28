class get_birthday_model {
  String? statusMessage;
  List<Birthday>? details;

  get_birthday_model({this.statusMessage, this.details});

  get_birthday_model.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    if (json['details'] != null) {
      details = <Birthday>[];
      json['details'].forEach((v) {
        details!.add(new Birthday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_message'] = this.statusMessage;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Birthday {
  int? id;
  String? userId;
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
  String? canCall;
  String? canWhats;
  String? verificationStatus;
  String? userStatus;
  String? loginStatus;
  String? createdAt;
  String? updatedAt;
  String? trashUser;
  String? userF1CDistrk;
  String? userF1CState;
  String? districtName;
  int? turning;

  Birthday(
      {this.id,
        this.userId,
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
        this.canCall,
        this.canWhats,
        this.verificationStatus,
        this.userStatus,
        this.loginStatus,
        this.createdAt,
        this.updatedAt,
        this.trashUser,
        this.userF1CDistrk,
        this.userF1CState,
        this.districtName,
        this.turning});

  Birthday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
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
    canCall = json['can_call'];
    canWhats = json['can_whats'];
    verificationStatus = json['verification_status'];
    userStatus = json['user_status'];
    loginStatus = json['login_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trashUser = json['trash_user'];
    userF1CDistrk = json['user_f1_c_distrk'];
    userF1CState = json['user_f1_c_state'];
    districtName = json['district_name'];
    turning = json['turning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
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
    data['can_call'] = this.canCall;
    data['can_whats'] = this.canWhats;
    data['verification_status'] = this.verificationStatus;
    data['user_status'] = this.userStatus;
    data['login_status'] = this.loginStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['trash_user'] = this.trashUser;
    data['user_f1_c_distrk'] = this.userF1CDistrk;
    data['user_f1_c_state'] = this.userF1CState;
    data['district_name'] = this.districtName;
    data['turning'] = this.turning;
    return data;
  }
}
