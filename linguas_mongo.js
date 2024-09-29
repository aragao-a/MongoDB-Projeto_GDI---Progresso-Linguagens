
db = db.getSiblingDB("linguas");
db.estudantesLinguas.drop();
db.estudantesLinguas.insertMany([

    
    {
        "nome": "Caique Veeck",
        "email": "cvhq@cin.ufpe.br",
        "idade": 30,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Marie Dupont",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            },
            {
            "idioma": "Alemao",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Hans Muller",
            "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-06-25"
    },
    {
        "nome": "Claudino Neto",
        "email": "cesn2@cin.ufpe.br",
        "idade": 28,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Jacquin",
            "fases_concluidas": ["Fase 1", "Fase 2"]
            },
            {
            "idioma": "Ingles",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Tom Cruise",
            "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-05-18"
    },
    {
        "nome": "Vinicius Seabra",
        "email": "vsll@cin.ufpe.br",
        "idade": 27,
        "idiomas_aprendidos": [
            {
            "idioma": "Ingles",
            "nivel_fluencia": "Avancado",
            "professor": "Prof. Tom Cruise",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
            "idioma": "Espanhol",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Delgado Manny",
            "fases_concluidas": ["Fase 1", "Fase 2"]
            }
        ],
        "ultimo_acesso": "2024-07-12"
    },
    {
        "nome": "Gustavo Santiago",
        "email": "santiagod@cin.ufpe.br",
        "idade": 31,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Jacquin",
            "fases_concluidas": ["Fase 1"]
            },
            {
            "idioma": "Alemao",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Neuer",
            "fases_concluidas": ["Fase 1", "Fase 2"]
            }
        ],
        "ultimo_acesso": "2024-08-10"
    },
    {
        "nome": "Flavio Roberto",
        "email": "flavion@cin.ufpe.br",
        "idade": 29,
        "idiomas_aprendidos": [
            {
            "idioma": "Ingles",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Tom Cruise",
            "fases_concluidas": ["Fase 1", "Fase 2"]
            },
            {
            "idioma": "Espanhol",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Delgado Manny",
            "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-09-05"
    },
    {
        "nome": "Carlos Eduardo",
        "email": "carloseduardo@cin.ufpe.br",
        "idade": 33,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Avancado",
            "professor": "Prof. Jacquin",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        ],
        "ultimo_acesso": "2024-03-22"
    },
    {
        "nome": "Beatriz Almeida",
        "email": "bea.almeida@cin.ufpe.br",
        "idade": 24,
        "idiomas_aprendidos": [
            {
            "idioma": "Espanhol",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Delgado Manny",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            }
        ],
        "ultimo_acesso": "2024-04-18"
    },
    {
        "nome": "Helena Moura",
        "email": "helena.moura@cin.ufpe.br",
        "idade": 26,
        "idiomas_aprendidos": [
            {
            "idioma": "Ingles",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Tom Cruise",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            },
            {
            "idioma": "Alemao",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Neuer",
            "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-06-30"
    },
    {
        "nome": "Miguel Ribeiro",
        "email": "miguel.ribeiro@cin.ufpe.br",
        "idade": 29,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Jacquin",
            "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-02-15"
    },
    {
        "nome": "Luciana Souza",
        "email": "luciana.souza@cin.ufpe.br",
        "idade": 25,
        "idiomas_aprendidos": [
            {
            "idioma": "Espanhol",
            "nivel_fluencia": "Avancado",
            "professor": "Prof. Delgado Manny",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        ],
        "ultimo_acesso": "2024-09-15"
    },
    {
        "nome": "Renato Silva",
        "email": "renato.silva@cin.ufpe.br",
        "idade": 28,
        "idiomas_aprendidos": [
            {
            "idioma": "Alemao",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Neuer",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3"]
            }
        ],
        "ultimo_acesso": "2024-01-19"
    },
    {
        "nome": "Fernanda Carvalho",
        "email": "fernanda.carvalho@cin.ufpe.br",
        "idade": 31,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Intermediario",
            "professor": "Prof. Jacquin",
            "fases_concluidas": ["Fase 1", "Fase 2"]
            },
            {
            "idioma": "Ingles",
            "nivel_fluencia": "Iniciante",
            "professor": "Prof. Tom Cruise",
            "fases_concluidas": ["Fase 1"]
            }
        ],
        "ultimo_acesso": "2024-05-10"
    },
    {
        "nome": "Papa Francisco",
        "email": "franciscoides@vaticano.ufv.com",
        "idade": 98,
        "idiomas_aprendidos": [
            {
            "idioma": "Frances",
            "nivel_fluencia": "Avancado",
            "professor": "Igreja do Vaticano",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
            "idioma": "Ingles",
            "nivel_fluencia": "Avancado",
            "professor": "Igreja do Vaticano",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
            "idioma": "Portugues",
            "nivel_fluencia": "Avancado",
            "professor": "Igreja do Vaticano",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            },
            {
            "idioma": "Esperanto",
            "nivel_fluencia": "Avancado",
            "professor": "Igreja do Vaticano",
            "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        ],
        "ultimo_acesso": "1960-05-10"
        
    },

], {ordered: false});

db["estudantesLinguas"].find({ idiomas_aprendidos: { $size: 2 } })
