# EpiManager
Repositório EPIAPP
Descrição do Projeto
Este é um Sistema Avançado de Gerenciamento de Equipamentos de Proteção Individual (EPI) desenvolvido em Python com interface gráfica utilizando PyQt5. O sistema permite o controle completo de estoque, retirada, devolução, colaboradores, empresas, categorias e geração de relatórios com gráficos e exportação em PDF/Excel.
Funcionalidades Principais

Cadastro e gerenciamento de usuários, colaboradores, empresas e categorias de EPI
Controle de estoque com níveis mínimos e alertas visuais
Retirada e devolução de EPIs com validade e senha do colaborador
Relatórios detalhados em tela, PDF e Excel
Painel com gráficos de estoque e estatísticas
Sistema de licença com verificação de chave e limites (usuários/empresas)
Auditoria completa de todas as ações
Interface moderna com abas e toolbar


Requisitos para Executar
1. Python

Versão: Python 3.8 ou superior

2. Banco de Dados MySQL

Servidor MySQL instalado e em execução
Dois bancos de dados necessários:
epi1 → banco principal do sistema
licenses_db → banco para controle de licenças


Atenção: O sistema cria automaticamente o banco epi1 se não existir.
3. Pacotes Python Necessários
Execute o comando abaixo para instalar todas as dependências:
pip install PyQt5 pandas openpyxl matplotlib reportlab mysql-connector-python boto3
O sistema verifica e instala automaticamente as dependências na primeira execução (se não estiverem presentes).

Configuração Inicial
1. Configurar MySQL

Abra o MySQL (via terminal ou cliente como MySQL Workbench)
Crie o banco de licenças:

CREATE DATABASE licenses_db;

Crie a tabela de licenças:

USE licenses_db;
CREATE TABLE licenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    license_key VARCHAR(50) UNIQUE,
    level INT,
    expiration_date DATE,
    max_companies INT,
    max_users INT
);

Insira uma chave de licença válida (exemplo):

INSERT INTO licenses (license_key, level, expiration_date, max_companies, max_users)
VALUES ('your-license-key-12345', 3, '2026-12-31', 10, 50);
Altere your-license-key-12345 no código se necessário.

2. Arquivo requisitos.bat (Opcional)
Se você estiver empacotando o sistema com PyInstaller, crie um arquivo requisitos.bat no mesmo diretório do script com:
bat@echo off
echo Instalando dependências do sistema...
pip install PyQt5 pandas openpyxl matplotlib reportlab mysql-connector-python boto3
echo.
echo Instalação concluída.
pause
Este arquivo é executado automaticamente na primeira inicialização (em modo congelado ou não).

Como Executar

Salve o código em um arquivo, por exemplo: epi_manager.py
Execute:

bashpython epi_manager.py

Na tela de login:
Usuário padrão: admin
Senha padrão: admin


A senha é convertida em hash SHA-256. O primeiro login cria o usuário admin automaticamente.

Estrutura de Pastas Recomendada

textepi_system/
│
├── epi_manager.py              # Código principal
├── requisitos.bat              # (Opcional) Instalador de dependências
├── export/                     # Pasta para salvar relatórios (opcional)
└── backups/                    # Backups automáticos (futuro)

Observações Importantes
Item,Observação
Licença,O sistema para completamente se a licença estiver inválida ou expirada.
Senhas,Todas as senhas são armazenadas com hash SHA-256. Senhas de 4 dígitos para colaboradores.
Níveis de Usuário,"1 = Colaborador, 2 = Almoxarife, 3 = Administrador"
Estoque Baixo,Itens com quantidade ≤ estoque mínimo aparecem em vermelho claro na tabela.
Validade de EPI,Definida em dias (padrão: 180). Aparece em vermelho se vencer em até 7 dias.
Devolução,Itens devolvidos são marcados para descarte (quantidade_descarte).
Relatórios PDF,Incluem termo de responsabilidade com campos para assinatura.
Exportação Excel,Requer openpyxl. Exporta todo o estoque atual.
Backup,Não implementado ainda. Recomenda-se backup manual do banco epi1.

Dicas de Segurança

Altere a senha do usuário admin após o primeiro login.
Restrinja acesso ao banco MySQL apenas ao usuário root com senha forte.
Não compartilhe a chave de licença.


Contribuição
Sinta-se à vontade para abrir issues ou pull requests no repositório.

Desenvolvedor
Danilo Hollanders de Moura
📧 danilo.aax@gmail.com
📞 (34) 99209-1807

Sistema desenvolvido com dedicação para gestão segura e eficiente de EPIs.
Versão 1.2 - 14/11/2025


INSTRUÇÕES DE INSTALAÇÃO E EXECUÇÃO

Pré-requisitos
bash- Python 3.11+
- MySQL Server 8.0+
- XAMPP (opcional, para banco local)
1. Clone o repositório
bashgit clone https://[https://github.com/DaniloHMoura/EpiManager](https://github.com/DaniloHMoura/EpiManager).git
cd epi-manager-system
2. Instale as dependências
bashpip install PyQt5 mysql-connector-python reportlab openpyxl matplotlib pandas
3. Configure o banco de dados
sql-- Crie os schemas
CREATE DATABASE epi1;
CREATE DATABASE licenses_db;

-- Importe os scripts
mysql -u root -p epi1 < database/epi1_schema.sql
mysql -u root -p licenses_db < database/licenses_schema.sql

-- Insira a licença padrão (válida por 1 ano)
INSERT INTO licenses_db.licenses (...) VALUES (...);
4. Configure a conexão (config.ini)
ini[database]
host = localhost
user = root
password = 
port = 3306
5. Execute a aplicação
bashpython main.py

OPÇÃO 3: GERAR EXECUTÁVEL (PyInstaller)
bashpip install pyinstaller
pyinstaller --onefile --windowed --icon=assets/icon.ico main.py
Executável gerado em: dist/main.exe


PRIMEIROS PASSOS APÓS INSTALAÇÃO

Ative a licença (se não estiver ativa)
Cadastre a primeira empresa
Crie um usuário admin
Cadastre categorias e itens
Cadastre colaboradores com senha


SUPORTE E BACKUP

Backup automático:backups/backup_epi_YYYYMMDD.sql
Logs:logs/audit_YYYYMMDD.log
Documentação completa:docs/README.md


SISTEMA PRONTO PARA USO EM EMPRESAS REAIS
Conformidade com NR-6 | Segurança | Auditoria | Escalabilidade
