//MuriloApplicationCopyright
import 'package:flutter/material.dart';

void main() => runApp(AppJogoNim());

class AppJogoNim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo NIM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: TelaJogoNim(),
    );
  }
}

class TelaJogoNim extends StatefulWidget {
  @override
  _TelaJogoNimState createState() => _TelaJogoNimState();
}

class _TelaJogoNimState extends State<TelaJogoNim> {
  String nomeJogador = "Murilo Martins Alves";
  String raJogador = "1431432312004";
  int totalPalitos = 0;
  int maximoPalitosRemover = 0;
  int palitosRestantes = 0;
  bool turnoJogador = true;
  String mensagem = "";
  List<int> palitosRemovidosPeloJogador = [];
  List<String> historicoMovimentos = [];
  int palitosRemoverPeloUsuario = 0;

  TextEditingController controladorTotalPalitos = TextEditingController();
  TextEditingController controladorMaximoPalitosRemover =
      TextEditingController();

  void iniciarJogo() {
    if (totalPalitos >= 2 && maximoPalitosRemover >= 1) {
      palitosRestantes = totalPalitos;
      historicoMovimentos.clear();

      if (palitosRestantes % (maximoPalitosRemover + 1) == 0) {
        turnoJogador = true;
        mensagem = "Você começa!";
      } else {
        turnoJogador = false;
        mensagem = "Computador começa!";
        int palitosIniciais = palitosRestantes;
        int palitosARemover = 1;

        while (
            (palitosIniciais - palitosARemover) % (maximoPalitosRemover + 1) !=
                0) {
          palitosARemover++;
        }

        palitosRestantes -= palitosARemover;
        historicoMovimentos
            .add('Computador removeu $palitosARemover palito(s).');
        mensagem = "Computador removeu $palitosARemover palito(s).";

        if (palitosRestantes == 0) {
          mensagem = "Fim do Jogo: Computador Venceu!";
          historicoMovimentos.add(mensagem);
        }

        turnoJogador = true;
      }
    } else {
      mensagem = "Preencha todos os campos corretamente.";
    }
    setState(() {});
  }

  void reiniciarJogo() {
    controladorTotalPalitos.clear();
    controladorMaximoPalitosRemover.clear();
    iniciarJogo();
  }

  void removerPalitos(int quantidade) {
    if (palitosRestantes <= 0) {
      return;
    }

    if (quantidade >= 1 &&
        quantidade <= maximoPalitosRemover &&
        quantidade <= palitosRestantes) {
      palitosRemovidosPeloJogador.add(quantidade);
      palitosRestantes -= quantidade;
      historicoMovimentos.add('$nomeJogador removeu $quantidade palito(s).');

      if (palitosRestantes <= 0) {
        if (turnoJogador) {
          mensagem = "Fim do Jogo: Você Perdeu!";
        } else {
          mensagem = "Fim do Jogo: Computador Venceu!";
        }
        historicoMovimentos.add(mensagem);
      } else {
        turnoJogador = !turnoJogador;
        if (!turnoJogador) {
          int palitosIniciais = palitosRestantes;
          int palitosARemover = 1;

          while ((palitosIniciais - palitosARemover) %
                  (maximoPalitosRemover + 1) !=
              0) {
            palitosARemover++;
          }

          palitosRestantes -= palitosARemover;
          historicoMovimentos
              .add('Computador removeu $palitosARemover palito(s).');
          mensagem = "O computador removeu $palitosARemover palito(s).";

          if (palitosRestantes == 0) {
            mensagem = "Fim do Jogo: Computador Venceu!";
            historicoMovimentos.add(mensagem);
          }

          turnoJogador = true;
        }
      }
    } else {
      mensagem = "Escolha uma quantidade válida de palitos.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('${nomeJogador}'),
              accountEmail: Text('RA: ${raJogador}'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/80017589?v=4',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1620121692029-d088224ddc74?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Jogo NIM'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            TextField(
              controller: controladorTotalPalitos,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Quantidade de Palitos Total'),
              onChanged: (value) {
                totalPalitos = int.tryParse(value) ?? 0;
              },
            ),
            TextField(
              controller: controladorMaximoPalitosRemover,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Máx. de Palitos a Retirar'),
                  
              onChanged: (value) {
                maximoPalitosRemover = int.tryParse(value) ?? 0;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: iniciarJogo,
              style: ElevatedButton.styleFrom(
              primary: Colors.purple, 
              minimumSize: Size(double.infinity, 55.0), 
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0), 
    ),
  ),
  child: Text(
    'Iniciar Jogo',
    style: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  ),

            ),
            SizedBox(height: 20.0),
            Text(
              'Palitos Restantes: $palitosRestantes',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Mensagem: $mensagem',
              style: TextStyle(fontSize: 20.0),
            ),
            if (mensagem.contains("Fim do Jogo"))
              ElevatedButton(
                onPressed: reiniciarJogo,
                child: Text('Reiniciar Jogo'),
              ),
            SizedBox(height: 20.0),
            Text(
              'Jogadas:',
              style: TextStyle(fontSize: 20.0),
            ),
            for (var movimento in historicoMovimentos)
              Text(
                movimento,
                style: TextStyle(fontSize: 16.0),
              ),
            SizedBox(height: 20.0),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade de Palitos a Retirar',
                
              ),
              onChanged: (value) {
                int quantidadeInput = int.tryParse(value) ?? 0;
                if (quantidadeInput >= 1 &&
                    quantidadeInput <= maximoPalitosRemover &&
                    quantidadeInput <= palitosRestantes) {
                  palitosRemoverPeloUsuario = quantidadeInput;
                } else {
                  palitosRemoverPeloUsuario = 0;
                }
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (palitosRemoverPeloUsuario > 0) {
                  removerPalitos(palitosRemoverPeloUsuario);
                } else {
                  mensagem = "Escolha uma quantidade válida de palitos.";
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
              primary: Colors.purple, 
              minimumSize: Size(double.infinity, 55.0), 
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0), 
    ),
  ),
  child: Text(
    'Retirar palitos',
    style: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  ),

            ),
    
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}