import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'statistic_item.dart';

class StatisticCard extends StatelessWidget {
  final List<Expense> expenses;

  const StatisticCard({
    super.key, 
    required this.expenses
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: Category.values.map((category) => StatisticItem(expenses: expenses, category: category)).toList(),
      )
    );
  }
}