class get_open_forum_model {
  String? statusMessage;
  List<ResponseData>? responseData;

  get_open_forum_model({this.statusMessage, this.responseData});

  get_open_forum_model.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    if (json['response_data'] != null) {
      responseData = <ResponseData>[];
      json['response_data'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_message'] = this.statusMessage;
    if (this.responseData != null) {
      data['response_data'] =
          this.responseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  int? id;
  String? forumId;
  String? userID;
  String? title;
  String? topicCatID;
  String? discussionCatg;
  String? addedDate;
  String? addedTime;
  int? likes;
  int? comments;
  String? status;
  String? adminStatus;
  String? trashStatus;
  String? createdAt;
  Null? updatedAt;
  String? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImg;
  String? likeStatus;

  ResponseData(
      {this.id,
        this.forumId,
        this.userID,
        this.title,
        this.topicCatID,
        this.discussionCatg,
        this.addedDate,
        this.addedTime,
        this.likes,
        this.comments,
        this.status,
        this.adminStatus,
        this.trashStatus,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.profileImg,
        this.likeStatus});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    forumId = json['forumId'];
    userID = json['userID'];
    title = json['title'];
    topicCatID = json['topic_catID'];
    discussionCatg = json['discussion_catg'];
    addedDate = json['added_date'];
    addedTime = json['added_time'];
    likes = json['likes'];
    comments = json['comments'];
    status = json['status'];
    adminStatus = json['admin_status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    likeStatus = json['like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['forumId'] = this.forumId;
    data['userID'] = this.userID;
    data['title'] = this.title;
    data['topic_catID'] = this.topicCatID;
    data['discussion_catg'] = this.discussionCatg;
    data['added_date'] = this.addedDate;
    data['added_time'] = this.addedTime;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['admin_status'] = this.adminStatus;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['profile_img'] = this.profileImg;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
