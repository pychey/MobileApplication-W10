import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {
  food(Icons.restaurant),
  travel(Icons.travel_explore),
  leisure(Icons.sunny),
  work(Icons.work);

  final IconData icon;

  const Category(this.icon);
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get dateFormated => DateFormat('dd / MM / yyyy').format(date);

  Expense({String? id, required this.title, required this.amount, DateTime? date, required this.category})
    : id = id ?? uuid.v4(), date = date ?? DateTime.now();
}