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
('Exemplo Planta', 15.50, 20.75, 10.00, 'Descrição breve da planta.', 'file:///home/vandelsoncleitoso/Documentos/Faculdade/8aFase/PAC/notes.txt'),
('Rosa', 12.30, 18.50, 9.20, 'Planta ornamental com flores coloridas.', 'https://www.google.com'),
('Girassol', 14.00, 22.00, 11.50, 'Planta alta com flores grandes e amarelas.', 'https://www.google.com'),
('Lavanda', 10.50, 15.75, 8.00, 'Planta aromática usada em óleos essenciais.', 'file:///home/vandelsoncleitoso/Documentos/Faculdade/8aFase/PAC/notes.txt'),
('Hortênsia', 13.20, 19.80, 10.40, 'Planta com flores grandes e variadas cores.', 'file:///home/vandelsoncleitoso/Documentos/Faculdade/8aFase/PAC/notes.txt'),
('Alecrim', 11.00, 17.50, 9.00, 'Erva aromática usada na culinária.', 'file:///home/vandelsoncleitoso/Documentos/Faculdade/8aFase/PAC/notes.txt'),
('Rick Roll', 1.00, 1.00, 1.00, 'Só um Rick Roll', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');
