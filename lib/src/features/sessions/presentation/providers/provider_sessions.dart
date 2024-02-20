import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderSessions extends ChangeNotifier{
  //states
  ELoading? _loading;

  //getters
  ELoading? get loading => _loading;

  //setters
  set loading(ELoading? flag){
    _loading = flag;
    notifyListeners();
  }

  //methods


}