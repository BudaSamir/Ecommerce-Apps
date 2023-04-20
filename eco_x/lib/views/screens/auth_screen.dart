import 'package:eco_x/controllers/auth_controller.dart';
import 'package:eco_x/utilities/enums.dart';
import 'package:eco_x/utilities/routes.dart';
import 'package:eco_x/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if (!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.landingScreenRoute);
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  'Error!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: Text(
                  e.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthController>(
      builder: (_, model, __) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 32),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 80.0),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value!.isEmpty ? 'Please Enter Your email' : null,
                      decoration: const InputDecoration(
                          labelText: 'Email', hintText: 'Enter Your Email'),
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (value) =>
                          value!.isEmpty ? 'Please Enter Your Password' : null,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Your Password'),
                    ),
                    const SizedBox(height: 16.0),
                    if (model.authFormType == AuthFormType.login)
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text('Forget Your Password ?'),
                          onTap: () {},
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    /*
                    ======================================
                    = The Main Button Starts
                    ======================================
                    */
                    MainButton(
                        text: model.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submit(model);
                          }
                        }),
                    /*
                    ======================================
                    = The Main Button Ends
                    ======================================
                    */
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Text(
                          model.authFormType == AuthFormType.login
                              ? 'Don\'t have an account ?   Register'
                              : 'Have an Account ? Login',
                        ),
                        onTap: () {
                          _formKey.currentState!.reset();
                          model.toggleFOrmType();
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.17),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.authFormType == AuthFormType.login
                              ? 'Or Login With'
                              : 'Or Register With',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              "assets/images/google.png",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset("assets/images/facebook.png"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        )),
      ),
    );
  }
}
