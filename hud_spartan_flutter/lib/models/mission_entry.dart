class MissionEntry {
  final String organization;
  final String title;
  final String period;
  final List<String> details;

  const MissionEntry({
    required this.organization,
    required this.title,
    required this.period,
    required this.details,
  });

  factory MissionEntry.fromJson(Map<String, dynamic> json) {
    return MissionEntry(
      organization: json['organization'],
      title: json['title'],
      period: json['period'],
      details: List<String>.from(json['details']),
    );
  }
}
