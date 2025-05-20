import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helpers.dart';
import '../models/models.dart';

class Auth with ChangeNotifier {
  AuthUser? user;

  String? _token;
  bool appInitialized = false;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    if (IS_PRODUCTION) {
      try {
        final response = await http.post(
          Uri.parse(loginURL),
          headers: {'Accept': 'application/json'},
          body: {
            'username': email,
            'password': password,
          },
        );
        switch (response.statusCode) {
          case 200:
            _token = jsonDecode(response.body)['data']['token'];
            final prefs = await SharedPreferences.getInstance();
            final authData = json.encode({'token': _token});
            prefs.setString('authData', authData);
            break;
          case 422:
            final errors = jsonDecode(response.body)['errors'];
            throw (errors[errors.keys.elementAt(0)][0]);
          case 403:
            throw (jsonDecode(response.body)['message']);
          case 400:
            throw ("Wrong phone number or password");
          default:
            throw (somethingWentWrong);
        }
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      await Future.delayed(const Duration(seconds: 3), () async {
        user = AuthUser(
          id: '0',
          name: 'Omar King',
          createdAt: '',
          email: email,
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        );
        _token = user?.token;
        final prefs = await SharedPreferences.getInstance();
        final authData = json.encode({'token': _token});
        prefs.setString('authData', authData);
        print('===================LOGGED');
        return;
      });
    }
  }

