class matrimony_subscriptions_model {
  List<StatusMessage>? statusMessage;

  matrimony_subscriptions_model({this.statusMessage});

  matrimony_subscriptions_model.fromJson(Map<String, dynamic> json) {
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
  String? subsId;
  String? name;
  String? price;
  String? viewProfile;
  String? personalMess;
  String? chat;
  String? cms;
  String? newMatches;
  String? status;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;

  StatusMessage(
      {this.id,
        this.subsId,
        this.name,
        this.price,
        this.viewProfile,
        this.personalMess,
        this.chat,
        this.cms,
        this.newMatches,
        this.status,
        this.trashStatus,
        this.createdAt,
        this.updatedAt});

  StatusMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subsId = json['subs_id'];
    name = json['name'];
    price = json['price'];
    viewProfile = json['view_profile'];
    personalMess = json['personal_mess'];
    chat = json['chat'];
    cms = json['cms'];
    newMatches = json['new_matches'];
    status = json['status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subs_id'] = this.subsId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['view_profile'] = this.viewProfile;
    data['personal_mess'] = this.personalMess;
    data['chat'] = this.chat;
    data['cms'] = this.cms;
    data['new_matches'] = this.newMatches;
    data['status'] = this.status;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
