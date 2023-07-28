class chat_list_horizontal_model {
  int? statusCode;
  String? statusMessage;
  List<Chat_horizontal>? response;

  chat_list_horizontal_model(
      {this.statusCode, this.statusMessage, this.response});

  chat_list_horizontal_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    if (json['response'] != null) {
      response = <Chat_horizontal>[];
      json['response'].forEach((v) {
        response!.add(new Chat_horizontal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat_horizontal {
  String? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? photo;
  int? primaryId;
  String? chatId;
  String? senderId;
  String? receiverId;
  String? lastMessage;
  String? sendTime;
  String? sendDate;
  String? duration;
  int? unseenMsg;

  Chat_horizontal(
      {this.userId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.photo,
        this.primaryId,
        this.chatId,
        this.senderId,
        this.receiverId,
        this.lastMessage,
        this.sendTime,
        this.sendDate,
        this.duration,
        this.unseenMsg});

  Chat_horizontal.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    photo = json['photo'];
    primaryId = json['primary_id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    lastMessage = json['last_message'];
    sendTime = json['send_time'];
    sendDate = json['send_date'];
    duration = json['duration'];
    unseenMsg = json['unseen_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['photo'] = this.photo;
    data['primary_id'] = this.primaryId;
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['last_message'] = this.lastMessage;
    data['send_time'] = this.sendTime;
    data['send_date'] = this.sendDate;
    data['duration'] = this.duration;
    data['unseen_msg'] = this.unseenMsg;
    return data;
  }
}
