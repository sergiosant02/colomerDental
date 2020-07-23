import 'package:flutter/material.dart';

class ProviderPage with ChangeNotifier {
  int _page = 0;

  get page {
    return _page;
  }

  set page(int pageRec) {
    this._page = pageRec;
    notifyListeners();
  }
}
