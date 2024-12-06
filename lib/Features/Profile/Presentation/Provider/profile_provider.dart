import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Profile/Controller/profile_service.dart';
import 'package:requests_management_system/Features/Profile/Data/ProfileModel.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? profileModel;
  Future<void> getProfile() async {
    profileModel = await ProfileService.getProfile();
    notifyListeners();
  }
}

// class ProfileProvider extends ChangeNotifier {
//   ProfileModel? profileModel; // Stores profile data
//   bool isLoading = false; // Tracks loading state
//   String? errorMessage; // Stores error messages (if any)
//
//   /// Fetch profile data
//   Future<void> getProfile() async {
//     isLoading = true; // Set loading to true
//     errorMessage = null; // Reset error message
//     notifyListeners(); // Notify UI of state change
//
//     try {
//       profileModel = await ProfileService.getProfile(); // Fetch profile
//     } catch (error) {
//       errorMessage =
//           "حدث خطأ أثناء تحميل البيانات. حاول مرة أخرى."; // Handle error
//       profileModel = null; // Reset profile data
//     } finally {
//       isLoading = false; // Stop loading
//       notifyListeners(); // Notify UI of state change
//     }
//   }
//
//   /// Refresh profile manually
//   Future<void> refreshProfile() async {
//     await getProfile();
//   }
// }
