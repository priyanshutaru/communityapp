class vadaval_sanskriti_model {
  int? countComment;
  List<ResponseUserRegister>? data;

  vadaval_sanskriti_model({this.countComment, this.data});

  vadaval_sanskriti_model.fromJson(Map<String, dynamic> json) {
    countComment = json['count_comment'];
    if (json['data'] != null) {
      data = <ResponseUserRegister>[];
      json['data'].forEach((v) {
        data!.add(new ResponseUserRegister.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_comment'] = this.countComment;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseUserRegister {
  int? id;
  String? sansPostId;
  String? userId;
  String? topicCatId;
  String? topicCatName;
  String? title;
  String? discussionTopic;
  String? img;
  int? likes;
  int? totalComment;
  int? totalShares;
  String? userStatus;
  String? adminStatus;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;
  int? countComment;
  String? likeStatus;

  ResponseUserRegister(
      {this.id,
        this.sansPostId,
        this.userId,
        this.topicCatId,
        this.topicCatName,
        this.title,
        this.discussionTopic,
        this.img,
        this.likes,
        this.totalComment,
        this.totalShares,
        this.userStatus,
        this.adminStatus,
        this.trashStatus,
        this.createdAt,
        this.updatedAt,
        this.countComment,
        this.likeStatus});

  ResponseUserRegister.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sansPostId = json['sans_post_id'];
    userId = json['user_id'];
    topicCatId = json['topic_cat_id'];
    topicCatName = json['topic_cat_name'];
    title = json['title'];
    discussionTopic = json['discussion_topic'];
    img = json['img'];
    likes = json['likes'];
    totalComment = json['total_comment'];
    totalShares = json['total_shares'];
    userStatus = json['user_status'];
    adminStatus = json['admin_status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countComment = json['count_comment'];
    likeStatus = json['like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sans_post_id'] = this.sansPostId;
    data['user_id'] = this.userId;
    data['topic_cat_id'] = this.topicCatId;
    data['topic_cat_name'] = this.topicCatName;
    data['title'] = this.title;
    data['discussion_topic'] = this.discussionTopic;
    data['img'] = this.img;
    data['likes'] = this.likes;
    data['total_comment'] = this.totalComment;
    data['total_shares'] = this.totalShares;
    data['user_status'] = this.userStatus;
    data['admin_status'] = this.adminStatus;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['count_comment'] = this.countComment;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
