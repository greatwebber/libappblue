class AllCategory {
  String? categoryName;
  String? id;
  String? remark;

  AllCategory(this.categoryName, this.id, this.remark);

  AllCategory.fromJson(Map<String, dynamic> json) {
    id = json['CategoryID'];
    categoryName = json['CategoryName'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryName'] = categoryName;
    data['remark'] = remark;
    return data;
  }
}
