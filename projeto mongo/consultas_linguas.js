// CountDocuments
db.estudantesLinguas.countDocuments({ "turmas.codigo": "EN02" });

// Consulta INSERT_ONE
db["estudantesLinguas"].insertOne({
    "nome": "Maria Oliveira",
    "email": "maria.oliveira@cin.ufpe.br",
    "idade": 24,
    "turmas": [],
    "ultimo_acesso": "2024-10-01"
});

// Consultas UPDATEONE
// Adiciona a turma de Italiano a 'Papa Francisco'
db["estudantesLinguas"].updateOne(
    { nome: "Papa Francisco" },
    {
        $addToSet: {
            turmas: {
                codigo: "IT01",
                nivel_fluencia: "Avancado",
                fases_concluidas: ["Fase 1", "Fase 2", "Fase 3", "Fase 4"]
            }
        }
    }
);

// Atualiza o número de alunos da turma
db.turmas.updateOne(
    { codigo: "IT01" },
    { $inc: { quantidade_alunos: 1 } }
);

// EXISTIS: Consulta que encontra estudantes sem turmas ou com turmas vazias
db["estudantesLinguas"].find({
    $or: [
        { "turmas": { $exists: false } },
        { "turmas": { $size: 0 } }
    ]
});

// Consulta FIND_ONE e SIZE
// Find a student enrolled in exactly 5 classes
db["estudantesLinguas"].findOne({ turmas: { $size: 5 } });

// Consulta AGGREGATE, MATCH, GROUP, SORT, LOOKUP e PROJECT
// Numero de linguas por estudante com mais de 30 anos
db["estudantesLinguas"].aggregate([
    { $match: { idade: { $gte: 31 } } },
    { $unwind: "$turmas" },
    {
        $lookup: {
            from: "turmas",
            localField: "turmas.codigo",
            foreignField: "codigo",
            as: "turma_info"
        }
    },
    { $unwind: "$turma_info" },
    {
        $group: {
            _id: "$turma_info.idioma",
            total: { $sum: 1 }
        }
    },
    {
        $project: {
            idioma: "$_id",
            total: 1,
            _id: 0
        }
    },
    { $sort: { total: 1 } }
]);

// Consulta MAX
db.estudantesLinguas.aggregate([

    { $match: { idade: { $gt: 25 } } },
    
    { $unwind: "$turmas" },
    
    {
        $group: {
            _id: "$nome",
            email: { $first: "$email" },
            idade: { $first: "$idade" },
            max_fases_concluidas: { $max: { $size: "$turmas.fases_concluidas" } }
        }
    },
    
    { $sort: { max_fases_concluidas: -1 } },
    
    {
        $project: {
            _id: 0,
            nome: "$_id",
            email: 1,
            idade: 1,
            max_fases_concluidas: 1
        }
    }
]);

// AVG
db["estudantesLinguas"].aggregate([
    { $group: { _id: null, media_de_Idade: { $avg: "$idade" } } }
]);

// Achar até 3 estudantes aprendendo espanhol
db["estudantesLinguas"].find({ "turmas.codigo": "ES01" }).limit(3);

// Consulta WHERE e PRETTY
db["estudantesLinguas"]
    .find({ $where: "this.nome.startsWith('C')" })
    .limit(2)
    .pretty();

// Consulta FUNCTION

// Função 'codigo' para extrair o código da turma
function codigo(turma) {
    return turma.codigo;
}

// Função para retornar os alunos daquele idioma
function alunosIdioma(idioma) {

    var turmasIdioma = db.turmas.find({ idioma: idioma }, { codigo: 1, _id: 0 }).toArray();

    var codigosIdioma = turmasIdioma.map(codigo);

    return db["estudantesLinguas"].find(
        { "turmas.codigo": { $in: codigosIdioma } },
        { nome: 1, email: 1 }
    ).pretty();
}

alunosIdioma("Ingles");

// Consulta ALL
// Acha os estudantes que completaram todas as fases
db["estudantesLinguas"].find({
    "turmas.fases_concluidas": { $all: ["Fase 1", "Fase 2", "Fase 3", "Fase 4"] }
}).pretty();

// Consulta UPDATE_MANY e ADD_TO_SET
// Avança todos os estudantes de espanhol da turma ES01 para a fase 2, caso já não estejam
db["estudantesLinguas"].updateMany(
    { "turmas.codigo": "ES01" },
    { $addToSet: { "turmas.$[i].fases_concluidas": "Fase 2" } },
    { arrayFilters: [{ "i.codigo": "ES01" }] }
);

//SET MAP
//Da o uptade no nivel de fluencia com base no número de fases concluidas
db["estudantesLinguas"].aggregate([
    {
        $set: {turmas: {$map: {
            input: "$turmas",
            as: "turma",
            in: {
                codigo: "$$turma.codigo",
                nivel_fluencia: {
                    $switch: {
                        branches: [
                            {
                                case: { $gte: [{ $size: "$$turma.fases_concluidas" }, 4] },
                                then: "Avancado"
                            },
                            {
                                case: { $gte: [{ $size: "$$turma.fases_concluidas" }, 2] },
                                then: "Intermediario"
                            }
                        ],
                        default: "Iniciante"
                    }
                },
                fases_concluidas: "$$turma.fases_concluidas"
            }
        }}}
    },
    { $merge: { into: "estudantesLinguas", whenMatched: "replace" } }
]);

// Consulta MAP_REDUCE
db["estudantesLinguas"].mapReduce(
    function () {
        this.turmas.forEach(function (turma) {
            emit(turma.codigo, turma.fases_concluidas.length);
        });
    },
    function (key, values) {
        return Array.sum(values);
    },
    {
        out: "progresso_turmas"
    }
);

// Consulta TEXT e SEARCH
// Cria índice de texto para nome e email
db["estudantesLinguas"].createIndex({ nome: "text", email: "text" });

// Buscar pelos nomes 'Neto' ou pelo email 'vsll'
db["estudantesLinguas"].find({ $text: { $search: "Neto vsll" } });

// Buscar pelos termos 'Helena' e 'moura'
db["estudantesLinguas"].find({ $text: { $search: "Helena AND moura" } });

// Consulta FILTER
// Para cada aluno, retorna as turmas que ele possui, com ao menos 2 fases concluidas
db.estudantesLinguas.aggregate([
    {
        $project: {
            nome: 1,
            email: 1,
            idade: 1,
            turmas_com_pelo_menos_duas_fases: {
                $filter: {
                    input: "$turmas",
                    as: "turma",
                    cond: { $gt: [{ $size: "$$turma.fases_concluidas" }, 1] }
                }
            },
            _id: 0
        }
    }
]);

// RenameCollection
// Muda o nome da coleção "estudantesLinguas" para "estudantes"
db["estudantesLinguas"].renameCollection("estudantes");