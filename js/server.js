const express = require('express');
const cors = require('cors');  // Adicionando CORS
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

// Endpoint para buscar plantas
app.get('/plants', (req, res) => {
  const { n, p, k } = req.query;
  const sql = 'SELECT nome, descricao, url FROM plantas WHERE N <= ? AND P <= ? AND K <= ?';
  
  db.query(sql, [n, p, k], (error, results) => {
    if (error) {
      return res.status(500).json({ error: error.message });
    }
    res.json(results);
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
