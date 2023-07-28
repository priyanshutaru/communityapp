class my_blood_request_model {
  int? status;
  List<StatusMessage>? statusMessage;

  my_blood_request_model({this.status, this.statusMessage});

  my_blood_request_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['status_message'] != null) {
      statusMessage = <StatusMessage>[];
      json['status_message'].forEach((v) {
        statusMessage!.add(new StatusMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.statusMessage != null) {
      data['status_message'] =
          this.statusMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusMessage {
  int? id;
  String? reqId;
  String? userId;
  String? bloodType;
  String? unit;
  String? city;
  String? completeStatus;
  String? status;
  int? adminStatus;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;

  StatusMessage(
      {this.id,
        this.reqId,
        this.userId,
        this.bloodType,
        this.unit,
        this.city,
        this.completeStatus,
        this.status,
        this.adminStatus,
        this.trashStatus,
        this.createdAt,
        this.updatedAt});

  StatusMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reqId = json['req_id'];
    userId = json['user_id'];
    bloodType = json['blood_type'];
    unit = json['unit'];
    city = json['city'];
    completeStatus = json['complete_status'];
    status = json['status'];
    adminStatus = json['admin_status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['req_id'] = this.reqId;
    data['user_id'] = this.userId;
    data['blood_type'] = this.bloodType;
    data['unit'] = this.unit;
    data['city'] = this.city;
    data['complete_status'] = this.completeStatus;
    data['status'] = this.status;
    data['admin_status'] = this.adminStatus;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
