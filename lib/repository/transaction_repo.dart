import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';
import '../utils/db_helper.dart';

enum AppMode { DEBUG, RELEASE }

class TransactionRepo {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  AppMode appMode = AppMode.RELEASE;
  List<Expense> _expenseList = List<Expense>();

  Future<List<Expense>> getExpenseList() async {
    try {
      if (appMode == AppMode.DEBUG) {
        _expenseList = [
          Expense(
              id: 1,
              category: "Sigara",
              color: Color(0xff40bad5),
              currentDate: DateFormat.yMd().format(DateTime.now()),
              subtitle: "Deneme",
              value: 12.99)
        ];
      } else {
        return await _databaseHelper.getExpenseList();
      }
    } catch (e) {}
  }

  Future<List<Map<String, dynamic>>> getAll(String date) async {
    try {
      if (appMode == AppMode.DEBUG) {
        _expenseList = [
          Expense(
              id: 1,
              category: "Sigara",
              color: Color(0xff40bad5),
              currentDate: DateFormat.yMd().format(DateTime.now()),
              subtitle: "Deneme",
              value: 12.99)
        ];
      } else {
        return await _databaseHelper.getAll(date);
      }
    } catch (e) {
      return [];
    }
  }

  Future<int> transactionAdd(Expense expense) async {
    try {
      if (appMode == AppMode.DEBUG) {
        Expense(
            id: 1,
            category: "Sigara",
            color: Color(0xff40bad5),
            currentDate: DateFormat.yMd().format(DateTime.now()),
            subtitle: "Deneme",
            value: 12.99);
      } else {
        return await _databaseHelper.transactionAdd(expense);
      }
    } catch (e) {
      return -1;
    }
  }
}
