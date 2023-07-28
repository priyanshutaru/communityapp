class get_all_donor_model {
  int? status;
  int? count;
  List<StatusMessage>? statusMessage;

  get_all_donor_model({this.status, this.count, this.statusMessage});

  get_all_donor_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['status_message'] != null) {
      statusMessage = <StatusMessage>[];
      json['status_message'].forEach((v) {
        statusMessage!.add(new StatusMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    if (this.statusMessage != null) {
      data['status_message'] =
          this.statusMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusMessage {
  int? id;
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
  String? createdAt;
  String? updatedAt;
  String? userF1TrashStatus;
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
  String? trashUser;
  int? districtid;
  String? districtTitle;
  int? stateId;
  String? districtDescription;
  String? districtStatus;

  StatusMessage(
      {this.id,
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
        this.createdAt,
        this.updatedAt,
        this.userF1TrashStatus,
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
        this.trashUser,
        this.districtid,
        this.districtTitle,
        this.stateId,
        this.districtDescription,
        this.districtStatus});

  StatusMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userF1TrashStatus = json['user_f1_trash_status'];
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
    trashUser = json['trash_user'];
    districtid = json['districtid'];
    districtTitle = json['district_title'];
    stateId = json['state_id'];
    districtDescription = json['district_description'];
    districtStatus = json['district_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_f1_trash_status'] = this.userF1TrashStatus;
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
    data['trash_user'] = this.trashUser;
    data['districtid'] = this.districtid;
    data['district_title'] = this.districtTitle;
    data['state_id'] = this.stateId;
    data['district_description'] = this.districtDescription;
    data['district_status'] = this.districtStatus;
    return data;
  }
}
