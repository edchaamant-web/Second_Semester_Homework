class AppData {
  final int id;
  final String note;
  final bool checkStatus;

  AppData({required this.id, required this.note, required this.checkStatus});

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      id: map['id'],
      note: map['note'],
      checkStatus: map['checkStatus'] == 1,
    );
  }
}
