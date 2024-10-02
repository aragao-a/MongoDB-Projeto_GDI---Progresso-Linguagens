db = db.getSiblingDB("linguas");
db.estudantesLinguas.drop();
db.turmas.drop();

db.turmas.insertMany([
    {
        codigo : "AL01",
        idioma : "Alemao",
        professor : "Prof. Neuer",
        quantidade_alunos : 3
    },
    {
        codigo : "AL02",
        idioma : "Alemao",
        professor : "Prof. Hans Muller",
        quantidade_alunos : 1
    },
    {
        codigo : "FR01",
        idioma : "Frances",
        professor : "Igreja do Vaticano",
        quantidade_alunos : 1
    },
    {
        codigo : "FR02",
        idioma : "Frances",
        professor : "Prof. Marie Dupont",
        quantidade_alunos : 1
    },
    {
        codigo: "FR03",
        idioma : "Frances",
        professor : "Prof. Jacquin",
        quantidade_alunos : 5
    },
    {
        codigo : "EN01",
        idioma : "Ingles",
        professor : "Igreja do Vaticano"
    },
    {
        codigo: "EN02",
        idioma : "Ingles",
        professor : "Prof. Tom Cruise",
        quantidade_alunos : 5
    },
    {
        codigo: "EN03",
        idioma : "Ingles",
        professor : "Prof. Simone Barros",
        quantidade_alunos : 1
    },
    {    
        codigo: "ES01",
        idioma : "Espanhol",
        professor : "Prof. Delgado Manny",
        quantidade_alunos : 5
    },
    {
        codigo: "IT01",
        idioma : "Italiano",
        professor : "Prof. Rodrigo Borgia",
        quantidade_alunos : 1
    },
    {
        codigo : "ER01",
        idioma : "Esperanto",
        professor : "Igreja do Vaticano",
        quantidade_alunos : 1
    },
    {
        codigo : "PT01",
        idioma : "Portugues",
        professor : "Igreja do Vaticano",
        quantidade_alunos : 1
    }
]);

db.estudantesLinguas.insertMany([

    {
        "nome": "Caique Veeck",
        "email": "cvhq@cin.ufpe.br",
        "idade": 30,
        "turmas": [
            {
                "codigo": "FR02",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            },
            {
                "codigo": "AL02",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-06-25"
    },
    {
        "nome": "Claudino Neto",
        "email": "cesn2@cin.ufpe.br",
        "idade": 28,
        "turmas": [
            {
                "codigo": "FR03",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2"]
            },
            {
                "codigo": "EN02",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-05-18"
    },
    {
        "nome": "Vinicius Seabra",
        "email": "vsll@cin.ufpe.br",
        "idade": 27,
        "turmas": [
            {
                "codigo": "EN02",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
                "codigo": "ES01",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2"]
            }
        ],
        "ultimo_acesso": "2024-07-12"
    },
    {
        "nome": "Gustavo Santiago",
        "email": "santiagod@cin.ufpe.br",
        "idade": 31,
        "turmas": [
            {
                "codigo": "FR03",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            },
            {
                "codigo": "AL01",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2"]
            }
        ],
        "ultimo_acesso": "2024-08-10"
    },
    {
        "nome": "Flavio Roberto",
        "email": "flavion@cin.ufpe.br",
        "idade": 29,
        "turmas": [
            {
                "codigo": "EN02",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2"]
            },
            {
                "codigo": "ES01",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-09-05"
    },
    {
        "nome": "Carlos Eduardo",
        "email": "carloseduardo@cin.ufpe.br",
        "idade": 33,
        "turmas": [
            {
                "codigo": "FR03",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        ],
        "ultimo_acesso": "2024-03-22"
    },
    {
        "nome": "Beatriz Almeida",
        "email": "bea.almeida@cin.ufpe.br",
        "idade": 24,
        "turmas": [
            {
                "codigo": "ES01",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            }
        ],
        "ultimo_acesso": "2024-04-18"
    },
    {
        "nome": "Helena Moura",
        "email": "helena.moura@cin.ufpe.br",
        "idade": 26,
        "turmas": [
            {
                "codigo": "EN02",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            },
            {
                "codigo": "AL01",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-06-30"
    },
    {
        "nome": "Miguel Ribeiro",
        "email": "miguel.ribeiro@cin.ufpe.br",
        "idade": 29,
        "turmas": [
            {
                "codigo": "FR03",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-02-15"
    },
    {
        "nome": "Luciana Souza",
        "email": "luciana.souza@cin.ufpe.br",
        "idade": 25,
        "turmas": [
            {
                "codigo": "ES01",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        ],
        "ultimo_acesso": "2024-09-15"
    },
    {
        "nome": "Renato Silva",
        "email": "renato.silva@cin.ufpe.br",
        "idade": 28,
        "turmas": [
            {
                "codigo": "AL01",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            }
        ],
        "ultimo_acesso": "2024-01-19"
    },
    {
        "nome": "Fernanda Carvalho",
        "email": "fernanda.carvalho@cin.ufpe.br",
        "idade": 31,
        "turmas": [
            {
                "codigo": "FR03",
                "nivel_fluencia": "Intermediario",
                "fases_concluidas": ["Fase 1", "Fase 2"]
            },
            {
                "codigo": "EN02",
                "nivel_fluencia": "Iniciante",
                "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-05-10"
    },
    {
        "nome": "Papa Francisco",
        "email": "franciscoides@vaticano.ufv.com",
        "idade": 98,
        "turmas": [
            {
                "codigo": "FR01",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
                "codigo": "EN01",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
                "codigo": "PT01",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
                "codigo": "ER01",
                "nivel_fluencia": "Avancado",
                "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        ],
        "ultimo_acesso": "1960-05-10"
    },
    {
        "nome": "Ariston Aragao",
        "email": "aaa10@cin.ufpe.br",
        "idade": 32,
        "turmas": [
          {
            "codigo": "EN03",
            "nivel_fluencia": "Avancado",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
          },
          {
            "codigo": "ES01",
            "nivel_fluencia": "Intermediario",
            "fases_concluidas": ["Fase 1"]
          }
        ],
        "ultimo_acesso": "2024-04-26"
      }

], {ordered: false});
