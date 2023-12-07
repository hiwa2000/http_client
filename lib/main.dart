import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importing the http package
import 'dart:convert'; // Importing the convert library for JSON encoding and decoding

void main() {
  runApp(MyApp()); // Entry point of the app
}

class UserModel {
  int id;
  String name;
  String email;

  UserModel({ // UserModel class with id, name, and email properties
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) { // Factory method to create a UserModel from JSON
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User List'), // App bar title
          backgroundColor: Colors.lightBlue, // Background color of the app bar
        ),
        body: Container(
          color: Colors.lightGreen[100], // Background color for the body
          child: UserList(), // Displaying the UserList widget
        ),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final String apiUrl = "https://jsonplaceholder.typicode.com/users"; // API URL to fetch users

  Future<List<UserModel>> fetchUsers() async { // Method to fetch users from the API
    final response = await http.get(Uri.parse(apiUrl)); // Making a GET request

    if (response.statusCode == 200) { // If the request is successful
      List<dynamic> data = jsonDecode(response.body); // Decode the JSON response
      List<UserModel> users = data.map((json) => UserModel.fromJson(json)).toList(); // Map JSON to UserModels
      return users; // Return the list of users
    } else {
      throw Exception("Failed to load users"); // Throw an exception for failed requests
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar( // Adding a scrollbar to the user list
      child: FutureBuilder<List<UserModel>>( // Using FutureBuilder to handle the asynchronous data
        future: fetchUsers(), // The future to wait for
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { // While the data is being fetched
            return Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            );
          } else if (snapshot.hasError) { // If an error occurred
            return Center(
              child: Text("Error: ${snapshot.error}"), // Display the error message
            );
          } else { // If the data is available
            List<UserModel> users = snapshot.data!; // Get the list of users

// without ID

            // return ListView.builder( // Display the list of users in a ListView
            //   itemCount: users.length,
            //   itemBuilder: (context, index) {
            //     return Card( // Display each user in a card
            //       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            //       child: ListTile(
            //         title: Text(users[index].name), // User's name
            //         subtitle: Text(users[index].email), // User's email
            //       ),
            //     );
            //   },
            // );


// with  ID
            return ListView.builder(
  itemCount: users.length,
  itemBuilder: (context, index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text("ID: ${users[index].id} - ${users[index].name}"),
        subtitle: Text(users[index].email),
      ),
    );
  },
);
          }
        },
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class PostModel {
//   int id;
//   String title;
//   String body;

//   PostModel({
//     required this.id,
//     required this.title,
//     required this.body,
//   });

//   factory PostModel.fromJson(Map<String, dynamic> json) {
//     return PostModel(
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Posts List'),
//           backgroundColor: Colors.lightBlue,
//         ),
//         body: Container(
//           color: Colors.lightGreen[100],
//           child: PostList(),
//         ),
//       ),
//     );
//   }
// }

// class PostList extends StatefulWidget {
//   @override
//   _PostListState createState() => _PostListState();
// }

// class _PostListState extends State<PostList> {
//   final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

//   Future<List<PostModel>> fetchPosts() async {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<PostModel> posts =
//           data.map((json) => PostModel.fromJson(json)).toList();
//       return posts;
//     } else {
//       throw Exception("Failed to load posts");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       child: FutureBuilder<List<PostModel>>(
//         future: fetchPosts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error}"),
//             );
//           } else {
//             List<PostModel> posts = snapshot.data!;
//             return ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     title: Text(posts[index].title),
//                     subtitle: Text(posts[index].body),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
