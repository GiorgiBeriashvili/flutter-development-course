import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/logic/blocs/blocs.dart';
import 'package:midterm_02/presentation/screens/screens.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.exception.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: userIdController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.tag),
                          labelText: 'User ID',
                          hintText: 'Enter the user ID',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please provide a valid user ID'
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushNamed(
                              context,
                              HomeScreen.routeName,
                              arguments: int.parse(userIdController.text),
                            );
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AuthenticationLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthenticationLoadSuccess) {
            return const Center(
              child: Text('Success!'),
            );
          } else {
            return Center(
              child: ElevatedButton.icon(
                onPressed: () => context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationInitialized()),
                icon: const Icon(Icons.replay),
                label: const Text('Retry'),
              ),
            );
          }
        },
      ));

  @override
  void dispose() {
    userIdController.dispose();

    super.dispose();
  }
}
