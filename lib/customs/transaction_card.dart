import 'package:flutter/material.dart';
import 'package:flutter_finans/models/expense.dart';
import 'package:flutter_finans/providers/transactions.dart';
import 'package:provider/provider.dart';
import '../customs/transactions_item.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  var tarih = DateFormat.yMMMMd('tr_TR').format(DateTime.now());
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
          top: mediaQuery.size.height * .3,
          left: mediaQuery.size.width * .03,
          child: Container(
            width: mediaQuery.size.width * .94,
            height: mediaQuery.size.height * .6,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: mediaQuery.size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            locale: Locale('tr'),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            setState(() {
                              tarih = DateFormat.yMMMMd('tr_TR').format(value);
                              print("listeleme tarih : $tarih");
                            });
                          });
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
