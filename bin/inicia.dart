// main.dart
import 'dart:io';
import 'conf_game.dart';

void main() {
  print("""
    Bem-vindo ao Jogo dos Dados Mágicos!

    Regras:
    - Cada jogador lança três dados por rodada.
    - A soma dos valores dos dados é calculada para cada jogador.
    - Os jogadores têm a opção de usar um 'dado mágico' uma vez por rodada.
    - O 'dado mágico' pode reduzi-la pela metade(0) ou dobrar a soma total (1). 
    - O jogador com a maior soma vence a rodada.
    - O jogo continua por um número pré-determinado de rodadas.
    - O jogador com mais vitórias no final é o vencedor do jogo.

    Boa sorte e divirta-se!
  """);
  print("Digite seu nome: ");
  String? nome = stdin.readLineSync();

  while (true) {
    print("Olá $nome, quantas rodadas você vai jogar?");
    String? rodadas = stdin.readLineSync();
    if (rodadas != null) {
      try {
        int rodadasInt = int.parse(rodadas);
        GameConfig game = GameConfig('$nome');
        game.iniciarJogo(rodadasInt);
        break;
      } catch (e) {
        print("Por favor, insira um número válido.");
      }
    } else {
      print("Nenhuma entrada detectada.");
    }
  }
}
