import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopicInfo {
  TopicInfo({required this.iconData, required this.label});

  final IconData iconData;
  final String label;
}

List<TopicInfo> topics = [
  TopicInfo(iconData: FontAwesomeIcons.earthAmericas, label: "Geography"),
  TopicInfo(iconData: FontAwesomeIcons.flask, label: "Science"),
  TopicInfo(iconData: FontAwesomeIcons.percent, label: "Mathematics"),
  TopicInfo(iconData: FontAwesomeIcons.monument, label: "History"),
  TopicInfo(iconData: FontAwesomeIcons.baseball, label: "Sports"),
  TopicInfo(iconData: FontAwesomeIcons.palette, label: "Art"),
  TopicInfo(iconData: FontAwesomeIcons.film, label: "Film"),
  TopicInfo(iconData: FontAwesomeIcons.hashtag, label: "Social"),
  TopicInfo(iconData: FontAwesomeIcons.utensils, label: "Food"),
  TopicInfo(iconData: FontAwesomeIcons.paw, label: "Animals"),
  TopicInfo(iconData: FontAwesomeIcons.dove, label: "Birds"),
];
