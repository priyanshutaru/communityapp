class get_event_model {
  String? statusMessage;
  List<Details>? details;

  get_event_model({this.statusMessage, this.details});

  get_event_model.fromJson(Map<String, dynamic> json) {
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
  String? eventId;
  Null? cityId;
  String? city;
  String? location;
  String? img;
  String? host;
  String? addedBy;
  String? addedDate;
  String? eventTime;
  String? eventDate;
  String? title;
  String? description;
  String? likes;
  String? totalComments;
  String? totalShares;
  String? status;
  String? adminStatus;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;
  String? name;
  int? districtid;
  int? stateId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImg;
  String? likeStatus;

  Details(
      {this.id,
        this.eventId,
        this.cityId,
        this.city,
        this.location,
        this.img,
        this.host,
        this.addedBy,
        this.addedDate,
        this.eventTime,
        this.eventDate,
        this.title,
        this.description,
        this.likes,
        this.totalComments,
        this.totalShares,
        this.status,
        this.adminStatus,
        this.trashStatus,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.districtid,
        this.stateId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.profileImg,
        this.likeStatus});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    cityId = json['city_id'];
    city = json['city'];
    location = json['location'];
    img = json['img'];
    host = json['host'];
    addedBy = json['added_by'];
    addedDate = json['added_date'];
    eventTime = json['event_time'];
    eventDate = json['event_date'];
    title = json['title'];
    description = json['description'];
    likes = json['likes'];
    totalComments = json['total_comments'];
    totalShares = json['total_shares'];
    status = json['status'];
    adminStatus = json['admin_status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    districtid = json['districtid'];
    stateId = json['state_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    likeStatus = json['like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_id'] = this.eventId;
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['location'] = this.location;
    data['img'] = this.img;
    data['host'] = this.host;
    data['added_by'] = this.addedBy;
    data['added_date'] = this.addedDate;
    data['event_time'] = this.eventTime;
    data['event_date'] = this.eventDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['likes'] = this.likes;
    data['total_comments'] = this.totalComments;
    data['total_shares'] = this.totalShares;
    data['status'] = this.status;
    data['admin_status'] = this.adminStatus;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['districtid'] = this.districtid;
    data['state_id'] = this.stateId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['profile_img'] = this.profileImg;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
