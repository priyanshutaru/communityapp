class search_bussiness_model {
  List<Search_Bussiness>? statusMessage;

  search_bussiness_model({this.statusMessage});

  search_bussiness_model.fromJson(Map<String, dynamic> json) {
    if (json['status_message'] != null) {
      statusMessage = <Search_Bussiness>[];
      json['status_message'].forEach((v) {
        statusMessage!.add(new Search_Bussiness.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statusMessage != null) {
      data['status_message'] =
          this.statusMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Search_Bussiness {
  int? id;
  String? businessId;
  String? userId;
  String? catId;
  Null? category;
  String? subCatId;
  Null? subCategory;
  String? businessName;
  String? whatsapp;
  String? contact;
  String? email;
  String? profileImg;
  String? gallery;
  String? website;
  Null? location;
  String? city;
  String? cityId;
  Null? fullAddress;
  String? openingDay;
  String? closingDay;
  String? openingTime;
  String? closingTime;
  String? about;
  String? verify;
  String? userStatus;
  String? adminStatus;
  String? trashBusiness;
  String? createdAt;
  String? updatedAt;
  int? districtid;
  String? districtTitle;
  int? stateId;
  String? districtDescription;
  String? districtStatus;
  String? firstName;
  String? middleName;
  String? lastName;
  String? countryId;
  String? mobile;
  String? otp;
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
  String? subcategoryName;

  Search_Bussiness(
      {this.id,
        this.businessId,
        this.userId,
        this.catId,
        this.category,
        this.subCatId,
        this.subCategory,
        this.businessName,
        this.whatsapp,
        this.contact,
        this.email,
        this.profileImg,
        this.gallery,
        this.website,
        this.location,
        this.city,
        this.cityId,
        this.fullAddress,
        this.openingDay,
        this.closingDay,
        this.openingTime,
        this.closingTime,
        this.about,
        this.verify,
        this.userStatus,
        this.adminStatus,
        this.trashBusiness,
        this.createdAt,
        this.updatedAt,
        this.districtid,
        this.districtTitle,
        this.stateId,
        this.districtDescription,
        this.districtStatus,
        this.firstName,
        this.middleName,
        this.lastName,
        this.countryId,
        this.mobile,
        this.otp,
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
        this.subcategoryName});

  Search_Bussiness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    userId = json['user_id'];
    catId = json['cat_id'];
    category = json['category'];
    subCatId = json['sub_cat_id'];
    subCategory = json['sub_category'];
    businessName = json['business_name'];
    whatsapp = json['whatsapp'];
    contact = json['contact'];
    email = json['email'];
    profileImg = json['profile_img'];
    gallery = json['gallery'];
    website = json['website'];
    location = json['location'];
    city = json['city'];
    cityId = json['city_id'];
    fullAddress = json['full_address'];
    openingDay = json['opening_day'];
    closingDay = json['closing_day'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    about = json['about'];
    verify = json['verify'];
    userStatus = json['user_status'];
    adminStatus = json['admin_status'];
    trashBusiness = json['trash_business'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    districtid = json['districtid'];
    districtTitle = json['district_title'];
    stateId = json['state_id'];
    districtDescription = json['district_description'];
    districtStatus = json['district_status'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    mobile = json['mobile'];
    otp = json['otp'];
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
    subcategoryName = json['subcategory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['user_id'] = this.userId;
    data['cat_id'] = this.catId;
    data['category'] = this.category;
    data['sub_cat_id'] = this.subCatId;
    data['sub_category'] = this.subCategory;
    data['business_name'] = this.businessName;
    data['whatsapp'] = this.whatsapp;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['profile_img'] = this.profileImg;
    data['gallery'] = this.gallery;
    data['website'] = this.website;
    data['location'] = this.location;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    data['full_address'] = this.fullAddress;
    data['opening_day'] = this.openingDay;
    data['closing_day'] = this.closingDay;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['about'] = this.about;
    data['verify'] = this.verify;
    data['user_status'] = this.userStatus;
    data['admin_status'] = this.adminStatus;
    data['trash_business'] = this.trashBusiness;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['districtid'] = this.districtid;
    data['district_title'] = this.districtTitle;
    data['state_id'] = this.stateId;
    data['district_description'] = this.districtDescription;
    data['district_status'] = this.districtStatus;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['country_id'] = this.countryId;
    data['mobile'] = this.mobile;
    data['otp'] = this.otp;
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
    data['subcategory_name'] = this.subcategoryName;
    return data;
  }
}
