import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
	static final NotificationService _notificationService = NotificationService._internal();
	factory NotificationService() {
		return _notificationService;
	}
	NotificationService._internal();

	final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

	Future<void> init() async{
		const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('chat');
	  // final IOSInitializationSettings? iosInitializationSettings = null;	
		const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: null); 

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
	}

	NotificationDetails platformChannelSpecifics = const NotificationDetails(
		android: AndroidNotificationDetails(
		"tims",
		"tims_notifications",
		channelDescription: "tims_notifications description",
		importance: Importance.high,
		priority: Priority.high)
	);
}

Future<void> selectNotification(String? payload) async {

}
