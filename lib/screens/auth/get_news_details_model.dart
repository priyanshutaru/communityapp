class get_news_details_model {
  List<StatusMessage>? statusMessage;

  get_news_details_model({this.statusMessage});

  get_news_details_model.fromJson(Map<String, dynamic> json) {
    if (json['status_message'] != null) {
      statusMessage = <StatusMessage>[];
      json['status_message'].forEach((v) {
        statusMessage!.add(new StatusMessage.fromJson(v));
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

class StatusMessage {
  int? id;
  String? categoryId;
  String? categoryName;
  String? newsId;
  String? title;
  String? description;
  String? addedDate;
  String? addedTime;
  String? img;
  String? addedBy;
  String? likes;
  String? comments;
  String? shares;
  String? status;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;
  String? likeStatus;

  StatusMessage(
      {this.id,
        this.categoryId,
        this.categoryName,
        this.newsId,
        this.title,
        this.description,
        this.addedDate,
        this.addedTime,
        this.img,
        this.addedBy,
        this.likes,
        this.comments,
        this.shares,
        this.status,
        this.trashStatus,
        this.createdAt,
        this.updatedAt,
        this.likeStatus});

  StatusMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    newsId = json['news_id'];
    title = json['title'];
    description = json['description'];
    addedDate = json['added_date'];
    addedTime = json['added_time'];
    img = json['img'];
    addedBy = json['added_by'];
    likes = json['likes'];
    comments = json['comments'];
    shares = json['shares'];
    status = json['status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likeStatus = json['like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['added_date'] = this.addedDate;
    data['added_time'] = this.addedTime;
    data['img'] = this.img;
    data['added_by'] = this.addedBy;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['shares'] = this.shares;
    data['status'] = this.status;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['like_status'] = this.likeStatus;
    return data;
  }
}
