import 'dart:convert';
import 'dart:math';

import 'package:app/helper/sharedPrefs.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
// import 'package:pointycastle/api.dart' as crypto;
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/pointycastle.dart';
import 'dart:typed_data';

class Keys {
  SharedPrefs shared = SharedPrefs();
  late String privateKey;
  late String publicKey;
//Future to hold our KeyPair
  encryptData(String username) async {
    var plainText = username;
    var helper = RsaKeyHelper();
    var publicKey = await shared.getPublicKey();
    // RSAPrivateKey private_converted = helper.parsePrivateKeyFromPem(privateKey);
    RSAPublicKey publicKeyConverted = helper.parsePublicKeyFromPem(publicKey);

    var encryptedText = encrypt(plainText, publicKeyConverted);
    // var decryptedText = decrypt(encryptedText, private_converted);
    var base64Encoded = base64Encode(encryptedText.codeUnits);
    print(" Encrypted :" + base64Encoded);
    return base64Encoded;
    // print(" Decrypted :" + decryptedText);
  }
}
