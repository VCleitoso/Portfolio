CREATE TABLE plantas (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- ID automático
    nome VARCHAR(255) NOT NULL,            -- Nome da planta
    N DECIMAL(5, 2),                       -- Concentração de nitrogênio no solo
    P DECIMAL(5, 2),                       -- Concentração de fósforo no solo
    K DECIMAL(5, 2),                       -- Concentração de potássio no solo
    descricao TEXT,                       -- Descrição da planta
    url VARCHAR(255)                      -- Caminho para um documento com informações de cultivo
);

INSERT INTO plantas (nome, N, P, K, descricao, url)
VALUES ('Exemplo Planta', 15.50, 20.75, 10.00, 'Descrição breve da planta.', 'caminho/para/documento.pdf');

INSERT INTO plantas (nome, N, P, K, descricao, url)
VALUES 
('Teste', 1.00, 1.00, 1.00, 'Somente um rick roll', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
('Rosa', 12.30, 18.50, 9.20, 'Planta ornamental com flores coloridas.', 'www.google.com'),
('Girassol', 14.00, 22.00, 11.50, 'Planta alta com flores grandes e amarelas.', 'caminho/para/documento.pdf'),
('Lavanda', 10.50, 15.75, 8.00, 'Planta aromática usada em óleos essenciais.', 'caminho/para/documento.pdf'),
('Hortênsia', 13.20, 19.80, 10.40, 'Planta com flores grandes e variadas cores.', 'caminho/para/documento.pdf'),
('Alecrim', 11.00, 17.50, 9.00, 'Erva aromática usada na culinária.', 'caminho/para/documento.pdf');
