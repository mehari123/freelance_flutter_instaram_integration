import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  bool isLoggedIn = true;
  String token = '';
  List<Media> mediaList = [];
  String nextPageToken = '';
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    clearToken();
    super.initState();
    // Fetch user media directly
    fetchUserMedia();

    // Add a listener for scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        // At the bottom of the list
        fetchNextPage();
      }
    });
  }

  // Function to check if a token is already stored in shared preferences
  Future<void> fetchUserMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedToken = prefs.getString('access_token') ?? '';

    if (storedToken.isNotEmpty) {
      // If a token is stored, set it and fetch user media
      setState(() {
        token = storedToken;
      });

      // Initial fetch
      await fetchNextPage();
    }
  }

  Future<void> fetchNextPage() async {
    // Fetch the next page of user media
    final url = nextPageToken.isEmpty
        ? 'https://graph.instagram.com/v12.0/me/media?fields=id,caption&access_token=$token'
        : 'https://graph.instagram.com/v12.0/me/media?fields=id,caption&access_token=$token&page_info=$nextPageToken';

    
    
    try {
      final response = await http.get(Uri.parse(url));
       print(
            "data **********************************************8***********************8***********************8***********************8***********************" +
                response.body);

      

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       
        if (data['data'] != null && (data['data'] as List).isNotEmpty) {
          final List<Media> media = (data['data'] as List)
              .map((item) => Media(
                    id: item['id'] ?? '',
                    caption: item['caption'] ?? '',
                  ))
              .toList();

          setState(() {
            mediaList.addAll(media);

            // Set the next page token for pagination
            nextPageToken = data['paging']['cursors']['after'] ?? '';
          });
        } else {
          // No more data available
          setState(() {
            nextPageToken = '';
          });
        }
      } else {
        // Handle API error
        print('Instagram API error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Profile'),
        actions: [
          if (isLoggedIn)
            IconButton(
              onPressed: () async {
                clearToken();
                await fetchNextPage(); // Fetch fresh data after clearing
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    'home',
                    (route) =>
                        false); // Navigate to home page and remove all previous routes
              },
              icon: Icon(Icons.logout),
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: fetchUserMedia,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: mediaList.length,
                    itemBuilder: (context, index) {
                      final media = mediaList[index];
                      return ListTile(
                        title: Text('ID: ${media.id}'),
                        subtitle: Text('Caption: ${media.caption}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to clear the stored token and log out
  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');

    setState(() {
      isLoggedIn = false;
      token = '';
      mediaList.clear();
      nextPageToken = '';
    });
  }
}

class Media {
  final String id;
  final String caption;

  Media({
    required this.id,
    required this.caption,
  });
}
