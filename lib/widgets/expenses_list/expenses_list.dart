import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;
  @override
  Widget build(context) {
    return //Column() We dont use column here because here we  have list  where we dont know the length of the list it might have a log of items - Lec101
        //ListView(children: [])  // bas iska fayda ye hai ki automatically scrollable. This is not efficient because it renders all the items at once(same thing happens with Column)
        // lec 101
        ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx,index) =>ExpenseItem(expenses[index]),   
    );
  }
}
