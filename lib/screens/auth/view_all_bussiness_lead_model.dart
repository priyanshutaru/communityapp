class view_bussiness_lead_model {
  int? statusCode;
  int? totalLeads;
  List<Bussiness_Lead>? state;

  view_bussiness_lead_model({this.statusCode, this.totalLeads, this.state});

  view_bussiness_lead_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    totalLeads = json['total_leads'];
    if (json['state'] != null) {
      state = <Bussiness_Lead>[];
      json['state'].forEach((v) {
        state!.add(new Bussiness_Lead.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['total_leads'] = this.totalLeads;
    if (this.state != null) {
      data['state'] = this.state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bussiness_Lead {
  int? id;
  String? userId;
  String? mobile;
  String? leadId;
  String? catId;
  String? subCatId;
  String? location;
  Null? fullAddress;
  String? description;
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
  String? loginStatus;
  String? trashUser;
  String? categoryName;
  String? subCategoryName;

  Bussiness_Lead(
      {this.id,
        this.userId,
        this.mobile,
        this.leadId,
        this.catId,
        this.subCatId,
        this.location,
        this.fullAddress,
        this.description,
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
        this.loginStatus,
        this.trashUser,
        this.categoryName,
        this.subCategoryName});

  Bussiness_Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mobile = json['mobile'];
    leadId = json['lead_id'];
    catId = json['cat_id'];
    subCatId = json['sub_cat_id'];
    location = json['location'];
    fullAddress = json['full_address'];
    description = json['description'];
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
    loginStatus = json['login_status'];
    trashUser = json['trash_user'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['mobile'] = this.mobile;
    data['lead_id'] = this.leadId;
    data['cat_id'] = this.catId;
    data['sub_cat_id'] = this.subCatId;
    data['location'] = this.location;
    data['full_address'] = this.fullAddress;
    data['description'] = this.description;
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
    data['login_status'] = this.loginStatus;
    data['trash_user'] = this.trashUser;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    return data;
  }
}
