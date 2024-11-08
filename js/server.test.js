const request = require('supertest');
const app = require('./server'); 
const mysql = require('mysql2');

// Configuração do banco de dados de teste
const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'rootpassword',
  database: 'banco_teste',
  port: 3306
});

// Função para limpar o banco de dados entre os testes
function cleanDatabase() {
  return new Promise((resolve, reject) => {
    db.query('DELETE FROM plantas', (err) => {
      if (err) return reject(err);
      resolve();
    });
  });
}

// Função para adicionar dados de exemplo ao banco de dados
function insertTestData() {
  return new Promise((resolve, reject) => {
    const plantas = [
      { nome: 'Planta 1', descricao: 'Planta 1 Descrição', url: 'http://exemplo.com/1', N: 10.5, P: 5.3, K: 2.2 },
      { nome: 'Planta 2', descricao: 'Planta 2 Descrição', url: 'http://exemplo.com/2', N: 12.0, P: 6.0, K: 3.0 },
      { nome: 'Planta 3', descricao: 'Planta 3 Descrição', url: 'http://exemplo.com/3', N: 15.0, P: 7.5, K: 4.0 }
    ];

    const sql = 'INSERT INTO plantas (nome, descricao, url, N, P, K) VALUES ?';
    const values = plantas.map(p => [p.nome, p.descricao, p.url, p.N, p.P, p.K]);

    db.query(sql, [values], (err) => {
      if (err) return reject(err);
      resolve();
    });
  });
}

describe('GET /plants', () => {
  beforeAll(async () => {
    // Limpar o banco de dados e inserir dados de teste antes de cada execução de teste
    await cleanDatabase();
    await insertTestData();
  });

  afterAll((done) => {
    db.end();
    done();
  });

  it('should return a list of plants filtered by N, P, and K values', async () => {
    const response = await request(app)
      .get('/plants')
      .query({ n: 12, p: 6, k: 3 });  // Filtro que deve incluir a planta 1 e 2

    expect(response.status).toBe(200);
    expect(Array.isArray(response.body)).toBe(true);
    expect(response.body.length).toBe(2);
    expect(response.body[0]).toHaveProperty('nome', 'Planta 1');
    expect(response.body[1]).toHaveProperty('nome', 'Planta 2');
  });

  it('should return an empty array when no plants match the filter', async () => {
    const
