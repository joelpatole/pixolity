import 'package:flutter/material.dart';
import 'package:pixolity/screens/add_post_screen.dart';
import 'package:pixolity/screens/feed_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('Notify'),
  Text('profile'),
];
