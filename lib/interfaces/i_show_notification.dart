import 'package:tims/notification_service.dart';

abstract class IShowNotification {
  Future<void> showNotification(NotificationService service, String title, String body);
}
