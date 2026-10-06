# Sistemas de Banco de Dados - Práticas e Projeto Final

Este repositório contém as resoluções de atividades práticas e o projeto final desenvolvidos para a disciplina de **Sistema de Banco de Dados** do curso de **Bacharelado em Ciência da Computação** da **Universidade Federal de Uberlândia (UFU)**[cite: 2, 3]. 

## Estrutura do Repositório

A pasta está dividida entre exercícios laboratoriais e os arquivos correspondentes ao projeto de conclusão da disciplina[cite: 1]:

*   **Práticas (`Pratica08.sql` a `Pratica12.sql`)**: Scripts SQL com a resolução de exercícios desenvolvidos nas aulas práticas focados em DDL, DML, DQL e funções avançadas[cite: 1].
*   **`ProjetoFinal_MusicMatic.sql`**: Script completo contendo a criação das tabelas, população do banco de dados (inserts) e as consultas e funções do projeto final[cite: 1, 17, 24, 38].
*   **`Relatorio_MusicMatic.pdf`**: Documentação oficial e completa do projeto, abrangendo todas as etapas de modelagem e decisões arquiteturais[cite: 1, 4].

---

## 🎵 Projeto Final: MusicMatic

O **MusicMatic** é um modelo de banco de dados relacional projetado para um serviço de streaming de música[cite: 5]. O sistema foi estruturado para gerenciar o catálogo de artistas e músicas, além de lidar com diferentes perfis de usuários (padrão, usuários de negócios que realizam uploads, e estudantes com benefícios de desconto)[cite: 5, 7, 8, 9]. 

### Implementações

O desenvolvimento foi feito em linguagem SQL (padrão PostgreSQL) e abrange os seguintes tópicos abordados no relatório:

*   **Modelagem de Dados**: Elaboração do Modelo Entidade-Relacionamento (ER) e o seu mapeamento para o Modelo Relacional, garantindo a normalização e a correta aplicação de chaves primárias e estrangeiras[cite: 6, 11].
*   **Consultas Avançadas**: Implementação de relatórios agrupados, como músicas mais ouvidas (Hits), cálculo da média de idade dos artistas, contagem de músicas por gênero e opções de rádio/podcasts consumidos pelos usuários[cite: 38, 41, 42, 44].
*   **Álgebra Relacional**: Resolução de consultas através de operações formais, aplicando seleções, projeções, produto cartesiano e junções para extrair informações específicas do banco[cite: 46, 48, 50].
*   **Stored Procedures**: Criação da procedure `UploadMusica` em `plpgsql` para gerenciar a inserção de novas faixas, validando automaticamente se o usuário possui os privilégios de negócios ("UserNegocio") e calculando a idade do artista de forma dinâmica[cite: 52, 53].
*   **Triggers**: Automação através do gatilho `adicionar_reproducao_historico`, que registra de forma imediata o consumo de uma faixa na tabela de histórico sempre que ocorre uma nova inserção na tabela de compras[cite: 54, 55].
