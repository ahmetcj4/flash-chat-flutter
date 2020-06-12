import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

const rWelcome = '/';
const rLogin = '/login';
const rRegister = '/register';
const rChat = '/chat';

final routes = {
  rWelcome: (c) => WelcomeScreen(),
  rLogin: (c) => LoginScreen(),
  rRegister: (c) => RegistrationScreen(),
  rChat: (c) => ChatScreen(),
};
