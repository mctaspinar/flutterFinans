import 'package:flutter/material.dart';
import 'package:flutter_finans/models/expense.dart';
import 'package:flutter_finans/providers/transactions.dart';
import 'package:provider/provider.dart';
import '../customs/transactions_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TransactionCard extends StatefulWidget {
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  var tarih = DateFormat.yMd().format(DateTime.now());
  var _height = .07;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _transactionModel = Provider.of<Transactions>(context, listen: false);
    List<Expense> expenseList = List<Expense>();
    return FutureBuilder(
      future: _transactionModel.getAll(tarih),
      initialData: expenseList,
      builder: (context, AsyncSnapshot<List<Expense>> snapshot) {
        return Positioned(
          bottom: 0,
          left: mediaQuery.size.width * .03,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            width: mediaQuery.size.width * .94,
            height: mediaQuery.size.height * _height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragStart: (_) {
                    setState(() {
                      _height = .07;
                    });
                  },
                  onVerticalDragDown: (_) {
                    setState(() {
                      _height = .54;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: mediaQuery.size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextButton(
                          style: TextButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(2000, 1, 1),
                              maxTime: DateTime.now(),
                              onConfirm: (date) {
                                setState(() {
                                  tarih = DateFormat.yMd().format(date);
                                  _height = .54;
                                });
                              },
                              currentTime: DateTime.now(),
                            );
                          },
                          child: Text(
                            tarih,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return TransactionItem(snapshot.data[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
