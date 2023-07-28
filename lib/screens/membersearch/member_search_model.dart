class member_search_model {
  List<Data>? data;
  int? totalResultFound;

  member_search_model({this.data, this.totalResultFound});

  member_search_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalResultFound = json['total_result_found'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_result_found'] = this.totalResultFound;
    return data;
  }
}

class Data {
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
  String? shakhaId;
  String? divisionId;
  String? shakhaName;
  Null? shakhaType;
  Null? shakhaCode;
  Null? addedBy;
  String? status;
  String? adminStatus;
  String? trashStatus;
  int? userF1Pid;
  String? userF1Ids;
  String? userF1Fname;
  String? userF1Mname;
  String? userF1Lname;
  String? userF1Dob;
  String? userF1MaritalStatus;
  String? userF1Gender;
  String? userF1BloodGroup;
  String? userF1Age;
  String? userF1AnvrsyDt;
  String? userF1RdyTDonate;
  String? userF1CAdd1;
  String? userF1CAdd2;
  String? userF1CLndmrk;
  String? userF1CCntry;
  String? userF1CState;
  String? userF1CDistrk;
  int? userF1CPin;
  String? userF1CTaluka;
  String? userF1SkhaNativShk;
  String? userF1SkhaAali;
  String? userF1SkhaCrntShka;
  String? userF1SkhaSksmbrshp;
  String? userF1SkhaPrsntPsn;
  String? userF1SkhaFrmY;
  String? userF1SkhaToY;
  String? userF1PposnPrvpsn;
  String? userF1PposnFy;
  String? userF1PopsnTy;
  String? userF1FormUploadStatus;
  String? userF1NativSakaStatus;
  String? userF1CurntSakaStatus;
  String? userF1AdminStatus;
  String? userF1KycStatus;
  String? userF1TrashStatus;
  String? sakhaId;
  String? aaliId;
  String? aaliName;
  String? districtName;
  int? likeStatus;

