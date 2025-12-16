import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;
  String get selectedDateFormated => DateFormat('dd / MM / yyyy').format(_selectedDate!);

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1999), 
      lastDate: DateTime.now()
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void onChangeCategory (Category? newCategory) {
    setState(() {
      _selectedCategory = newCategory!;
    });
  }

  void onCreate() {
    String  title = _titleController.text;
    double amount = double.tryParse(_amountController.text) ?? 0;
    Category category = _selectedCategory;
    Expense newExpense = Expense(title: title, amount: amount, category: category, date: _selectedDate);

    Navigator.pop(context, newExpense);
  }
  
  void onCancel() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(label: Text("Amount")),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null ? 'No Date Selected' : selectedDateFormated),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () => selectDate(context), 
                        icon: Icon(Icons.calendar_today)
                      )
                    ],
                  ),
                )
              )
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              DropdownButton<Category>(
                focusColor: Colors.transparent,
                value: _selectedCategory,
                onChanged: onChangeCategory,
                items: Category.values.map((category) => DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name.toUpperCase())
                  )
                ).toList(),
              ),
              Spacer(),
              TextButton(style: ElevatedButton.styleFrom(overlayColor: Colors.transparent), onPressed: onCancel, child: Text("Cancel")),
              SizedBox(width: 50),
              ElevatedButton(onPressed: onCreate, child: Text("Save Expense")),
            ],
          )
        ],
      ),
    );
  }
}
