import 'dart:ui';
import 'package:flutter/material.dart';
import 'calendar_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String selectedCategory = "All";

  final List<String> categories = const [
    "All",
    "Action",
    "Sci-Fi",
    "Comedy",
    "Drama",
    "Horror",
    "Romance"
  ];

  final List<Map<String, String>> trendingMovies = const [
    {
      'title': 'The Adventure',
      'image':
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=800'
    },
    {
      'title': 'Space Odyssey',
      'image':
          'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=800'
    },
    {
      'title': 'The Last Stand',
      'image':
          'https://images.unsplash.com/photo-1517604412707-af6993172c91?q=80&w=800'
    },
  ];

  final List<Map<String, String>> movies = const [
    {
      'title': 'The Adventure',
      'genre': 'Action/Adventure',
      'rating': '9.2',
      'image':
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=500'
    },
    {
      'title': 'City Lights',
      'genre': 'Comedy/Romance',
      'rating': '8.5',
      'image':
          'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=500'
    },
    {
      'title': 'Interstellar Journey',
      'genre': 'Sci-Fi/Drama',
      'rating': '9.0',
      'image':
          'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=500'
    },
    {
      'title': 'Dark Night',
      'genre': 'Crime/Drama',
      'rating': '8.8',
      'image':
          'https://images.unsplash.com/photo-1478720568477-152d9b164e26?q=80&w=500'
    },
    {
      'title': 'Frozen Peaks',
      'genre': 'Adventure/Drama',
      'rating': '8.2',
      'image':
          'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=500'
    },
    {
      'title': 'Neon City',
      'genre': 'Sci-Fi/Thriller',
      'rating': '8.7',
      'image':
          'https://images.unsplash.com/photo-1514464750060-00e6e34c8b3c?q=80&w=500'
    },
    {
      'title': 'Silence',
      'genre': 'Horror/Thriller',
      'rating': '7.9',
      'image':
          'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=500'
    },
    {
      'title': 'The Great Race',
      'genre': 'Action/Sports',
      'rating': '8.4',
      'image':
          'https://images.unsplash.com/photo-1547394765-185e1e68f34e?q=80&w=500'
    },
  ];

  List<Map<String, String>> get filteredMovies {
    if (selectedCategory == "All") return movies;
    return movies.where((movie) => movie['genre']!.contains(selectedCategory)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Dark cinematic background
      body: CustomScrollView(
        slivers: [
          // Glassmorphic App Bar with Search
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A2E).withOpacity(0.8),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                  title: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 12),
                        Icon(Icons.search, color: Colors.white54, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Search movies...",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  background: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "DISCOVER",
                        style: TextStyle(
                          letterSpacing: 4,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalendarScreen()),
                  );
                },
              ),
            ],
          ),

          // Categories chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedCategory == categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF84464)
                            : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Trending Carousel
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "Trending",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: trendingMovies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(trendingMovies[index]['image'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            trendingMovies[index]['title'] ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // All Movies Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Text(
                selectedCategory == "All" ? "Now Showing" : "$selectedCategory Movies",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final movie = filteredMovies[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF16213E),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                movie['image'] ?? '',
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie['rating'] ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'] ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie['genre'] ?? '',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: filteredMovies.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
