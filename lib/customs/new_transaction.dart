import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/expense.dart';
import '../providers/transactions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewTransaction extends StatefulWidget {
  final Function fonks;

  NewTransaction(this.fonks);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  List<Category> _categories = Category.getCategories();
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedCategory;
  var _formkey = GlobalKey<FormState>();
  var _txtAciklama;
  double _txtTutar;
  var tarih;
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
                child: TextFormField(
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10)),
                  onChanged: (value) {
                    setState(() {
                      _txtAciklama = value;
                      print(_txtAciklama);
                    });
                  },
                  validator: (value) {
                    if (value.length < 3) {
                      return "En az 3 karakter giriniz.";
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(labelText: 'Tutar'),
                        onChanged: (value) {
                          setState(() {
                            _txtTutar = double.parse(value);
                          });
                        },
                        validator: (value) {
                          if (value.length < 1) {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
