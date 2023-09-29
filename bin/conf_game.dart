// conf_game.dart
import 'dart:math';
import 'dart:io';

class GameConfig {
  final Random random = Random();
  late int rodadasInt;
  late String nome;
  int vitoriaJogUm = 0;
  int vitoriaJogDois = 0;
  int empate = 0;

  GameConfig(this.nome);

  void iniciarJogo(int rodadas) {
    rodadasInt = rodadas;
    print("Você escolheu jogar $rodadasInt rodadas!");
    print("Prepare-se! Vamos começar em 3...2...1...");
    print("Começou!");

    for (int i = 0; i < rodadasInt; i++) {
      jogarRodada(i);
      print("*********************************************************\n");
    }
    // Exibição do placar final
    exibirPlacarFinal();
  }

  void jogarRodada(int rodada) {
    // Lançamento dos dados para o Jogador UM
    List<double> resultadosJogUm = lancarDados();
    double somaJogUm = resultadosJogUm.reduce((a, b) => a + b);

    // Lançamento dos dados para o Jogador Dois (Máquina)
    List<double> resultadosJogDois = lancarDados();
    double somaJogDois = resultadosJogDois.reduce((a, b) => a + b);

    // Exibição dos resultados dos lançamentos para o Jogador UM
    exibirResultadoJogador(nome, resultadosJogUm, somaJogUm);

    // Exibição dos resultados dos lançamentos para a Máquina
    exibirResultadoJogador("Maquina", resultadosJogDois, somaJogDois);

    // Decisão do usuário sobre o uso do dado mágico
    bool usuarioUsaDadoMagico = decidirUsarDadoMagico();
    if (usuarioUsaDadoMagico) {
      aplicarDadoMagico(nome, resultadosJogUm);
    }

    // Decisão automática da Máquina sobre o uso do dado mágico
    bool maquinaUsaDadoMagico = random.nextBool();
    if (maquinaUsaDadoMagico) {
      aplicarDadoMagico("Maquina", resultadosJogDois);
    }

    // Determinação do vencedor da rodada
    determinarVencedor(somaJogUm, somaJogDois);

    // Atualização do placar
    exibirPlacarParcial();

    // Aguardar um momento antes de continuar para a próxima rodada
    sleep(Duration(seconds: 2));
  }

  List<double> lancarDados() {
    List<double> resultados = [];
    for (int i = 0; i < 3; i++) {
      double resultadoDado = random.nextInt(6).toDouble() + 1; // Adiciona 1 para gerar valores de 1 a 6
      resultados.add(resultadoDado);
    }
    return resultados;
  }

  void exibirResultadoJogador(String jogador, List<double> resultados, double soma) {
    print(" -- Resultados para $jogador --");
    print("Jogando dado 1...");
    sleep(Duration(seconds: 1));
    print("${resultados[0]}");
    print("Jogando dado 2...");
    sleep(Duration(seconds: 1));
    print("${resultados[1]}");
    print("Jogando dado 3...");
    sleep(Duration(seconds: 1));
    print("${resultados[2]}");
    print("Soma = $soma\n");
  }

  bool decidirUsarDadoMagico() {
    bool dadoMagicoValida = false;
    while (!dadoMagicoValida) {
      print("Usar dado mágico? S - (Sim) N - (Não)");
      String? resdadoMagico = stdin.readLineSync();
      if (resdadoMagico == 'S' || resdadoMagico == 's') {
        dadoMagicoValida = true;
        return true;
      } else if (resdadoMagico == 'N' || resdadoMagico == 'n') {
        dadoMagicoValida = true;
        return false;
      } else {
        print("Digite uma opção válida!");
      }
    }
    return false; // Apenas para retorno, pois não deve chegar nessa linha!!
  }

  void aplicarDadoMagico(String jogador, List<double> resultados) {
    int dadoMagico = random.nextInt(2);
    print("$jogador escolheu usar o Dado Mágico!");
    print("Sorteando...");
    sleep(Duration(seconds: 1));
    print("Dado Mágico: $dadoMagico");

    if (dadoMagico == 0) {
      for (int i = 0; i < resultados.length; i++) {
        resultados[i] /= 2;
      }
      print(":( Resultados divididos pela metade");
    } else {
      for (int i = 0; i < resultados.length; i++) {
        resultados[i] *= 2;
      }
      print(":D Resultados foram dobrados!");
    }
  }

  void exibirPlacarParcial() {
    print("Placar parcial:");
    print("$nome: $vitoriaJogUm vitórias");
    print("Maquina: $vitoriaJogDois vitórias");
    print("Empates: $empate");
  }

  void determinarVencedor(double somaJogUm, double somaJogDois) {
    if (somaJogUm > somaJogDois) {
      print("Vencedor: $nome, de $somaJogUm x $somaJogDois");
      vitoriaJogUm++;
    } else if (somaJogUm == somaJogDois) {
      print("Empate! $somaJogUm a $somaJogDois");
      empate++;
    } else {
      print("Vencedor: Maquina, de $somaJogDois x $somaJogUm");
      vitoriaJogDois++;
    }
  }

  void exibirPlacarFinal() {
    print("-- Placar Final --");
    print("$nome: $vitoriaJogUm vitórias");
    print("Maquina: $vitoriaJogDois vitórias");
    print("Empates: $empate");

    if (vitoriaJogUm > vitoriaJogDois) {
      print("Vencedor final: $nome");
    } else if (vitoriaJogDois > vitoriaJogUm) {
      print("Vencedor final: Maquina");
    } else {
      print("Empate!");
    }
  }
}
