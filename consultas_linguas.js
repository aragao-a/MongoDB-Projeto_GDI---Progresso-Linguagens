
// Consulta USE (retirar "//")
// use linguas

// Consulta COUNT DOCUMENTS

db["estudantesLinguas"].countDocuments({"idiomas_aprendidos.idioma": "Ingles"});


// Consulta INSERT_ONE

db["estudantesLinguas"].insertOne({

    "nome": "Ariston Aragao",
    "email": "aaa10@cin.ufpe.br",
    "idade": 32,
    "idiomas_aprendidos": [
        {
        "idioma": "Ingles",
        "nivel_fluencia": "Avancado",
        "professor": "Prof. Simone Barros",
        "fases_concluidas": ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
        },
        {
        "idioma": "Espanhol",
        "nivel_fluencia": "Intermediario",
        "professor": "Prof. Delgado Manny",
        "fases_concluidas": ["Fase 1"]
        }
    ],
    "ultimo_acesso": "2024-04-26"
})

// Consulta UPDATEONE

db["estudantesLinguas"].updateOne(

    { nome: "Papa Francisco" },
    { $addToSet: 
        
        { idiomas_aprendidos: 
            
            { idioma: "Italiano", 
            nivel_fluencia: "Avancado", 
            professor: "Prof. Rodrigo Borgia", 
            fases_concluidas: ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            } 
        } 
    }
)

// Consulta FIND_ONE e SIZE

db["estudantesLinguas"].findOne({ idiomas_aprendidos: { $size: 5 } })

// Consulta AGGREGATE, MATCH, GROUP, SORT - Todos os alunos maiores de 30 anos e quantos aprendem cada língua

db["estudantesLinguas"].aggregate([
    { $match: { idade: { $gte: 31 } } }, 
    { $unwind: "$idiomas_aprendidos" }, // Desmonta o array de idiomas
    { $group: { _id: "$idiomas_aprendidos.idioma", total: { $sum: 1 } } }, // Agrupa por idioma e conta
    { $sort: { total: 1 } } // Ordenação crescente
]);
  
// Consulta $PROJECT

db["estudantesLinguas"].aggregate([
    { 
        $project: { 
            nome: 1,  
            email: 1, 
            idade: 1,
            _id: 0    
        }
    }
]);

// Consulta MAX e AVG

db["estudantesLinguas"].aggregate([
    { $group: { _id: null, Aluno_mais_Velho: { $max: "$idade" } } }
]);

db["estudantesLinguas"].aggregate([
    { $group: { _id: null, media_de_Idade: { $avg: "$idade" } } }
]);

// Consulta FIND, EXISTS e LIMIT

db["estudantesLinguas"].find({ "idiomas_aprendidos.idioma": { $exists: true, $eq: "Espanhol" } }).limit(3);

// Consulta WHERE e PRETTY

db["estudantesLinguas"].find({ $where: "this.nome.startsWith('P')" }).pretty();

// Consulta FUNCTION

function alunosIngles() {
    return db["estudantesLinguas"].find({
      idade: { $gt: 30 },
      "idiomas_aprendidos.idioma": "Ingles"
    }).pretty();
  }
  
alunosIngles();

// Consulta ALL

db["estudantesLinguas"].find({
  "idiomas_aprendidos.fases_concluidas": { $all: ["Fase 1", "Fase 2", "Fase 3", "Fase 4"] }
}).pretty();

// Consulta UPDATE_MANY e ADD_TO_SET - Avança todos os alunos de espanhol para a fase 2 (Quem não já for, nesse caso só Flávio)

db["estudantesLinguas"].updateMany(
    { "idiomas_aprendidos.idioma": "Espanhol" },
    { $addToSet: { "idiomas_aprendidos.$.fases_concluidas": "Fase 2" } }
);

// Consulta SET, subsequente

db["estudantesLinguas"].updateOne(
    { nome: "Flavio Roberto", "idiomas_aprendidos.idioma": "Espanhol" },
    { $set: { "idiomas_aprendidos.$.nivel_fluencia": "Intermediario" } }
);
  
// Consulta MAP_REDUCE e RENAME_COLLECTION

db["estudantesLinguas"].mapReduce(

    function() {

      this.idiomas_aprendidos.forEach(function(idioma) {
        emit(idioma.idioma, idioma.fases_concluidas.length);
      });
    },
    function(key, values) {
      return Array.sum(values);
    },
    {
      out: "quantificador_de_progresso"
    }
);
  
db["quantificador_de_progresso"].renameCollection("medidor_progresso");

// Consulta TEXT e SEARCH

db["estudantesLinguas"].createIndex({ nome: "text" }); // Foco de procura no campo NOME

// Busca por documentos que CONTÉM a palavra "Neto"
db["estudantesLinguas"].find({ $text: { $search: "Neto" } });

// Consulta COND

db["estudantesLinguas"].updateMany( {}

    [
        {
            $set: {
                "idiomas_aprendidos": {
                    $map: {
                        input: "$idiomas_aprendidos",
                        as: "idioma",
                        in: {
                            idioma: "$$idioma.idioma",
                            nivel_fluencia: {
                                $cond: {

                                    if: { $gte: [{ $size: "$$idioma.fases_concluidas" }, 4] },

                                    then: "Avancado",
                                    else: {

                                        $cond: {

                                            if: { $gte: [{ $size: "$$idioma.fases_concluidas" }, 2] },

                                            then: "Intermediario",
                                            else: "Iniciante"
                                        }
                                    }
                                }
                            },
                            professor: "$$idioma.professor",
                            fases_concluidas: "$$idioma.fases_concluidas"
                        }
                    }
                }
            }
        }
    ]
);

