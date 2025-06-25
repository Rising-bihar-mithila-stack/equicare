import 'dart:developer';

import 'package:equicare/features/settings/modals/sub_user_modal.dart';
import 'package:equicare/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import '../../../utils/urls/app_urls.dart';
import '../../auth/presentation/screens/create_account_screen.dart';
import '../modals/invites_sent_user_modal.dart';

class AssociatedUsersController extends GetxController {
  RxBool isLoading = false.obs;
  Future<bool?> sendInvitationMail({required String email}) async {
    try {
      isLoading.value = true;
      await appNetworkClient.createPostRequestWithHeader(
        url: sendInvitationMailUrl,
        data: {"email": email},
      );
      // await Future.delayed(Duration(seconds: 1));
      return true;
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // log("sendInvitationMaill ---> $e");
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
    }
  }

  List<InvitesSentUserModal> invitesSentList = [];
  Future<void> getInvitedUsers() async {
    try {
      isLoading.value = true;
      update(["invitesSent"]);
      var res = await appNetworkClient.createGetRequestWithHeader(
          url: getInvitationUrl);
      List usersJson = res.data["data"];
      invitesSentList = usersJson
          .map(
            (e) => InvitesSentUserModal.fromJson(e),
          )
          .toList();
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // log("getInvitedUserss ---> $e");
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update(["invitesSent"]);
    }
  }

  List<SubUserModal> subUsersList = [];
  Future<void> getSubUsers() async {
    try {
      isLoading.value = true;
      update(["subUsers"]);
      var res = await appNetworkClient.createGetRequestWithHeader(
          url: getSubUsersUrl);
      List usersJson = res.data["data"];
      subUsersList = usersJson
          .map(
            (e) => SubUserModal.fromJson(e),
          )
          .toList();
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // log("getSubUserss ---> $e");
      // Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update(["subUsers"]);
    }
  }

  Future<bool?> deleteSubUser({required int subUserId}) async {
    try {
      isLoading.value = true;
      update();
      var res = appNetworkClient.createPostRequestWithHeader(
          url: removeSubUsersUrl, data: {"id": "$subUserId"});
      // await Future.delayed(Duration(seconds: 1));
      return true;
    } catch (e) {
      showMyDialogWithoutContext(e.toString());
      // log("deleteSubUserr ---> $e");
      // Get.snackbar("Error", "$e");
      return false;
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
