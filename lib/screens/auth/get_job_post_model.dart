class get_job_post_model {
  List<Job_Post>? data;

  get_job_post_model({this.data});

  get_job_post_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Job_Post>[];
      json['data'].forEach((v) {
        data!.add(new Job_Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Job_Post {
  String? id;
  String? jobId;
  String? categoryId;
  String? subCategoryId;
  Null? jobType;
  String? userId;
  String? img;
  String? companyName;
  String? comapnyEmail;
  String? jobLocation;
  String? hrMobile;
  Null? jobPosition;
  String? noOfVacancy;
  String? requiredExp;
  String? qualification;
  String? verify;
  String? userStatus;
  String? status;
  String? trashJob;
  String? createdAt;
  String? updatedAt;
  String? subcategoryId;
  String? subcategoryName;
  String? trashCategory;
  String? districtid;
  String? districtTitle;
  String? stateId;
  String? districtDescription;
  String? districtStatus;

  Job_Post(
      {this.id,
        this.jobId,
        this.categoryId,
        this.subCategoryId,
        this.jobType,
        this.userId,
        this.img,
        this.companyName,
        this.comapnyEmail,
        this.jobLocation,
        this.hrMobile,
        this.jobPosition,
        this.noOfVacancy,
        this.requiredExp,
        this.qualification,
        this.verify,
        this.userStatus,
        this.status,
        this.trashJob,
        this.createdAt,
        this.updatedAt,
        this.subcategoryId,
        this.subcategoryName,
        this.trashCategory,
        this.districtid,
        this.districtTitle,
        this.stateId,
        this.districtDescription,
        this.districtStatus});

  Job_Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    jobType = json['job_type'];
    userId = json['user_id'];
    img = json['img'];
    companyName = json['company_name'];
    comapnyEmail = json['comapny_email'];
    jobLocation = json['job_location'];
    hrMobile = json['hr_mobile'];
    jobPosition = json['job_position'];
    noOfVacancy = json['no_of_vacancy'];
    requiredExp = json['required_exp'];
    qualification = json['qualification'];
    verify = json['verify'];
    userStatus = json['user_status'];
    status = json['status'];
    trashJob = json['trash_job'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    trashCategory = json['trash_category'];
    districtid = json['districtid'];
    districtTitle = json['district_title'];
    stateId = json['state_id'];
    districtDescription = json['district_description'];
    districtStatus = json['district_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['job_type'] = this.jobType;
    data['user_id'] = this.userId;
    data['img'] = this.img;
    data['company_name'] = this.companyName;
    data['comapny_email'] = this.comapnyEmail;
    data['job_location'] = this.jobLocation;
    data['hr_mobile'] = this.hrMobile;
    data['job_position'] = this.jobPosition;
    data['no_of_vacancy'] = this.noOfVacancy;
    data['required_exp'] = this.requiredExp;
    data['qualification'] = this.qualification;
    data['verify'] = this.verify;
    data['user_status'] = this.userStatus;
    data['status'] = this.status;
    data['trash_job'] = this.trashJob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['trash_category'] = this.trashCategory;
    data['districtid'] = this.districtid;
    data['district_title'] = this.districtTitle;
    data['state_id'] = this.stateId;
    data['district_description'] = this.districtDescription;
    data['district_status'] = this.districtStatus;
    return data;
  }
}