  Future<void> forgotPassword(String phone) async {
    if (IS_PRODUCTION) {
      try {
        final response = await http.post(
          Uri.parse(forgotPasswordURL),
          headers: {'Accept': 'application/json'},
          body: {'phone': phone},
        );
        switch (response.statusCode) {
          case 200:
            break;
          case 422:
            final errors = jsonDecode(response.body)['errors'];
            throw (errors[errors.keys.elementAt(0)][0]);
          case 403:
            throw (jsonDecode(response.body)['message']);
          case 400:
            throw (jsonDecode(response.body)['message']);
          default:
            throw (somethingWentWrong);
        }
        // notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () async {
        user = AuthUser(
          id: '0',
          name: 'Omar King',
          createdAt: '',
          email: 'email',
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        );
        _token = user?.token;
        final prefs = await SharedPreferences.getInstance();
        final authData = json.encode({'token': _token});
        prefs.setString('authData', authData);
      });
    }
  }

  Future<void> register(String userName, String phone) async {
    if (IS_PRODUCTION) {
      try {
        final response = await http.post(
          Uri.parse(registerURL),
          headers: {'Accept': 'application/json'},
          body: {
            'name': userName,
            "phone": phone,
            'roleId': "0ef1f45e-921b-4aa3-93d6-597215a2af57", // Role Client ID
          },
        );
        switch (response.statusCode) {
          case 200:
            print("✅ Resister success");
            break;
          case 422:
            final errors = jsonDecode(response.body)['errors'];
            throw (jsonDecode(response.body)['message']);
          case 403:
            throw (jsonDecode(response.body)['message']);
          case 409:
            throw (jsonDecode(response.body)['message']);
          default:
            throw (somethingWentWrong);
        }
        // notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () async {
        user = AuthUser(
          id: '0',
          name: userName,
          createdAt: '',
          email: 'mlysiasnathan@gmail.com',
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        );
        _token = user?.token;
        final prefs = await SharedPreferences.getInstance();
        final authData = json.encode({'token': _token});
        prefs.setString('authData', authData);
      });
    }
  }

  Future<void> validateOtp(String otp, String phone) async {
    if (IS_PRODUCTION) {
      try {
        final response = await http.post(
          Uri.parse(verifyOtpURL),
          headers: {'Accept': 'application/json'},
          body: {
            'code_val': otp,
            'phone': phone,
          },
        );
        switch (response.statusCode) {
          case 200:
            print("✅ Verify success");
            break;
          case 422:
            final errors = jsonDecode(response.body)['errors'];
            throw (jsonDecode(response.body)['message']);
          case 403:
            throw (jsonDecode(response.body)['message']);
          case 409:
            print(jsonDecode(response.body));
            throw (jsonDecode(response.body)['message']);
          default:
            throw (somethingWentWrong);
        }
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () async {
        user = AuthUser(
          id: '0',
          name: 'Omar King',
          createdAt: '',
          email: 'mlysiasnathan@gmail.com',
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        );
        _token = user?.token;
        final prefs = await SharedPreferences.getInstance();
        final authData = json.encode({'token': _token});
        prefs.setString('authData', authData);
      });
    }
  }

  Future<void> getUserDetail() async {
    if (IS_PRODUCTION) {
      if (user == null) {
        try {
          final response = await http.get(
            Uri.parse(userURL),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $_token',
            },
          );
          switch (response.statusCode) {
            case 200:
              user = AuthUser.fromJson(jsonDecode(response.body)['data']);
              break;
            case 401:
              logout();
              throw (unauthorized);
            default:
              throw (somethingWentWrong);
          }
        } catch (error) {
          rethrow;
        }
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () async {
        user = AuthUser(
          id: '0',
          name: 'Omar King',
          createdAt: '',
          email: 'mlysiasnathan@gmail.com',
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        );
        _token = user?.token;
        final prefs = await SharedPreferences.getInstance();
        final authData = json.encode({'token': _token});
        prefs.setString('authData', authData);
      });
    }
  }

  Future<void> updateProfile({
    String? name,
    String? lastname,
    String? middlename,
    String? email,
    String? address,
    String? phone,
    String? id_ward,
    String? avatar,
    String? gender,
    String? userType,
    String? categoryId,
    String? civil_status,
    String? date_of_birth,
    String? place_of_birth,
    String? default_password,
    String? id_partner,
    String? id_produit,
  }) async {
    if (IS_PRODUCTION) {
      try {
        final response = await http.put(
          Uri.parse('$baseURL/partners/app/members/${user?.id}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token',
          },
          body: {
            "name": name.toString(),
            "lastname": lastname.toString(),
            "middlename": middlename.toString(),
            "email": email.toString(),
            "address": address.toString(),
            "id_ward": id_ward.toString(),
            "avatar": avatar.toString(),
            "gender": gender.toString(),
            "UserRoleId": categoryId.toString(),
            "civil_status": civil_status.toString(),
            "date_of_birth": date_of_birth.toString(),
            "place_of_birth": place_of_birth.toString(),
            "default_password": default_password.toString(),
            "id_partner": id_partner.toString(),
            "id_produit": id_produit.toString(),
            "UserType": userType.toString(),
          },
        );
        // print('=======================ANALYSIS=========================');
        switch (response.statusCode) {
          case 200:
            user = null;
            await getUserDetail();
            break;
          case 401:
            throw (unauthorized);
          default:
            throw (jsonDecode(response.body)['message']);
        }
        // notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => user = AuthUser(
          id: '0',
          name: 'Omar King',
          createdAt: '',
          email: 'mlysiasnathan@gmail.com',
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        ),
      );
    }
  }

  Future<List<String>> uploadFiles(List<File> files) async {
    List<String> uploadedUrls = [];
    for (File file in files) {
      if (file.lengthSync() > 5 * 1024 * 1024) {
        print("Le fichier ${file.path} ne doit pas dépasser 5 Mo.");
        continue;
      }
      var request = http.MultipartRequest('POST', Uri.parse("$baseURL/file"));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $_token',
      });
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var jsonData = json.decode(responseData);
          if (jsonData['data']['name'] != null) {
            uploadedUrls.add('${jsonData['data']['name']}');
          }
          print("Fichier téléchargé avec succès");
        } else {
          print("Erreur lors de l'upload : ${response.reasonPhrase}");
          throw ("Erreur lors de l'upload : ${response.reasonPhrase}");
        }
      } catch (e) {
        print("Erreur lors de l'upload : $e");
        throw ("Erreur lors de l'upload : $e");
      }
    }
    return uploadedUrls;
  }

  Future<bool> tryAutologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authData')) {
      return false;
    }
    final extractedUserData = json
        .decode(prefs.getString('authData').toString()) as Map<String, dynamic>;
    _token = extractedUserData['token'].toString();
    notifyListeners();
    return true;
  }

  Future<void> updateUserProfile(
      String userName, String email, String password, File image) async {
    if (IS_PRODUCTION) {
      try {
        var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
        var length = await image.length();
        Map<String, String> headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
          'Content-Type': 'multipart/form-data',
        };
        final uri = Uri.parse(userURL);
        var request = http.MultipartRequest('POST', uri);
        var multipartFileSign = http.MultipartFile('profil_img', stream, length,
            filename: image.path);
        request.headers.addAll(headers);
        request.fields['username_update'] = userName;
        request.fields['email_update'] = email;
        request.fields['password_update'] = password;
        request.fields['password_confirmation_update'] = password;
        request.files.add(multipartFileSign);
        final response = await request.send();
        final res = await http.Response.fromStream(response);
        switch (response.statusCode) {
          case 200:
            user = AuthUser.fromJson(jsonDecode(res.body));
            final message = jsonDecode(res.body)['message'];
            break;
          case 401:
            throw (unauthorized);
          default:
            throw (somethingWentWrong);
        }
      } catch (error) {
        rethrow;
      }
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => user = AuthUser(
          id: '0',
          name: 'Omar King',
          createdAt: '',
          email: 'mlysiasnathan@gmail.com',
          image: 'assets/images/dev/users/4.jpg',
          token: 'jkjdka',
        ),
      );
    }
  }

  Future<void> logout() async {
    _token = null;
    user = null;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('authData');
    // await pref.clear();
    notifyListeners();
  }

  Future<void> initOnBoardingPage() async {
    appInitialized = true;
    final prefs = await SharedPreferences.getInstance();
    // prefs.setBool('isInit', appInitialized);
    notifyListeners();
  }

  Future<bool> showOnBoardingPage() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isInit')) {
      return false;
    }
    appInitialized = prefs.getBool('isInit') ?? false;
    // notifyListeners();
    return appInitialized;
  }
}
