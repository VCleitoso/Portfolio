CREATE DATABASE IF NOT EXISTS banco_teste;
USE banco_teste;
CREATE TABLE IF NOT EXISTS plantas (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL, 
    N DECIMAL(5, 2), 
    P DECIMAL(5, 2), 
    K DECIMAL(5, 2), 
    descricao TEXT, 
    url VARCHAR(255)
); 
INSERT INTO plantas (nome, N, P, K, descricao, url) VALUES 
('Rosa', 12.30, 18.50, 9.20, 'Planta ornamental com flores coloridas.', 'http://inspiron.local:3030/inst_cultivo/rosa.html'),
('Girassol', 14.00, 22.00, 11.50, 'Planta alta com flores grandes e amarelas.', 'http://inspiron.local:3030/inst_cultivo/girassol.html'),
('Lavanda', 10.50, 15.75, 8.00, 'Planta aromática usada em óleos essenciais.', 'http://inspiron.local:3030/inst_cultivo/lavanda.html'),
('Hortênsia', 13.20, 19.80, 10.40, 'Planta com flores grandes e variadas cores.', 'http://inspiron.local:3030/inst_cultivo/hostensia.html'),
('Alecrim', 11.00, 17.50, 9.00, 'Erva aromática usada na culinária.', 'http://inspiron.local:3030/inst_cultivo/alecrim.html');

CREATE TABLE IF NOT EXISTS logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  endpoint VARCHAR(255) NOT NULL,
  n INT,
  p INT,
  k INT,
  ip VARCHAR(255), 
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
