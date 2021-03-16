import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/expense.dart';
import '../providers/transactions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function done;
  NewTransaction(this.done);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  List<Category> _categories = Category.getCategories();
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedCategory;
  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;
    if (_amountController.text.isEmpty) {
      return;
    }

    if (enteredTitle.isEmpty || double.parse(enteredAmount) < 0) {
      return;
    } else {
      print(enteredTitle + " " + enteredAmount);
      _titleController.text = "";
      _amountController.text = "";
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_categories);
    _selectedCategory = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItems(List categories) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(
            category.name,
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final _transactionModel = Provider.of<Transactions>(context, listen: false);
    var tarih;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: DropdownButtonFormField(
                      isDense: true,
                      decoration: InputDecoration(
                          labelText: "Kategori",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10)),
                      value: _selectedCategory,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                          print(_selectedCategory.name);
                        });
                      },
                    ),
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "İçerik"),
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(labelText: "Harcama"),
                  onSubmitted: (_) => _submitData(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () async {
                        tarih = DateFormat.yMd().format(DateTime.now());
                        var result = await _transactionModel.transactionAdd(
                            Expense(
                                category: _selectedCategory.name,
                                value: double.parse(_amountController.text),
                                subtitle: _titleController.text,
                                currentDate: tarih));
                        if (result != 0) {
                          widget.done();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Harcama Ekle",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*class NewTransaction extends StatefulWidget {
  final Function fonks;

  NewTransaction(this.fonks);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var _formkey = GlobalKey<FormState>();
  var _txtAciklama;
  double _txtTutar;
  var tarih;
  

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    var mediaQuery = MediaQuery.of(context);
    final _transactionModel = Provider.of<Transactions>(context, listen: false);

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(
                color: Colors.white10, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20.0)),
        height: 365,
        width: mediaQuery.size.width * .95,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    isDense: true,
                    decoration: InputDecoration(
                        labelText: "Kategori",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10)),
                    value: _selectedCategory,
                    items: _dropdownMenuItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        print(_selectedCategory.name);
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          tarih = DateFormat.yMd().format(DateTime.now());
                          var result = await _transactionModel.transactionAdd(
                              Expense(
                                  category: _selectedCategory.name,
                                  value: _txtTutar,
                                  subtitle: _txtAciklama,
                                  currentDate: tarih));
                          if (result != 0) {
                            widget.fonks();
                          } else {
                            print("hata");
                          }
                        }
                      },
                      icon: Icon(Icons.add, color: primaryColor),
                      label: Text(
                        "Ekle",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: primaryColor,
                          side: BorderSide(color: primaryColor, width: 1)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.clear, color: primaryColor),
                      label: Text(
                        "İptal",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: primaryColor,
                          side: BorderSide(color: primaryColor, width: 1)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
