class blood_bank_model {
  int? status;
  List<StatusMessage>? statusMessage;

  blood_bank_model({this.status, this.statusMessage});

  blood_bank_model.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? bankId;
  String? name;
  String? img;
  String? city;
  String? phone;
  Null? fullAddress;
  String? status;
  String? trashStatus;
  String? createdAt;
  String? updatedAt;

  StatusMessage(
      {this.id,
        this.bankId,
        this.name,
        this.img,
        this.city,
        this.phone,
        this.fullAddress,
        this.status,
        this.trashStatus,
        this.createdAt,
        this.updatedAt});

  StatusMessage.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    bankId = json['bank_id'];
    name = json['name'];
    img = json['img'];
    city = json['city'];
    phone = json['phone'];
    fullAddress = json['full_address'];
    status = json['status'];
    trashStatus = json['trash_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['name'] = this.name;
    data['img'] = this.img;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['full_address'] = this.fullAddress;
    data['status'] = this.status;
    data['trash_status'] = this.trashStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
