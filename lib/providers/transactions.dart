import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../repository/transaction_repo.dart';

enum ViewState { Idle, Busy }

class Transaction {
  final int id;
  final String title;
  final double value;
  final String category;
  final IconData iconData;
  final Color color;
  final DateTime currentDate;

  const Transaction(
      {@required this.id,
      @required this.title,
      @required this.value,
      @required this.category,
      @required this.iconData,
      @required this.color,
      this.currentDate});
}

class Transactions with ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  TransactionRepo _transactionRepo = TransactionRepo();
  Expense _expense;

  Expense get expense => _expense;

  ViewState get state => _viewState;

  set state(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  Future<List<Expense>> getAllExpense() async {
    try {
      var list = await _transactionRepo.getExpenseList();
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<Expense>> getAll(String date) async {
    try {
      var list = await _transactionRepo.getAll(date);
      List<Expense> temp = [];
      for (Map map in list) {
        temp.add(Expense.FromMap(map));
      }
      return temp;
    } catch (e) {}
  }

  Future<int> transactionAdd(Expense expense) async {
    try {
      var result = await _transactionRepo.transactionAdd(expense);
      return result;
    } catch (e) {}
  }
}
