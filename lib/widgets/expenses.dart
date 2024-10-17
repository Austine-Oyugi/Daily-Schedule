import 'package:flutter/material.dart';
import 'package:third_app/widgets/chart/chart.dart';
import 'package:third_app/widgets/expenses_list/expenses_list.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/new_expense.dart';

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
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: const Text('Flutter ExpensesTracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                // const Text('The chart'), // Add const if it's a static widget.
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

                // const Text('The chart'), // Add const if it's a static widget.
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:third_app/expenses_list.dart';
// import 'package:third_app/models/expense.dart';


// class Expenses extends StatefulWidget {
//   const Expenses({super.key});
//   @override
//   State<Expenses> createState() {
//     return _ExpensesState();
//   }
// }

// class _ExpensesState extends State<Expenses>{
//   final List<Expense> _registeredExpenses=[
//     Expense(
//     title: 'Flutter Course', 
//     amount: 19.99, 
//     date: DateTime.now(),
//     category: Category.work,
//     ),
//     Expense(
//     title: 'Cinema', 
//     amount: 15.69, 
//     date: DateTime.now(),
//     category: Category.leisure,
//     ),
//   ];
// }

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Column(
//         children:const [
//           Text('The chart'),
//           ExpensesList(expenses: _registeredExpenses)
          
//         ],
//       ),
//     );
//   }

