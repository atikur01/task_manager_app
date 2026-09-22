import 'package:flutter/material.dart';
import 'package:task_manager/core/models/api_response.dart';
import 'package:task_manager/core/network/api_caller.dart';
import 'package:task_manager/core/constants/urls.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ApiResponse> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    _isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.PostRequest(
      URL: Urls.SignUpURL,
      body: requestBody,
    );

    _isLoading = false;
    notifyListeners();

    return response;
  }
}
