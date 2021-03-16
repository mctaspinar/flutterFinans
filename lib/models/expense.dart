import 'package:flutter/material.dart';

class Expense {
  int id;
  String category;
  String subtitle;
  String currentDate;
  double value;
  Color color;

  Expense(
      {this.category,
      this.value,
      this.color,
      this.subtitle,
      this.currentDate,
      this.id}) {
    this.category = category;
    this.value = value;
    this.color = category == 'Giyim'
        ? Color(0xff40bad5)
        : category == 'Market'
            ? Color(0xffe8505b)
            : category == 'Kredi Kartı'
                ? Color(0xfffe91ca)
                : category == 'Sigara'
                    ? Color(0xfff48b29)
                    : Color(0xff025955);
    this.subtitle = subtitle;
    this.currentDate = currentDate;
    this.id = id;
  }

  @override
  String toString() {
    return 'Expense{category: $category, value: $value, color: $color}';
  }

  Map<String, dynamic> toMap() {
    var temp = Map<String, dynamic>();
    temp['value'] = value;
    temp['category'] = category;
    temp['subtitle'] = subtitle;
    temp['currentDate'] = currentDate;
    temp['id'] = id;
    return temp;
  }

  Expense.FromMap(Map<String, dynamic> map) {
    value = map['value'];
    category = map['category'];
    color = category == 'Giyim'
        ? Color(0xff40bad5)
        : category == 'Market'
            ? Color(0xffe8505b)
            : category == 'Kredi Kartı'
                ? Color(0xfffe91ca)
                : category == 'Sigara'
                    ? Color(0xfff48b29)
                    : Color(0xff025955);
    subtitle = map['subtitle'];
    currentDate = map['currentDate'];
    id = map['id'];
  }

  int get getId => id;

  set setId(int id) => this.id = id;

  String get getCurrentDate => currentDate;

  set setCurrentDate(String currentDate) => this.currentDate = currentDate;

  String get getSubtitle => subtitle;

  set setSubtitle(String subtitle) => this.subtitle = subtitle;

  String get getCategory => category;

  set setCategory(String category) => this.category = category;

  double get getValue => value;

  set setValue(double value) => this.value = value;

  set setColor(Color color) {
    if (this.category == 'Market') {
      this.color = Color(0xff40bad5);
    } else if (this.category == 'Giyim') {
      this.color = Color(0xffe8505b);
    } else if (this.category == 'Kredi Kartı') {
      this.color = Color(0xfffe91ca);
    } else if (this.category == 'Sigara') {
      this.color = Color(0xfff48b29);
    } else {
      this.color = Color(0xfffe91ca);
    }
  }
}
