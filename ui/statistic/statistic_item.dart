import 'package:flutter/material.dart';
import '../../models/expense.dart';

class StatisticItem extends StatelessWidget {
  final List<Expense> expenses;
  final Category category;
  double get totalPrice => expenses.fold<double>(0, (total, expense) => expense.category == category ? total + expense.amount : total);

  const StatisticItem({
    super.key, 
    required this.expenses, 
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('\$ ${totalPrice.toStringAsFixed(2)}'),
          Icon(category.icon, size: 30)
        ],
      ),
    );
  }
}