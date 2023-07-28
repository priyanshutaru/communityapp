class get_forum_coment_model {
  String? statusMessage;
  List<ForumCommenmt>? responseData;

  get_forum_coment_model({this.statusMessage, this.responseData});

  get_forum_coment_model.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    if (json['response_data'] != null) {
      responseData = <ForumCommenmt>[];
      json['response_data'].forEach((v) {
        responseData!.add(new ForumCommenmt.fromJson(v));
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

class ForumCommenmt {
  int? id;
  String? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImg;
  String? comntId;
  String? userID;
  String? forumCmntId;
  Null? comntParentID;
  String? commentType;
  String? comntComment;
  String? postedDate;
  String? postedTime;
  int? likeComments;
  String? likeTime;
  String? likeDate;
  List<Reply>? reply;

  ForumCommenmt(
      {this.id,
        this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.profileImg,
        this.comntId,
        this.userID,
        this.forumCmntId,
        this.comntParentID,
        this.commentType,
        this.comntComment,
        this.postedDate,
        this.postedTime,
        this.likeComments,
        this.likeTime,
        this.likeDate,
        this.reply});

  ForumCommenmt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    comntId = json['comnt_id'];
    userID = json['user_ID'];
    forumCmntId = json['forum_cmnt_id'];
    comntParentID = json['comnt_parentID'];
    commentType = json['comment_type'];
    comntComment = json['comnt_comment'];
    postedDate = json['posted_date'];
    postedTime = json['posted_time'];
    likeComments = json['like_comments'];
    likeTime = json['like_time'];
    likeDate = json['like_date'];
    if (json['reply'] != null) {
      reply = <Reply>[];
      json['reply'].forEach((v) {
        reply!.add(new Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['profile_img'] = this.profileImg;
    data['comnt_id'] = this.comntId;
    data['user_ID'] = this.userID;
    data['forum_cmnt_id'] = this.forumCmntId;
    data['comnt_parentID'] = this.comntParentID;
    data['comment_type'] = this.commentType;
    data['comnt_comment'] = this.comntComment;
    data['posted_date'] = this.postedDate;
    data['posted_time'] = this.postedTime;
    data['like_comments'] = this.likeComments;
    data['like_time'] = this.likeTime;
    data['like_date'] = this.likeDate;
    if (this.reply != null) {
      data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reply {
  int? id;
  String? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImg;
  String? comntId;
  String? userID;
  String? forumCmntId;
  String? comntParentID;
  String? commentType;
  String? comntComment;
  String? postedDate;
  String? postedTime;
  int? likeComments;
  String? likeTime;
  String? likeDate;

  Reply(
      {this.id,
        this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.profileImg,
        this.comntId,
        this.userID,
        this.forumCmntId,
        this.comntParentID,
        this.commentType,
        this.comntComment,
        this.postedDate,
        this.postedTime,
        this.likeComments,
        this.likeTime,
        this.likeDate});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    comntId = json['comnt_id'];
    userID = json['user_ID'];
    forumCmntId = json['forum_cmnt_id'];
    comntParentID = json['comnt_parentID'];
    commentType = json['comment_type'];
    comntComment = json['comnt_comment'];
    postedDate = json['posted_date'];
    postedTime = json['posted_time'];
    likeComments = json['like_comments'];
    likeTime = json['like_time'];
    likeDate = json['like_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['profile_img'] = this.profileImg;
    data['comnt_id'] = this.comntId;
    data['user_ID'] = this.userID;
    data['forum_cmnt_id'] = this.forumCmntId;
    data['comnt_parentID'] = this.comntParentID;
    data['comment_type'] = this.commentType;
    data['comnt_comment'] = this.comntComment;
    data['posted_date'] = this.postedDate;
    data['posted_time'] = this.postedTime;
    data['like_comments'] = this.likeComments;
    data['like_time'] = this.likeTime;
    data['like_date'] = this.likeDate;
    return data;
  }
}
