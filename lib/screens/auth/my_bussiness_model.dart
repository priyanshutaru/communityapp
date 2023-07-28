class my_bussiness_model {
  List<Data>? data;

  my_bussiness_model({this.data});

  my_bussiness_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? businessId;
  String? userId;
  String? catId;
  String? category;
  String? subCatId;
  String? subCategory;
  String? businessName;
  String? whatsapp;
  String? contact;
  String? email;
  String? profileImg;
  Gallery? gallery;
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
  String? userStatus;

  Data(
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
        this.userStatus});

  Data.fromJson(Map<String, dynamic> json) {
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
    gallery =
    json['gallery'] != null ? new Gallery.fromJson(json['gallery']) : null;
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
    userStatus = json['user_status'];
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
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.toJson();
    }
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
    data['user_status'] = this.userStatus;
    return data;
  }
}

class Gallery {
  List<String>? img;

  Gallery({this.img});

  Gallery.fromJson(Map<String, dynamic> json) {
    img = json['img'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    return data;
  }
}
