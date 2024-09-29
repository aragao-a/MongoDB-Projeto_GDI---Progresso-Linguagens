
// Consulta USE (retirar "//")
// use linguas

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

// Consulta FIND, PRETTY, SIZE

db["estudantesLinguas"].find({ idiomas_aprendidos: { $size: 5 } }).pretty()

// Consulta AGGREGATE - Todos os alunos maiores de 30 anos e quantos aprendem cada língua

db["estudantesLinguas"].aggregate([
    { $match: { idade: { $gte: 31 } } }, 
    { $unwind: "$idiomas_aprendidos" }, 
    { $group: { _id: "$idiomas_aprendidos.idioma", total: { $sum: 1 } } }, // Agrupa por idioma e conta
    { $sort: { total: 1 } } // Ordenação crescente
]);
  