  Data(
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
        this.shakhaId,
        this.divisionId,
        this.shakhaName,
        this.shakhaType,
        this.shakhaCode,
        this.addedBy,
        this.status,
        this.adminStatus,
        this.trashStatus,
        this.userF1Pid,
        this.userF1Ids,
        this.userF1Fname,
        this.userF1Mname,
        this.userF1Lname,
        this.userF1Dob,
        this.userF1MaritalStatus,
        this.userF1Gender,
        this.userF1BloodGroup,
        this.userF1Age,
        this.userF1AnvrsyDt,
        this.userF1RdyTDonate,
        this.userF1CAdd1,
        this.userF1CAdd2,
        this.userF1CLndmrk,
        this.userF1CCntry,
        this.userF1CState,
        this.userF1CDistrk,
        this.userF1CPin,
        this.userF1CTaluka,
        this.userF1SkhaNativShk,
        this.userF1SkhaAali,
        this.userF1SkhaCrntShka,
        this.userF1SkhaSksmbrshp,
        this.userF1SkhaPrsntPsn,
        this.userF1SkhaFrmY,
        this.userF1SkhaToY,
        this.userF1PposnPrvpsn,
        this.userF1PposnFy,
        this.userF1PopsnTy,
        this.userF1FormUploadStatus,
        this.userF1NativSakaStatus,
        this.userF1CurntSakaStatus,
        this.userF1AdminStatus,
        this.userF1KycStatus,
        this.userF1TrashStatus,
        this.sakhaId,
        this.aaliId,
        this.aaliName,
        this.districtName,
        this.likeStatus});

  Data.fromJson(Map<String, dynamic> json) {
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
    shakhaId = json['shakha_id'];
    divisionId = json['division_id'];
    shakhaName = json['shakha_name'];
    shakhaType = json['shakha_type'];
    shakhaCode = json['shakha_code'];
    addedBy = json['added_by'];
    status = json['status'];
    adminStatus = json['admin_status'];
    trashStatus = json['trash_status'];
    userF1Pid = json['user_f1_pid'];
    userF1Ids = json['user_f1_ids'];
    userF1Fname = json['user_f1_fname'];
    userF1Mname = json['user_f1_mname'];
    userF1Lname = json['user_f1_lname'];
    userF1Dob = json['user_f1_dob'];
    userF1MaritalStatus = json['user_f1_marital_status'];
    userF1Gender = json['user_f1_gender'];
    userF1BloodGroup = json['user_f1_blood_group'];
    userF1Age = json['user_f1_age'];
    userF1AnvrsyDt = json['user_f1_anvrsy_dt'];
    userF1RdyTDonate = json['user_f1_rdy_t_donate'];
    userF1CAdd1 = json['user_f1_c_add1'];
    userF1CAdd2 = json['user_f1_c_add2'];
    userF1CLndmrk = json['user_f1_c_lndmrk'];
    userF1CCntry = json['user_f1_c_cntry'];
    userF1CState = json['user_f1_c_state'];
    userF1CDistrk = json['user_f1_c_distrk'];
    userF1CPin = json['user_f1_c_pin'];
    userF1CTaluka = json['user_f1_c_taluka'];
    userF1SkhaNativShk = json['user_f1_skha_nativ_shk'];
    userF1SkhaAali = json['user_f1_skha_aali'];
    userF1SkhaCrntShka = json['user_f1_skha_crnt_shka'];
    userF1SkhaSksmbrshp = json['user_f1_skha_sksmbrshp'];
    userF1SkhaPrsntPsn = json['user_f1_skha_prsnt_psn'];
    userF1SkhaFrmY = json['user_f1_skha_frm_y'];
    userF1SkhaToY = json['user_f1_skha_to_y'];
    userF1PposnPrvpsn = json['user_f1_pposn_prvpsn'];
    userF1PposnFy = json['user_f1_pposn_fy'];
    userF1PopsnTy = json['user_f1_popsn_ty'];
    userF1FormUploadStatus = json['user_f1_form_upload_status'];
    userF1NativSakaStatus = json['user_f1_nativ_saka_status'];
    userF1CurntSakaStatus = json['user_f1_curnt_saka_status'];
    userF1AdminStatus = json['user_f1_admin_status'];
    userF1KycStatus = json['user_f1_kyc_status'];
    userF1TrashStatus = json['user_f1_trash_status'];
    sakhaId = json['sakha_id'];
    aaliId = json['aali_id'];
    aaliName = json['aali_name'];
    districtName = json['district_name'];
    likeStatus = json['like_status'];
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
    data['shakha_id'] = this.shakhaId;
    data['division_id'] = this.divisionId;
    data['shakha_name'] = this.shakhaName;
    data['shakha_type'] = this.shakhaType;
    data['shakha_code'] = this.shakhaCode;
    data['added_by'] = this.addedBy;
    data['status'] = this.status;
    data['admin_status'] = this.adminStatus;
    data['trash_status'] = this.trashStatus;
    data['user_f1_pid'] = this.userF1Pid;
    data['user_f1_ids'] = this.userF1Ids;
    data['user_f1_fname'] = this.userF1Fname;
    data['user_f1_mname'] = this.userF1Mname;
    data['user_f1_lname'] = this.userF1Lname;
    data['user_f1_dob'] = this.userF1Dob;
    data['user_f1_marital_status'] = this.userF1MaritalStatus;
    data['user_f1_gender'] = this.userF1Gender;
    data['user_f1_blood_group'] = this.userF1BloodGroup;
    data['user_f1_age'] = this.userF1Age;
    data['user_f1_anvrsy_dt'] = this.userF1AnvrsyDt;
    data['user_f1_rdy_t_donate'] = this.userF1RdyTDonate;
    data['user_f1_c_add1'] = this.userF1CAdd1;
    data['user_f1_c_add2'] = this.userF1CAdd2;
    data['user_f1_c_lndmrk'] = this.userF1CLndmrk;
    data['user_f1_c_cntry'] = this.userF1CCntry;
    data['user_f1_c_state'] = this.userF1CState;
    data['user_f1_c_distrk'] = this.userF1CDistrk;
    data['user_f1_c_pin'] = this.userF1CPin;
    data['user_f1_c_taluka'] = this.userF1CTaluka;
    data['user_f1_skha_nativ_shk'] = this.userF1SkhaNativShk;
    data['user_f1_skha_aali'] = this.userF1SkhaAali;
    data['user_f1_skha_crnt_shka'] = this.userF1SkhaCrntShka;
    data['user_f1_skha_sksmbrshp'] = this.userF1SkhaSksmbrshp;
    data['user_f1_skha_prsnt_psn'] = this.userF1SkhaPrsntPsn;
    data['user_f1_skha_frm_y'] = this.userF1SkhaFrmY;
    data['user_f1_skha_to_y'] = this.userF1SkhaToY;
    data['user_f1_pposn_prvpsn'] = this.userF1PposnPrvpsn;
    data['user_f1_pposn_fy'] = this.userF1PposnFy;
    data['user_f1_popsn_ty'] = this.userF1PopsnTy;
    data['user_f1_form_upload_status'] = this.userF1FormUploadStatus;
    data['user_f1_nativ_saka_status'] = this.userF1NativSakaStatus;
    data['user_f1_curnt_saka_status'] = this.userF1CurntSakaStatus;
    data['user_f1_admin_status'] = this.userF1AdminStatus;
    data['user_f1_kyc_status'] = this.userF1KycStatus;
    data['user_f1_trash_status'] = this.userF1TrashStatus;
    data['sakha_id'] = this.sakhaId;
    data['aali_id'] = this.aaliId;
    data['aali_name'] = this.aaliName;
    data['district_name'] = this.districtName;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
