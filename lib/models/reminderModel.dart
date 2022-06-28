class ReminderModel {
  int? remindarid;
  String? rtype;
  String? rdesc;
  String? rdate;
  String? rtime;
  int? patientid;

  ReminderModel(
      {this.remindarid,
      this.rtype,
      this.rdesc,
      this.rdate,
      this.rtime,
      this.patientid});

  ReminderModel.fromJson(Map<String, dynamic> json) {
    remindarid = json['remindarid'];
    rtype = json['rtype'];
    rdesc = json['rdesc'];
    rdate = json['rdate'];
    rtime = json['rtime'];
    patientid = json['patientid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remindarid'] = this.remindarid;
    data['rtype'] = this.rtype;
    data['rdesc'] = this.rdesc;
    data['rdate'] = this.rdate;
    data['rtime'] = this.rtime;
    data['patientid'] = this.patientid;
    return data;
  }
}
