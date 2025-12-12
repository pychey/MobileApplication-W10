import 'package:flutter/material.dart';
import 'ui/expenses/expenses_screen.dart';
import 'data/expense_data.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpensesScreen(initializeExpenses: expenses),
    ),
  );
}
