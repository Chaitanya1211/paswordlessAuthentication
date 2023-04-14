import 'dart:math';

import 'package:app/helper/sharedPrefs.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
// import 'package:pointycastle/api.dart' as crypto;

import 'package:pointycastle/pointycastle.dart';
import 'dart:typed_data';

class Keys {
  SharedPrefs shared = SharedPrefs();
  late String privateKey;
  late String publicKey;
//Future to hold our KeyPair
  List<String> generateRSAKeyPair(int bitLength) {
    // Create a random secure seed
    final secureRandom = FortunaRandom();
    final seedSource = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    // Generate RSA key pair
    final keyGenParams = RSAKeyGeneratorParameters(
      BigInt.from(65537),
      bitLength,
      12,
    );
    final keyGenerator = RSAKeyGenerator();
    keyGenerator.init(ParametersWithRandom(keyGenParams, secureRandom));
    final keyPair = keyGenerator.generateKeyPair();
    publicKey = RsaKeyHelper()
        .encodePublicKeyToPemPKCS1(keyPair.publicKey as RSAPublicKey);
    privateKey = RsaKeyHelper()
        .encodePrivateKeyToPemPKCS1(keyPair.privateKey as RSAPrivateKey);
    // print("Public Key :" + publicKey);
    // print("Private key :" + privateKey);
    return [publicKey, privateKey];
  }

  Future<dynamic> decryptSecret(String secret) async {
    String private = await shared.getPrivateKey();
    String public = await shared.getPublicKey();
    RSAPrivateKey priv = RsaKeyHelper().parsePrivateKeyFromPem(private);
    print("Public key : $public");
    print("Private key : $private");

    var decrypted = decrypt(
        "WcbMd0wq9kRDCgPxgmJl3hOkYSkLAIWXUQQLaeNzwstpxPEy2YRXUGraALlpNTFIzRBYiQQGgs/Lpee+OqxDuw9ktVPNqWmUQosnpqQ0KjLHh+va9+oFZIbQlFb7m9CyQpsaKCZ1DC//GPh5t0WWvhDesfRZKAIE9fYRcj8dmNdvDuCMFXSEqJmjQMSzS/xfnshw9YDISHRP878OZNRRsKptk7eAQA/ciQxC/9rBQ1Xn+X2lKsPZcEAIr3Wky/cVDlw/2EPSzvZkCi8OtWomz8W8fssG1hjjaJVmdlZth6DVqcgzVUzEcETuxlj1ZsC33Dg0+DEp7/7PKefCu1h8fg==",
        priv);
    return public;
  }
}
