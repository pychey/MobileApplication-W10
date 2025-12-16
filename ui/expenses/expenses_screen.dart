import 'package:flutter/material.dart';
import '../statistic/statistic_card.dart';
import '../../models/expense.dart';
import 'expense_form.dart';
import 'expense_item.dart';

class ExpensesScreen extends StatefulWidget {
  final List<Expense> initializeExpenses;

  const ExpensesScreen({
    super.key,
    required this.initializeExpenses
  });

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late List<Expense> expenses = widget.initializeExpenses;

  void onAddClicked(BuildContext context) async {
    final expense = await showModalBottomSheet<Expense>(
      isScrollControlled: false,
      context: context,
      builder: (c) => ExpenseForm(),
    );

    if (expense != null) {
      setState(() {
        expenses.add(expense);
      });
    }
  }

  void removeExpense(String expenseId) {
    setState(() {
      expenses.removeWhere((expense) => expense.id == expenseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => onAddClicked(context),
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 18)
        ],
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        title: const Text('Ronan The Best Expense App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            StatisticCard(expenses: expenses),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Dismissible(
                    key: ValueKey(expense.id), 
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => removeExpense(expense.id),
                    child: ExpenseItem(expense: expense),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

