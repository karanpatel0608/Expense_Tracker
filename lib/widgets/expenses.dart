import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Ice Cream',
        amount: 24.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Cinema Ticket',
        amount: 22.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    //...
    showModalBottomSheet(
        context: context,
        builder: (ctx) => const Text(
            'Modal Bottom Sheet')); //Ctx is now the context object for the modal element created by flutter
    //we name it ctx so that it does not get confused with the context of the main scaffold
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Own Expenses-Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('the chart will go here'),
          Expanded(
            child: ExpensesList(
                expenses: // Expanded use krna padega kyuki kind of a column(list) inside a colimn that will lead to problems and no output will come because flutter dont know kiski size kitni rakhni hai
                    _registeredExpenses),
          )
        ],
      ),
    );
  }
}
