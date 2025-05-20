import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nrep/routes/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/widgets.dart';

enum AuthMode { login, signup, forgot, otp }

enum AuthStyle { mode1, mode2, mode3, mode4 }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final List<Map<String, dynamic>> demoData = [
    {
      'title': 'Log in',
      'desc': 'Welcome Back',
      'btnText': 'LOG IN',
    },
    {
      'title': 'Registration',
      'desc': 'First time with us ?',
      'btnText': 'REGISTER'
    },
    {
      'title': 'Reset',
      'desc': 'Reset your password',
      'btnText': 'REINITIALIZE'
    },
    {
      'title': 'Verification',
      'desc': 'Checking of account',
      'btnText': 'VALIDATE OTP'
    },
  ];

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  var _isLoading = false;

  // var _isGoogleLoading = false;
  // var _isFaceBookLoading = false;
  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();

  final _namesController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _namesController.dispose();
    super.dispose();
  }

  void _switchAuthMode({required AuthMode mode}) =>
      setState(() => _authMode = mode);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    final bool keyboardShown = MediaQuery.of(context).viewInsets.bottom > 0;
    final ThemeData theme = Theme.of(context);
    final FocusScopeNode focusScope = FocusScope.of(context);

    Future<void> submit() async {
      focusScope.unfocus();
      // if (!_formKey.currentState!.validate()) return;
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (_authMode == AuthMode.login) {
          await userData
              .login(
                _emailController.text,
                _passwordController.text,
              )
              .then((_) => Navigator.pushReplacementNamed(
                  context, BottomNavBar.routeName));
        } else if (_authMode == AuthMode.forgot) {
          await userData.forgotPassword(_emailController.text).then((_) {
            if (context.mounted) {
              showToast(
                message: const Text(
                  'Utilisez le mot de passe recu par message sur votre telephone pour vous connectez',
                ),
                context: context,
                duration: const Duration(seconds: 20),
                backgroundColor: theme.primaryColor.withOpacity(0.9),
              );
            }
            setState(() {
              _switchAuthMode(mode: AuthMode.login);
            });
          });
        } else if (_authMode == AuthMode.signup) {
          await userData
              .register(
            _namesController.text,
            _emailController.text,
          )
              .then((_) {
            if (context.mounted) {
              showToast(
                message: const Text(
                  'Veillez verifier vos messages recus le CODE a completer',
                ),
                context: context,
                duration: const Duration(seconds: 20),
                backgroundColor: theme.primaryColor.withOpacity(0.9),
              );
            }
            setState(() {
              _switchAuthMode(mode: AuthMode.otp);
            });
          });
        } else if (_authMode == AuthMode.otp) {
          await userData
              .validateOtp(
            _passwordController.text,
            _emailController.text,
          )
              .then((_) {
            if (context.mounted) {
              showToast(
                message: const Text(
                  'Votre numero a ete verifie avec succes, Reinitialisez votre mot de passe maintenant',
                ),
                context: context,
                duration: const Duration(seconds: 10),
              );
            }
            setState(() {
              _passwordController.text = '';
              _switchAuthMode(mode: AuthMode.forgot);
            });
          });
        }
      } catch (error) {
        if (context.mounted) {
          showImportantInfo(
            message: Text(
              error.toString(),
              style: theme.textTheme.titleMedium,
            ),
            barrierDismissible: false,
            title: Text(
              'Error',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            context: context,
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: deviceSize.height * 0.01),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [theme.primaryColor, theme.primaryColor],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: deviceSize.height * 0.11),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 45,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          demoData[_authMode.index]['title'],
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.surface,
                            fontSize: deviceSize.width * 0.09,
                          ),
                        )
                            .animate(key: ValueKey(_authMode.index))
                            .fade(duration: 800.ms)
                            .slideX(curve: Curves.ease),
                        SizedBox(height: deviceSize.height * 0.009),
                        Text(
                          demoData[_authMode.index]['desc'],
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.surface,
                            fontSize: deviceSize.width * 0.045,
                          ),
                        )
                            .animate(key: ValueKey(_authMode.index + 10))
                            .fade(duration: 800.ms, delay: 500.ms)
                            .slideX(curve: Curves.ease),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: deviceSize.height * 0.015),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!keyboardShown)
                      Image.asset(
                        assetImages[3],
                        fit: BoxFit.fitWidth,
                      )
                          .animate()
                          .fade(duration: 500.ms)
                          .slideX(curve: Curves.ease),
                    // SizedBox(
                    //   height: keyboardShown ? 10 : deviceSize.height * 0.06,
                    // ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          //SIGN UP SECTION ================================================================================================================================

                          if (_authMode == AuthMode.signup)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: NormalField(
                                key: const ValueKey('signupNames'),
                                controller: _namesController,
                                hintText: "ex: John Doe",
                                labelText: 'Your full names',
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Fil in your names';
                                  }
                                  if (value.length < 5) {
                                    return 'Must have at least 5 Characters';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) => focusScope.nextFocus(),
                                onSaved: (value) =>
                                    _namesController.text = value!.trim(),
                              )
                                  .animate(key: const ValueKey('signupNames'))
                                  .fade(duration: 500.ms)
                                  .slideX(curve: Curves.ease),
                            ),
                          //LOG IN SECTION========================================================================================================================================
                          if (_authMode == AuthMode.login ||
                              _authMode == AuthMode.signup)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: NormalField(
                                key: const ValueKey('loginNum'),
                                controller: _emailController,
                                hintText: "ex: +243900000000",
                                labelText: 'Your phone number',
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(13),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\+?[0-9]*$'),
                                  ),
                                ],
                                prefixIcon: const Icon(Icons.dialpad_sharp),
                                validator: (value) {
                                  // if (value!.isEmpty) {
                                  //   return 'Fil in your mail';
                                  // }
                                  return null;
                                },
                                onFieldSubmitted: (_) => focusScope.nextFocus(),
                                onSaved: (value) =>
                                    _emailController.text = value!.trim(),
                              )
                                  .animate(key: const ValueKey('loginNum'))
                                  .fade(duration: 500.ms)
                                  .slideX(curve: Curves.ease),
                            ),
                          if (_authMode == AuthMode.login)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: PasswordField(
                                key: const ValueKey('loginPass'),
                                controller: _passwordController,
                                labelText: 'Password',
                                hintText: 'Enter your Password',
                                prefixIcon: const Icon(Icons.lock_open),
                                validator: (value) {
                                  // if (value!.isEmpty || value.length < 5) {
                                  //   return 'Password must be at least 3 characters';
                                  // }
                                  return null;
                                },
                                onFieldSubmitted: (_) => submit(),
                                onSaved: (value) {
                                  _passwordController.text = value!.trim();
                                },
                              )
                                  .animate(key: const ValueKey('loginPass'))
                                  .fade(duration: 700.ms)
                                  .slideX(curve: Curves.ease),
                            ),
                          if (_authMode == AuthMode.login)
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => _switchAuthMode(
                                      mode: AuthMode.forgot,
                                    ),
                                    child: Text(
                                      'Forgot password ?',
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        fontSize: 14,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          if (_authMode == AuthMode.signup)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const NormalField(
                                enabled: false,
                                suffixIcon: Icon(
                                  Icons.not_interested,
                                  color: Colors.red,
                                ),
                                initialValue: "Client",
                                key: ValueKey('signupConf'),
                                labelText: 'Role',
                                hintText: 'Your current role',
                                prefixIcon: Icon(CupertinoIcons.wrench),
                                keyboardType: TextInputType.text,
                              )
                                  .animate(key: const ValueKey('signupConf'))
                                  .fade(duration: 1100.ms)
                                  .slideX(curve: Curves.ease),
                            ),

                          if (_authMode == AuthMode.otp)
                            SizedBox(
                              height: 64,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  6,
                                  (index) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ),
                                      child: TextFormField(
                                        autofocus: index == 0 ? true : false,
                                        onChanged: (value) async {
                                          if (value.isNotEmpty ||
                                              value.length == 1) {
                                            _passwordController.text =
                                                _passwordController.text
                                                    .padRight(index + 1, value);
                                            focusScope.nextFocus();
                                            if (index == 5) {
                                              await submit();
                                            }
                                          }
                                          if (value.isEmpty) {
                                            _passwordController.text =
                                                _passwordController.text
                                                    .substring(0, index);
                                            focusScope.previousFocus();
                                          }
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.headlineSmall,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              13,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: theme.primaryColorLight,
                                            ),
                                          ),
                                        ),
                                      )
                                          .animate()
                                          .slideX(duration: (200.ms * index)),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          //FORGOT PASSWORD SECTION==============================================================================================================================
                          if (_authMode == AuthMode.forgot)
                            NormalField(
                              controller: _emailController,
                              key: const ValueKey('forgotNum'),
                              hintText: "ex: +243900000000",
                              labelText: 'Your registered phone number',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: true,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(13),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\+?[0-9]*$'),
                                ),
                              ],
                              prefixIcon: const Icon(Icons.dialpad_sharp),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Fil in your phone number';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => submit(),
                              onSaved: (value) =>
                                  _emailController.text = value!.trim(),
                            )
                                .animate(key: const ValueKey('forgotNum'))
                                .fade(duration: 600.ms)
                                .slideX(curve: Curves.ease),
                        ],
                      ),
                    ),
                    if (_isLoading)
                      const Loading()
                    else if (!_isLoading && !keyboardShown)
                      SizedBox(
                        width: deviceSize.width,
                        child: ElevatedButton(
                          onPressed: submit,
                          child: Text(
                            demoData[_authMode.index]['btnText'],
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    // if (!keyboardShown)
                    if (_authMode == AuthMode.login && !keyboardShown)
                      SizedBox(height: deviceSize.height * 0.02),
                    // if ((_authMode == AuthMode.login ||
                    //         _authMode == AuthMode.signup) &&
                    //     !keyboardShown)
                    //   Row(
                    //     children: [
                    //       const Expanded(child: Divider(color: Colors.grey)),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 19),
                    //         child: Text(
                    //           'Continue with',
                    //           style: theme.textTheme.labelSmall?.copyWith(
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ),
                    //       const Expanded(child: Divider(color: Colors.grey)),
                    //     ],
                    //   ),
                    // if (_authMode == AuthMode.login && !keyboardShown)
                    //   SizedBox(height: deviceSize.height * 0.02),
                    // if (_authMode == AuthMode.login && !keyboardShown)
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Expanded(
                    //         child: _isGoogleLoading
                    //             ? Loading(
                    //                 width: 14,
                    //                 height: 14,
                    //                 message: Text(
                    //                   'Google Auth...',
                    //                   style: TextStyle(
                    //                     color: theme.primaryColor,
                    //                   ),
                    //                 ),
                    //               )
                    //             : Container(
                    //                 decoration: BoxDecoration(
                    //                   color:
                    //                       theme.primaryColor.withOpacity(0.4),
                    //                   borderRadius: BorderRadius.circular(30),
                    //                 ),
                    //                 child: TextButton.icon(
                    //                   onPressed: () async {
                    //                     setState(() {
                    //                       _isGoogleLoading = true;
                    //                     });
                    //                     showToast(
                    //                       message: const Text(
                    //                           "Available on next update"),
                    //                       context: context,
                    //                       duration: const Duration(seconds: 9),
                    //                       backgroundColor: theme.primaryColor,
                    //                     );
                    //                   },
                    //                   icon: Text(
                    //                     'G',
                    //                     style: theme.textTheme.titleMedium
                    //                         ?.copyWith(
                    //                       fontSize: 18,
                    //                       color: theme.colorScheme.error,
                    //                     ),
                    //                   ),
                    //                   label: Text(
                    //                     'Google',
                    //                     style: TextStyle(
                    //                       color: theme.colorScheme.error,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //       ),
                    //       const SizedBox(width: 20),
                    //       Expanded(
                    //         child: _isFaceBookLoading
                    //             ? Loading(
                    //                 width: 14,
                    //                 height: 14,
                    //                 message: Text(
                    //                   'Facebook Auth...',
                    //                   style: TextStyle(
                    //                     color: theme.primaryColor,
                    //                   ),
                    //                 ),
                    //               )
                    //             : Container(
                    //                 decoration: BoxDecoration(
                    //                   color:
                    //                       theme.primaryColor.withOpacity(0.4),
                    //                   borderRadius: BorderRadius.circular(30),
                    //                 ),
                    //                 child: TextButton.icon(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       _isFaceBookLoading = true;
                    //                     });
                    //                     showToast(
                    //                       message: const Text(
                    //                         "Available on next update",
                    //                       ),
                    //                       context: context,
                    //                       duration: const Duration(seconds: 9),
                    //                       backgroundColor: theme.primaryColor,
                    //                     );
                    //                   },
                    //                   icon: Icon(
                    //                     Icons.facebook,
                    //                     color: theme.colorScheme.error,
                    //                   ),
                    //                   label: Text(
                    //                     'Facebook',
                    //                     style: TextStyle(
                    //                       color: theme.colorScheme.error,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //       ),
                    //     ],
                    //   ),
                    // if (_authMode == AuthMode.signup && !keyboardShown)
                    //   Center(
                    //     child: GestureDetector(
                    //       onTap: () => launchExternalUrl(
                    //         context: context,
                    //         usedUrl: 'grecomRegisterUrl',
                    //       ),
                    //       child: RichText(
                    //         text: TextSpan(
                    //           children: [
                    //             TextSpan(
                    //               text: 'Ou ulitisez ',
                    //               style: theme.textTheme.labelSmall?.copyWith(
                    //                 fontSize: 14,
                    //                 color: Colors.grey,
                    //               ),
                    //             ),
                    //             TextSpan(
                    //               text: 'grecomRegisterUrl',
                    //               style: theme.textTheme.labelSmall?.copyWith(
                    //                 fontSize: 14,
                    //                 color: theme.primaryColor,
                    //                 decoration: TextDecoration.underline,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    if (!keyboardShown)
                      SizedBox(height: deviceSize.height * 0.02),
                    if (!keyboardShown)
                      Center(
                        child: GestureDetector(
                          onTap: () => _switchAuthMode(
                            mode: _authMode == AuthMode.login
                                ? AuthMode.signup
                                : AuthMode.login,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: _authMode == AuthMode.login
                                      ? 'Not a member ? '
                                      : 'Already a member ? ',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: _authMode == AuthMode.login
                                      ? 'Signup Now'
                                      : 'Login Now',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: 14,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
