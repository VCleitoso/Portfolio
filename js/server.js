const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const app = express();
const port = 3000;

// Habilitar CORS para permitir que o aplicativo Dart se conecte
app.use(cors());
app.use(express.json());

// Configuração do banco de dados
const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'rootpassword',
  database: 'banco_teste',
  port: 3306
});

db.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL.');
});

// Função para registrar log no banco de dados
const logRequest = (endpoint, n, p, k, ip) => {
  const sql = 'INSERT INTO logs (endpoint, n, p, k, ip) VALUES (?, ?, ?, ?, ?)';
  db.query(sql, [endpoint, n, p, k, ip], (error) => {
    if (error) {
      console.error('Erro ao registrar log:', error);
    } else {
      console.log('Log registrado com sucesso.');
    }
  });
};

// Endpoint para buscar plantas
app.get('/plants', (req, res) => {
  const { n, p, k } = req.query;
  const ip = req.ip;  // Captura o IP da requisição

  // Registrar log da requisição com o IP
  logRequest('/plants', n, p, k, ip);

  const sql = 'SELECT nome, descricao, url FROM plantas WHERE N <= ? AND P <= ? AND K <= ?';
  
  db.query(sql, [n, p, k], (error, results) => {
    if (error) {
      return res.status(500).json({ error: error.message });
    }
    res.json(results);
  });
});
app.get('/logs', (req, res) => {
  const sql = 'SELECT * FROM logs ORDER BY timestamp DESC LIMIT 50'; // Limite de 50 logs para exibir
  db.query(sql, (error, results) => {
    if (error) {
      return res.status(500).json({ error: error.message });
    }
    res.json(results);
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
