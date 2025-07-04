class HallOfFrameConsisntantlyTopModel {
  final String id;
  final String name;
  final int timesRankedTop;

  HallOfFrameConsisntantlyTopModel({
    required this.id,
    required this.name,
    required this.timesRankedTop,
  });

  factory HallOfFrameConsisntantlyTopModel.fromJson(Map<String, dynamic> json) {
    return HallOfFrameConsisntantlyTopModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      timesRankedTop: json['timesRankedTop'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'timesRankedTop': timesRankedTop,
    };
  }
}
