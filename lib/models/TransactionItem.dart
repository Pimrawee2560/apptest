class TransactionItem {
  late int? id;
  String title;
  String nameeng;
  double height;
  String date;

  TransactionItem(
      {this.id,
      required this.title,
      required this.nameeng,
      required this.height,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'nameeng': nameeng,
      'height': height,
      'date': date
    };
  }
}
