import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderInvitations extends ChangeNotifier{
  //states
  ELoading? _loading;
  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = [];

  //getters
  ELoading? get loading => _loading;
  List<Contact> get contacts => _contacts;
  List<Contact> get selectedContacts => _selectedContacts;

  //setters
  set loading(ELoading? flag){
    _loading = flag;
    notifyListeners();
  }

  //methods
  void loadContacts()async{
    loading = ELoading.loading;
    if(await FlutterContacts.requestPermission()){
      _contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
    }else{
      Fluttertoast.showToast(msg: "Unable to load contacts! Permission is denied.");
    }
    loading = null;
  }

  void addSelectedContact(Contact contact) {
    if(!_selectedContacts.contains(contact)){
      _selectedContacts.add(contact);
      notifyListeners();
    }
  }

  void removeSelectedContact(Contact contact) {
    _selectedContacts.remove(contact);
    notifyListeners();
  }

}