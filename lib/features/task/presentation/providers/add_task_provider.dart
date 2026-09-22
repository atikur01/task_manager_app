import 'package:flutter/material.dart';
import 'package:task_manager/core/models/api_response.dart';
import 'package:task_manager/core/network/api_caller.dart';
import 'package:task_manager/core/constants/urls.dart';

class AddTaskProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ApiResponse> addTask({
    required String title,
    required String description,
    required String? token,
  }) async {
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };

    _isLoading = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.PostRequest(
      URL: Urls.AddTaskURL,
      body: requestBody,
      token: token,
    );

    _isLoading = false;
    notifyListeners();

    return response;
  }
}
