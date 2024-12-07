import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Profile/Controller/profile_service.dart';
import 'package:requests_management_system/Features/Profile/Data/ProfileModel.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? profileModel;

  Future<void> fetchProfile(
      {required String token, required int employeeId}) async {
    try {
      final profileService = ProfileService(token: token);
      profileModel = await profileService.getProfile(employeeId);
      notifyListeners();
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }
}
