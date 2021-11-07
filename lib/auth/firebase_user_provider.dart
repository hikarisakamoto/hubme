import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HubMeFirebaseUser {
  HubMeFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

HubMeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HubMeFirebaseUser> hubMeFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<HubMeFirebaseUser>((user) => currentUser = HubMeFirebaseUser(user));
