import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_app/utils/ServiceResponse.dart';

class FirebaseService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<ServiceResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google User: ${googleUser.email}");

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      print("Google User: ${user.displayName}");
      print("Google User: ${user.email}");
      print("Google User: ${user.photoUrl}");

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return ServiceResponse.ok(result: user);
    } catch (error) {
      print("Firebase Login Error $error");
      return ServiceResponse.error(msg: "Não foi possível fazer o login!");
    }
  }

  signOutGoogle() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    print("User Sign Out");
  }

  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();
}
