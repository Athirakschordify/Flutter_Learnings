class Ticket {
  final String id;
  final String title;
  final String venue;
  final String dateTime;
  final String colorHex;
  final bool isPast;
  final String category;

  Ticket({
    required this.id,
    required this.title,
    required this.venue,
    required this.dateTime,
    required this.colorHex,
    required this.isPast,
    required this.category,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String,
      title: json['title'] as String,
      venue: json['venue'] as String,
      dateTime: json['dateTime'] as String,
      colorHex: json['colorHex'] as String,
      isPast: json['isPast'] as bool,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'venue': venue,
      'dateTime': dateTime,
      'colorHex': colorHex,
      'isPast': isPast,
      'category': category,
    };
  }
}
