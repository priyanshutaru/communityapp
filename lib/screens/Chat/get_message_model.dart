class get_message_deatils {
  int? statusCode;
  String? statusMessage;
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImg;
  List<Response_Message>? response;

  get_message_deatils(
      {this.statusCode,
        this.statusMessage,
        this.firstName,
        this.middleName,
        this.lastName,
        this.profileImg,
        this.response});

  get_message_deatils.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
    if (json['response'] != null) {
      response = <Response_Message>[];
      json['response'].forEach((v) {
        response!.add(new Response_Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['profile_img'] = this.profileImg;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response_Message {
  int? id;
  String? chatMsgId;
  String? chatID;
  String? userId;
  String? sendMsg;
  String? sendDate;
  String? sendTime;
  String? seenStatusSender;
  String? seenStatusReceiver;
  String? seenDateTimeSender;
  String? seenDateTimeReceiver;
  String? trashStatusSender;
  String? trashDateTimeSender;
  String? trashStatusReceiver;
  String? trashDateTimeReceiver;
  String? createdAt;
  String? updatedAt;

  Response_Message(
      {this.id,
        this.chatMsgId,
        this.chatID,
        this.userId,
        this.sendMsg,
        this.sendDate,
        this.sendTime,
        this.seenStatusSender,
        this.seenStatusReceiver,
        this.seenDateTimeSender,
        this.seenDateTimeReceiver,
        this.trashStatusSender,
        this.trashDateTimeSender,
        this.trashStatusReceiver,
        this.trashDateTimeReceiver,
        this.createdAt,
        this.updatedAt});

  Response_Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatMsgId = json['chat_msg_id'];
    chatID = json['chatID'];
    userId = json['user_id'];
    sendMsg = json['send_msg'];
    sendDate = json['send_date'];
    sendTime = json['send_time'];
    seenStatusSender = json['seen_status_sender'];
    seenStatusReceiver = json['seen_status_receiver'];
    seenDateTimeSender = json['seen_date_time_sender'];
    seenDateTimeReceiver = json['seen_date_time_receiver'];
    trashStatusSender = json['trash_status_sender'];
    trashDateTimeSender = json['trash_date_time_sender'];
    trashStatusReceiver = json['trash_status_receiver'];
    trashDateTimeReceiver = json['trash_date_time_receiver'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_msg_id'] = this.chatMsgId;
    data['chatID'] = this.chatID;
    data['user_id'] = this.userId;
    data['send_msg'] = this.sendMsg;
    data['send_date'] = this.sendDate;
    data['send_time'] = this.sendTime;
    data['seen_status_sender'] = this.seenStatusSender;
    data['seen_status_receiver'] = this.seenStatusReceiver;
    data['seen_date_time_sender'] = this.seenDateTimeSender;
    data['seen_date_time_receiver'] = this.seenDateTimeReceiver;
    data['trash_status_sender'] = this.trashStatusSender;
    data['trash_date_time_sender'] = this.trashDateTimeSender;
    data['trash_status_receiver'] = this.trashStatusReceiver;
    data['trash_date_time_receiver'] = this.trashDateTimeReceiver;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
