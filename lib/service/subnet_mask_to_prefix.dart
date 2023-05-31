int subnetMaskToPrefix({required String mask}) {
  List<String> octets = [];

  // Verifica se a sequência de dígitos possui 12 caracteres
  if (mask.length != 12) {
    throw ArgumentError('Sequência de dígitos inválida');
  }

  // Separa os dígitos em grupos de 3
  for (int i = 0; i < mask.length; i += 3) {
    String group = mask.substring(i, i + 3);
    octets.add(group);
  }

  // Verifica se a máscara possui 4 octetos
  if (octets.length != 4) {
    throw ArgumentError('Máscara de rede inválida');
  }

  // Inicializa o valor do prefixo
  int prefix = 0;

  // Percorre os octetos e conta os bits 1
  for (int i = 0; i < octets.length; i++) {
    int octetValue = int.parse(octets[i]);

    // Verifica se o octeto está dentro do intervalo válido
    if (octetValue < 0 || octetValue > 255) {
      throw ArgumentError('Máscara de rede inválida');
    }

    // Converte o octeto para binário
    String binary = octetValue.toRadixString(2);

    // Conta os bits 1 no octeto
    int bitCount = binary.split('1').length - 1;

    // Incrementa o valor do prefixo
    prefix += bitCount;
  }

  return prefix;
}

String prefixToSubnetMask({required int prefix}) {
  if (prefix < 0 || prefix > 32) {
    throw ArgumentError('Prefixo inválido');
  }

  List<int> maskOctets = [0, 0, 0, 0];

  int fullOctets = prefix ~/ 8;

  for (int i = 0; i < fullOctets; i++) {
    maskOctets[i] = 255;
  }

  int remainingBits = prefix % 8;

  int lastOctetValue = 0;
  for (int i = 7; i >= 8 - remainingBits; i--) {
    lastOctetValue += (1 << i);
  }
  maskOctets[fullOctets] = lastOctetValue;

  String mask = maskOctets.join('.');

  return mask;
}
