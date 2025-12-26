import 'dart:convert';
import '../models/ticket_model.dart';

class TicketService {
  // Simulating API call with local JSON data
  Future<List<Ticket>> fetchTickets() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // This would normally be an HTTP call to your API
    // For now, we're using local JSON data
    final jsonData = _getTicketsJson();
    final List<dynamic> ticketsJson = jsonDecode(jsonData)['tickets'];
    
    return ticketsJson.map((json) => Ticket.fromJson(json)).toList();
  }

  String _getTicketsJson() {
    return '''
    {
      "tickets": [
        {
          "id": "1",
          "title": "Concert Night",
          "venue": "Madison Square Garden",
          "dateTime": "Dec 28, 2024 • 8:00 PM",
          "colorHex": "FFC0CB",
          "isPast": false,
          "category": "Music"
        },
        {
          "id": "2",
          "title": "Tech Conference 2025",
          "venue": "Convention Center",
          "dateTime": "Jan 5, 2025 • 9:00 AM",
          "colorHex": "FFEB3B",
          "isPast": false,
          "category": "Conference"
        },
        {
          "id": "3",
          "title": "Sports Game",
          "venue": "National Stadium",
          "dateTime": "Jan 12, 2025 • 7:30 PM",
          "colorHex": "2196F3",
          "isPast": false,
          "category": "Sports"
        },
        {
          "id": "4",
          "title": "Art Exhibition",
          "venue": "Modern Art Museum",
          "dateTime": "Jan 18, 2025 • 10:00 AM",
          "colorHex": "9C27B0",
          "isPast": false,
          "category": "Art"
        },
        {
          "id": "5",
          "title": "Food Festival",
          "venue": "Central Park",
          "dateTime": "Jan 25, 2025 • 12:00 PM",
          "colorHex": "FF9800",
          "isPast": false,
          "category": "Food"
        },
        {
          "id": "6",
          "title": "Comedy Show",
          "venue": "Comedy Club Downtown",
          "dateTime": "Feb 2, 2025 • 9:00 PM",
          "colorHex": "4CAF50",
          "isPast": false,
          "category": "Comedy"
        },
        {
          "id": "7",
          "title": "Movie Premiere",
          "venue": "Grand Cinema",
          "dateTime": "Feb 14, 2025 • 7:00 PM",
          "colorHex": "F44336",
          "isPast": false,
          "category": "Movies"
        },
        {
          "id": "8",
          "title": "Broadway Musical",
          "venue": "Theater District",
          "dateTime": "Feb 20, 2025 • 8:00 PM",
          "colorHex": "E91E63",
          "isPast": false,
          "category": "Theater"
        },
        {
          "id": "9",
          "title": "Wine Tasting Event",
          "venue": "Vineyard Estate",
          "dateTime": "Feb 28, 2025 • 6:00 PM",
          "colorHex": "795548",
          "isPast": false,
          "category": "Food"
        },
        {
          "id": "10",
          "title": "Gaming Tournament",
          "venue": "Esports Arena",
          "dateTime": "Mar 5, 2025 • 2:00 PM",
          "colorHex": "00BCD4",
          "isPast": false,
          "category": "Gaming"
        },
        {
          "id": "11",
          "title": "Fashion Show",
          "venue": "Fashion Week Venue",
          "dateTime": "Mar 12, 2025 • 7:00 PM",
          "colorHex": "FF4081",
          "isPast": false,
          "category": "Fashion"
        },
        {
          "id": "12",
          "title": "Charity Gala",
          "venue": "Grand Ballroom",
          "dateTime": "Mar 20, 2025 • 6:30 PM",
          "colorHex": "FFD700",
          "isPast": false,
          "category": "Event"
        },
        {
          "id": "13",
          "title": "Jazz Night",
          "venue": "Blue Note Jazz Club",
          "dateTime": "Dec 15, 2024 • 9:00 PM",
          "colorHex": "3F51B5",
          "isPast": true,
          "category": "Music"
        },
        {
          "id": "14",
          "title": "Theater Play",
          "venue": "Broadway Theater",
          "dateTime": "Dec 10, 2024 • 7:30 PM",
          "colorHex": "009688",
          "isPast": true,
          "category": "Theater"
        },
        {
          "id": "15",
          "title": "Rock Concert",
          "venue": "Arena Stadium",
          "dateTime": "Nov 28, 2024 • 8:00 PM",
          "colorHex": "FFC107",
          "isPast": true,
          "category": "Music"
        },
        {
          "id": "16",
          "title": "Ballet Performance",
          "venue": "Opera House",
          "dateTime": "Nov 15, 2024 • 7:00 PM",
          "colorHex": "E1BEE7",
          "isPast": true,
          "category": "Dance"
        },
        {
          "id": "17",
          "title": "Film Festival",
          "venue": "Independent Cinema",
          "dateTime": "Nov 5, 2024 • 6:00 PM",
          "colorHex": "B0BEC5",
          "isPast": true,
          "category": "Movies"
        }
      ]
    }
    ''';
  }
}
