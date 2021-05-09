class TodoModel {
  String todo;
  bool isCompleted;
  int id;

  TodoModel({this.todo, this.isCompleted, this.id});

  TodoModel.fromJson(Map<String, dynamic> json) {
    todo = json['todo'];
    isCompleted = json['isCompleted'] == "true";
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todo'] = this.todo;
    data['isCompleted'] = this.isCompleted;
    data['id'] = this.id;
    return data;
  }
}
