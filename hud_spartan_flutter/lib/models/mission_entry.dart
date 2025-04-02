class MissionEntry {

  const MissionEntry({
    required this.organization,
    required this.title,
    required this.period,
    required this.details,
  });

  factory MissionEntry.fromJson(Map<String, dynamic> json) {
    return MissionEntry(
      organization: json['organization'] as String,
      title: json['title'] as String,
      period: json['period'] as String,
      details: List<String>.from(json['details'] as Iterable<dynamic>),
    );
  }
  final String organization;
  final String title;
  final String period;
  final List<String> details;
}
