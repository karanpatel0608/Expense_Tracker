import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

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
    //..........showModalBottomSheet() is a method that is provided by flutter to show a modal bottom sheet
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(
            onAddExpense:
                _addExpense)); //Ctx is now the context object for the modal element created by flutter
    //we name it ctx so that it  does not get confused with the context of the main scaffold
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(
      () {
        _registeredExpenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted!"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);

    Widget mainContent = const Center(child: Text('No expenses added yet!'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Own Expenses-Tracker'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
