//
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your email';
// }
// final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+');
// if (!emailRegex.hasMatch(value)) {
// return 'Enter a valid email address';
// }
// return null;
// }
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your password';
// }
// if (value.length < 8) {
// return 'Password must be at least 8 characters long';
// }
// if (!RegExp(r'[A-Z]').hasMatch(value)) {
// return 'Password must contain at least one uppercase letter';
// }
// if (!RegExp(r'[0-9]').hasMatch(value)) {
// return 'Password must contain at least one number';
// }
// if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
// return 'Password must contain at least one special character';
// }
// return null;
// }
// if (state is SignupLoadingState) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// }
// if (state is SignupErrorState) {
// String errorMessage;
// switch (state.error) {
// case 'email-already-in-use':
// errorMessage = 'This email is already in use.';
// break;
// case 'invalid-email':
// errorMessage = 'Invalid email address.';
// break;
// case 'weak-password':
// errorMessage = 'Password is too weak.';
// break;
// default:
// errorMessage = 'An unknown error occurred.';
// }
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text(errorMessage)),
// );
// }
