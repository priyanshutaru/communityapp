class open_blood_donation_request_model {
  int? status;
  List<Status>? statusMessage;

  open_blood_donation_request_model({this.status, this.statusMessage});

  open_blood_donation_request_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['status_message'] != null) {
      statusMessage = <Status>[];
      json['status_message'].forEach((v) {
        statusMessage!.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.statusMessage != null) {
      data['status_message'] =
          this.statusMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? id;
  String? reqId;
  String? userId;
  String? bloodType;
  String? unit;
  String? city;
  String? completeStatus;
  String? status;
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
  String? canCall;
  String? canWhats;
  String? verificationStatus;
  String? userStatus;
  String? loginStatus;
  String? trashUser;

  Status(
      {this.id,
        this.reqId,
        this.userId,
        this.bloodType,
        this.unit,
        this.city,
        this.completeStatus,
        this.status,
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
        this.canCall,
        this.canWhats,
        this.verificationStatus,
        this.userStatus,
        this.loginStatus,
        this.trashUser});

  Status.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    reqId = json['req_id'];
    userId = json['user_id'];
    bloodType = json['blood_type'];
    unit = json['unit'];
    city = json['city'];
    completeStatus = json['complete_status'];
    status = json['status'];
    //adminStatus = json['admin_status'];
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
    canCall = json['can_call'];
    canWhats = json['can_whats'];
    verificationStatus = json['verification_status'];
    userStatus = json['user_status'];
    loginStatus = json['login_status'];
    trashUser = json['trash_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['req_id'] = this.reqId;
    data['user_id'] = this.userId;
    data['blood_type'] = this.bloodType;
    data['unit'] = this.unit;
    data['city'] = this.city;
    data['complete_status'] = this.completeStatus;
    data['status'] = this.status;
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
    data['can_call'] = this.canCall;
    data['can_whats'] = this.canWhats;
    data['verification_status'] = this.verificationStatus;
    data['user_status'] = this.userStatus;
    data['login_status'] = this.loginStatus;
    data['trash_user'] = this.trashUser;
    return data;
  }
}
