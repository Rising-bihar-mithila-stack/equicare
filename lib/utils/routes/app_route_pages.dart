import 'package:equicare/features/contacts/model/contact_model.dart';
import 'package:equicare/features/my_stable/presentation/screens/edit_horse_screen.dart';
import 'package:equicare/features/settings/presentation/screens/push_notification_screen.dart';
import 'package:equicare/utils/routes/app_route_names.dart';
import 'package:get/route_manager.dart';

import '../../bottom_navigation_bar.dart';
import '../../features/auth/presentation/screens/change_password_screen.dart';
import '../../features/auth/presentation/screens/create_account_screen.dart';
import '../../features/auth/presentation/screens/forget_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_verfication_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/contacts/presentation/screens/add_and_edit_contact_screen.dart';
import '../../features/contacts/presentation/screens/specific_contact_detail_screen.dart';
import '../../features/home/presentation/screens/event_details_screen.dart';
import '../../features/home/presentation/screens/search_event_details_screen.dart';
import '../../features/home/presentation/screens/search_event_screen.dart';
import '../../features/my_calendar/presentation/screens/add_event_screen.dart';
import '../../features/my_calendar/presentation/screens/completed_events_screen.dart';
import '../../features/my_calendar/presentation/screens/edit_event_screen.dart';
import '../../features/my_stable/presentation/screens/add_horse_screen.dart';
import '../../features/my_stable/presentation/screens/specific_horse_details_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/profile/presentation/screens/profile_edit_screen.dart';
import '../../features/settings/presentation/screens/associated_users_screen.dart';
import '../../features/settings/presentation/screens/change_email_screen.dart';
import '../../features/settings/presentation/screens/change_password_from_setting_screen.dart';
import '../../features/settings/presentation/screens/connections_screen.dart';
import '../../features/settings/presentation/screens/invite_user_screen.dart';
import '../../features/settings/presentation/screens/invites_sent_screen.dart';
import '../../features/settings/presentation/screens/new_password_screen.dart';
import '../../features/settings/presentation/screens/setting_screen.dart';
import '../../features/subscription/presentation/subscription_screen.dart';

var routesPages = [
  GetPage(
    name: AppRouteNames().loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRouteNames().signUpScreen,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: AppRouteNames().forgetPasswordScreen,
    page: () => const ForgetPasswordScreen(),
  ),
  GetPage(
    name: AppRouteNames().otpVerificationScreen,
    page: () => const OtpVerificationScreen(),
  ),
  // GetPage(
  //   name: AppRouteNames().changePasswordScreen,
  //   page: () => const ChangePasswordScreen(),
  // ),
  GetPage(
    name: AppRouteNames().createAccountScreen,
    page: () => const CreateAccountScreen(),
  ),
  GetPage(
    name: AppRouteNames().subscriptionScreen,
    page: () => const SubscriptionScreen(),
  ),
  GetPage(
    name: AppRouteNames().bottomNavigationBarScreen,
    page: () => const BottomNavigationBarScreen(),
  ),
  GetPage(
    name: AppRouteNames().eventDetailsScreen,
    page: () => EventDetailsScreen(),
  ),
  GetPage(
    name: AppRouteNames().searchEventDetailsScreen,
    page: () => SearchEventDetailsScreen(),
  ),
  GetPage(
    name: AppRouteNames().addHorseScreen,
    page: () => const AddHorseScreen(),
  ),
  GetPage(
    name: AppRouteNames().specificHorseDetailsScreen,
    page: () => const SpecificHorseDetailsScreen(),
  ),
  GetPage(
    name: AppRouteNames().editHorseScreen,
    page: () => EditHorseScreen(),
  ),
  GetPage(
    name: AppRouteNames().addEventScreen,
    page: () =>  AddEventScreen(),
  ),
  GetPage(
    name: AppRouteNames().editEventScreen,
    page: () =>  EditEventScreen(),
  ),
  GetPage(
    name: AppRouteNames().completedEventsScreen,
    page: () =>  CompletedEventsScreen(),
  ),
  GetPage(
    name: AppRouteNames().profileEditScreen,
    page: () => ProfileEditScreen(),
  ),
  GetPage(
    name: AppRouteNames().addAndEditContactScreen,
    page: () => AddAndEditContactScreen(),
  ),
  GetPage(
    name: AppRouteNames().specificContactDetailScreen,
    page: () => SpecificContactDetailScreen(),
  ),
  GetPage(
    name: AppRouteNames().settingScreen,
    page: () => SettingScreen(),
  ),
  GetPage(
    name: AppRouteNames().pushNotificationScreen,
    page: () => const PushNotificationScreen(),
  ),
  GetPage(
    name: AppRouteNames().changeEmailScreen,
    page: () => const ChangeEmailScreen(),
  ),
  GetPage(
    name: AppRouteNames().changePasswordFromSettingScreen,
    page: () => const ChangePasswordFromSettingScreen(),
  ),
  GetPage(
    name: AppRouteNames().newPasswordScreen,
    page: () => NewPasswordScreen(),
  ),
  GetPage(
    name: AppRouteNames().associatedUsersScreen,
    page: () => AssociatedUsersScreen(),
  ),
  GetPage(
    name: AppRouteNames().inviteUserScreen,
    page: () => const InviteUserScreen(),
  ),
  GetPage(
    name: AppRouteNames().connectionsScreen,
    page: () => const ConnectionsScreen(),
  ),
  GetPage(
    name: AppRouteNames().invitesSentScreen,
    page: () => InvitesSentScreen(),
  ),
  GetPage(
    name: AppRouteNames().searchEventScreen,
    page: () => SearchEventScreen(),
  ),
  GetPage(
    name: AppRouteNames().onboardingScreen,
    page: () => OnboardingScreen(),
  ),
];
