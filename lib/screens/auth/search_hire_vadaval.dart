class search_hire_a_vadval_model {
  String? statusMessage;
  List<SearchList>? list;

  search_hire_a_vadval_model({this.statusMessage, this.list});

  search_hire_a_vadval_model.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    if (json['list'] != null) {
      list = <SearchList>[];
      json['list'].forEach((v) {
        list!.add(SearchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_message'] = this.statusMessage;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class Search_Vadaval {
//   String? id;
//   String? profileId;
//   String? userId;
//   String? name;
//   String? qualification;
//   String? profession;
//   String? location;
//   String? category;
//   String? subCategory;
//   String? bio;
//   String? status;
//   String? adminStatus;
//   String? trashStatus;
//   String? createdAt;
//   String? updatedAt;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? profileImg;
//   String? countryId;
//   String? mobile;
//   String? otp;
//   String? email;
//   String? gender;
//   String? dob;
//   String? nativShakha;
//   Null? aali;
//   String? curntShakha;
//   Null? country;
//   Null? sksMembership;
//   String? sPostPer;
//   String? kycStatus;
//   String? verificationStatus;
//   String? userStatus;
//   String? loginStatus;
//   String? trashUser;
//   String? categoryId;
//   String? subcategoryId;
//   String? subcategoryName;
//   String? trashCategory;
//   String? categoryName;
//   String? trashCat;
//   String? qId;
//   String? districtid;
//   String? districtTitle;
//   String? stateId;
//   String? districtDescription;
//   String? districtStatus;
//
//   Search_Vadaval(
//       {this.id,
//         this.profileId,
//         this.userId,
//         this.name,
//         this.qualification,
//         this.profession,
//         this.location,
//         this.category,
//         this.subCategory,
//         this.bio,
//         this.status,
//         this.adminStatus,
//         this.trashStatus,
//         this.createdAt,
//         this.updatedAt,
//         this.firstName,
//         this.middleName,
//         this.lastName,
//         this.profileImg,
//         this.countryId,
//         this.mobile,
//         this.otp,
//         this.email,
//         this.gender,
//         this.dob,
//         this.nativShakha,
//         this.aali,
//         this.curntShakha,
//         this.country,
//         this.sksMembership,
//         this.sPostPer,
//         this.kycStatus,
//         this.verificationStatus,
//         this.userStatus,
//         this.loginStatus,
//         this.trashUser,
//         this.categoryId,
//         this.subcategoryId,
//         this.subcategoryName,
//         this.trashCategory,
//         this.categoryName,
//         this.trashCat,
//         this.qId,
//         this.districtid,
//         this.districtTitle,
//         this.stateId,
//         this.districtDescription,
//         this.districtStatus});
//
//   Search_Vadaval.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     profileId = json['profile_id'];
//     userId = json['user_id'];
//     name = json['name'];
//     qualification = json['qualification'];
//     profession = json['profession'];
//     location = json['location'];
//     category = json['category'];
//     subCategory = json['sub_category'];
//     bio = json['bio'];
//     status = json['status'];
//     adminStatus = json['admin_status'];
//     trashStatus = json['trash_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     firstName = json['first_name'];
//     middleName = json['middle_name'];
//     lastName = json['last_name'];
//     profileImg = json['profile_img'];
//     countryId = json['country_id'];
//     mobile = json['mobile'];
//     otp = json['otp'];
//     email = json['email'];
//     gender = json['gender'];
//     dob = json['dob'];
//     nativShakha = json['nativ_shakha'];
//     aali = json['aali'];
//     curntShakha = json['curnt_shakha'];
//     country = json['country'];
//     sksMembership = json['sks_membership'];
//     sPostPer = json['s_post_per'];
//     kycStatus = json['kyc_status'];
//     verificationStatus = json['verification_status'];
//     userStatus = json['user_status'];
//     loginStatus = json['login_status'];
//     trashUser = json['trash_user'];
//     categoryId = json['category_id'];
//     subcategoryId = json['subcategory_id'];
//     subcategoryName = json['subcategory_name'];
//     trashCategory = json['trash_category'];
//     categoryName = json['category_name'];
//     trashCat = json['trash_cat'];
//     qId = json['q_id'];
//     districtid = json['districtid'];
//     districtTitle = json['district_title'];
//     stateId = json['state_id'];
//     districtDescription = json['district_description'];
//     districtStatus = json['district_status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['profile_id'] = this.profileId;
//     data['user_id'] = this.userId;
//     data['name'] = this.name;
//     data['qualification'] = this.qualification;
//     data['profession'] = this.profession;
//     data['location'] = this.location;
//     data['category'] = this.category;
//     data['sub_category'] = this.subCategory;
//     data['bio'] = this.bio;
//     data['status'] = this.status;
//     data['admin_status'] = this.adminStatus;
//     data['trash_status'] = this.trashStatus;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['first_name'] = this.firstName;
//     data['middle_name'] = this.middleName;
//     data['last_name'] = this.lastName;
//     data['profile_img'] = this.profileImg;
//     data['country_id'] = this.countryId;
//     data['mobile'] = this.mobile;
//     data['otp'] = this.otp;
//     data['email'] = this.email;
//     data['gender'] = this.gender;
//     data['dob'] = this.dob;
//     data['nativ_shakha'] = this.nativShakha;
//     data['aali'] = this.aali;
//     data['curnt_shakha'] = this.curntShakha;
//     data['country'] = this.country;
//     data['sks_membership'] = this.sksMembership;
//     data['s_post_per'] = this.sPostPer;
//     data['kyc_status'] = this.kycStatus;
//     data['verification_status'] = this.verificationStatus;
//     data['user_status'] = this.userStatus;
//     data['login_status'] = this.loginStatus;
//     data['trash_user'] = this.trashUser;
//     data['category_id'] = this.categoryId;
//     data['subcategory_id'] = this.subcategoryId;
//     data['subcategory_name'] = this.subcategoryName;
//     data['trash_category'] = this.trashCategory;
//     data['category_name'] = this.categoryName;
//     data['trash_cat'] = this.trashCat;
//     data['q_id'] = this.qId;
//     data['districtid'] = this.districtid;
//     data['district_title'] = this.districtTitle;
//     data['state_id'] = this.stateId;
//     data['district_description'] = this.districtDescription;
//     data['district_status'] = this.districtStatus;
//     return data;
//   }
// }




class SearchList {
  int? id;
  String? profileId;
  String? userId;
  String? name;
  String? qualification;
  String? profession;
  String? location;
  String? category;
  String? subCategory;
  String? bio;
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
  String? sksMembership;
  String? sPostPer;
  String? kycStatus;
  String? canCall;
  String? canWhats;
  String? eventPer;
  String? newsPer;
  String? sanskritiPer;
  String? verificationStatus;
  String? userStatus;
  String? loginStatus;
  String? trashUser;
  String? categoryId;
  String? subcategoryId;
  String? subcategoryName;
  String? trashCategory;
  String? qId;
  int? districtid;
  String? districtTitle;
  int? stateId;
  String? districtDescription;
  String? districtStatus;
  String? img;
  String? categoryName;
  String? trashCat;
  int? jpID;

  SearchList(
      {this.id,
        this.profileId,
        this.userId,
        this.name,
        this.qualification,
        this.profession,
        this.location,
        this.category,
        this.subCategory,
        this.bio,
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
        this.sksMembership,
        this.sPostPer,
        this.kycStatus,
        this.canCall,
        this.canWhats,
        this.eventPer,
        this.newsPer,
        this.sanskritiPer,
        this.verificationStatus,
        this.userStatus,
        this.loginStatus,
        this.trashUser,
        this.categoryId,
        this.subcategoryId,
        this.subcategoryName,
        this.trashCategory,
        this.qId,
        this.districtid,
        this.districtTitle,
        this.stateId,
        this.districtDescription,
        this.districtStatus,
        this.img,
        this.categoryName,
        this.trashCat,
        this.jpID});

  SearchList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    userId = json['user_id'];
    name = json['name'];
    qualification = json['qualification'];
    profession = json['profession'];
    location = json['location'];
    category = json['category'];
    subCategory = json['sub_category'];
    bio = json['bio'];
    status = json['status'];
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
    sksMembership = json['sks_membership'];
    sPostPer = json['s_post_per'];
    kycStatus = json['kyc_status'];
    canCall = json['can_call'];
    canWhats = json['can_whats'];
    eventPer = json['event_per'];
    newsPer = json['news_per'];
    sanskritiPer = json['sanskriti_per'];
    verificationStatus = json['verification_status'];
    userStatus = json['user_status'];
    loginStatus = json['login_status'];
    trashUser = json['trash_user'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    trashCategory = json['trash_category'];
    qId = json['q_id'];
    districtid = json['districtid'];
    districtTitle = json['district_title'];
    stateId = json['state_id'];
    districtDescription = json['district_description'];
    districtStatus = json['district_status'];
    img = json['img'];
    categoryName = json['category_name'];
    trashCat = json['trash_cat'];
    jpID = json['jpID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_id'] = this.profileId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['qualification'] = this.qualification;
    data['profession'] = this.profession;
    data['location'] = this.location;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['bio'] = this.bio;
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
    data['sks_membership'] = this.sksMembership;
    data['s_post_per'] = this.sPostPer;
    data['kyc_status'] = this.kycStatus;
    data['can_call'] = this.canCall;
    data['can_whats'] = this.canWhats;
    data['event_per'] = this.eventPer;
    data['news_per'] = this.newsPer;
    data['sanskriti_per'] = this.sanskritiPer;
    data['verification_status'] = this.verificationStatus;
    data['user_status'] = this.userStatus;
    data['login_status'] = this.loginStatus;
    data['trash_user'] = this.trashUser;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['trash_category'] = this.trashCategory;
    data['q_id'] = this.qId;
    data['districtid'] = this.districtid;
    data['district_title'] = this.districtTitle;
    data['state_id'] = this.stateId;
    data['district_description'] = this.districtDescription;
    data['district_status'] = this.districtStatus;
    data['img'] = this.img;
    data['category_name'] = this.categoryName;
    data['trash_cat'] = this.trashCat;
    data['jpID'] = this.jpID;
    return data;
  }
}