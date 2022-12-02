import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixolity/resources/auth_methods.dart';
import 'package:pixolity/responsive/mobile_screen_layout.dart';
import 'package:pixolity/responsive/responsive_layout_screen.dart';
import 'package:pixolity/responsive/web_screen_layout.dart';
import 'package:pixolity/screens/login_screen.dart';
import 'package:pixolity/utils/colors.dart';
import 'package:pixolity/utils/utils.dart';
import 'package:pixolity/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void seletImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      
        
      
      
      
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              //svg image
              /*SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 45,
              ),*/
              Flexible(
                flex: 2,
                child: const Scaffold(),
              ),
              Container(
              child: Column(
                children: [
                  const Text("Let's start the journey of photography", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold,),),
                ],
              ), 
              ),
              const Text('Pixolity',style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold,),),

              const SizedBox(
                height: 8,
              ),
              //circular widget to accecpt and show our selected file
              //we are using stack so that one widget can come over other widget
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 45,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                              "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg"),
                        ),
                  Positioned(
                    bottom: -18,
                    left: 54,
                    child: IconButton(
                      onPressed: seletImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(
                height: 3,
              ),
              // text field for username
              TextFieldInput(
                hintText: 'Enter your Username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 10,
              ),
              // text field for email
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              //text Input for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              //bio text field
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 10,
              ),
              //button login
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                flex: 2,
                child: const Scaffold(),
              ),
              //Tansitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1
                    ),
                    child: const Text("allready have an account?"),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
