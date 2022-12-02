import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixolity/utils/colors.dart';
import 'package:pixolity/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Text('Pixolity',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.blue)),/*SvgPicture.asset(
          'assets/ic_instagram.svg' /*'assets/ic_instagram.svg'*/,
          color: Colors.blueAccent,
          height: 32,
        ),*/
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //Snapshot will give us All the ids from the 'posts' collection
          //i.e snapshot.data.docs has the list of all the posts 
          //therefore we are able to get the length.
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard(
              snap: snapshot.data!.docs[index].data(), 
            ),
          );
        },
      ),
    );
  }
}
