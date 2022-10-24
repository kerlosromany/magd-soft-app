class HelpModel {
  late int status;
  late String message;
  late List<dynamic> help;

  HelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    help = json['help'];
  }
}

class Help {
  late int id;
  late String question;
  late String answer;

  Help(this.id, this.question, this.answer);

  Help.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['question'] = this.question;
  //   data['answer'] = this.answer;
  //   return data;
  // }
}
