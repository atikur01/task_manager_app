import 'package:flutter/material.dart';
import 'package:task_manager/core/models/api_response.dart';
import 'package:task_manager/core/network/api_caller.dart';
import 'package:task_manager/core/constants/urls.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ApiResponse> signIn(String email, String password) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    _isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.PostRequest(
      URL: Urls.LoginUrl,
      body: requestBody,
    );

    _isLoading = false;
    notifyListeners();

    return response;
  }
}
