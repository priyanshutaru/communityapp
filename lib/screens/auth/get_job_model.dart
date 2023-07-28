class latest_job_model {
  String? statusMessage;
  List<Details>? details;

  latest_job_model({this.statusMessage, this.details});

  latest_job_model.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
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

class Details {
  int? id;
  String? jobId;
  String? categoryId;
  String? subCategoryId;
  Null? jobType;
  String? userId;
  String? img;
  String? companyName;
  String? comapnyEmail;
  String? jobLocation;
  String? hrMobile;
  Null? jobPosition;
  String? noOfVacancy;
  String? requiredExp;
  String? qualification;
  String? verify;
  String? userStatus;
  String? status;
  String? trashJob;
  String? createdAt;
  String? updatedAt;
  int? districtid;
  String? districtTitle;
  int? stateId;
  String? districtDescription;
  String? districtStatus;
  String? subcategoryId;
  String? subcategoryName;
  String? trashCategory;
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
  String? loginStatus;
  String? trashUser;
  String? qualificationName;

  Details(
      {this.id,
        this.jobId,
        this.categoryId,
        this.subCategoryId,
        this.jobType,
        this.userId,
        this.img,
        this.companyName,
        this.comapnyEmail,
        this.jobLocation,
        this.hrMobile,
        this.jobPosition,
        this.noOfVacancy,
        this.requiredExp,
        this.qualification,
        this.verify,
        this.userStatus,
        this.status,
        this.trashJob,
        this.createdAt,
        this.updatedAt,
        this.districtid,
        this.districtTitle,
        this.stateId,
        this.districtDescription,
        this.districtStatus,
        this.subcategoryId,
        this.subcategoryName,
        this.trashCategory,
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
        this.loginStatus,
        this.trashUser,
        this.qualificationName});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    jobType = json['job_type'];
    userId = json['user_id'];
    img = json['img'];
    companyName = json['company_name'];
    comapnyEmail = json['comapny_email'];
    jobLocation = json['job_location'];
    hrMobile = json['hr_mobile'];
    jobPosition = json['job_position'];
    noOfVacancy = json['no_of_vacancy'];
    requiredExp = json['required_exp'];
    qualification = json['qualification'];
    verify = json['verify'];
    userStatus = json['user_status'];
    status = json['status'];
    trashJob = json['trash_job'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    districtid = json['districtid'];
    districtTitle = json['district_title'];
    stateId = json['state_id'];
    districtDescription = json['district_description'];
    districtStatus = json['district_status'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    trashCategory = json['trash_category'];
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
    loginStatus = json['login_status'];
    trashUser = json['trash_user'];
    qualificationName = json['qualification_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['job_type'] = this.jobType;
    data['user_id'] = this.userId;
    data['img'] = this.img;
    data['company_name'] = this.companyName;
    data['comapny_email'] = this.comapnyEmail;
    data['job_location'] = this.jobLocation;
    data['hr_mobile'] = this.hrMobile;
    data['job_position'] = this.jobPosition;
    data['no_of_vacancy'] = this.noOfVacancy;
    data['required_exp'] = this.requiredExp;
    data['qualification'] = this.qualification;
    data['verify'] = this.verify;
    data['user_status'] = this.userStatus;
    data['status'] = this.status;
    data['trash_job'] = this.trashJob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['districtid'] = this.districtid;
    data['district_title'] = this.districtTitle;
    data['state_id'] = this.stateId;
    data['district_description'] = this.districtDescription;
    data['district_status'] = this.districtStatus;
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['trash_category'] = this.trashCategory;
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
    data['login_status'] = this.loginStatus;
    data['trash_user'] = this.trashUser;
    data['qualification_name'] = this.qualificationName;
    return data;
  }
}
