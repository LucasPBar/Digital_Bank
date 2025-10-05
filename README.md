# 💳 Digital Bank — Análise de Dados em um Banco Digital

<img width="1408" height="768" alt="Image" src="https://github.com/user-attachments/assets/2fe14533-45fc-4554-b5e9-b82322828578" />


Este projeto simula o ambiente de um banco digital e foi desenvolvido para aplicar conceitos de modelagem e análise de dados em um contexto realista do setor financeiro.  
A ideia é entender como bancos digitais estruturam suas bases de dados, monitoram operações, e utilizam informações para gerar insights estratégicos sobre clientes, produtos e rentabilidade.
> 🚀 Este projeto foi desenvolvido durante o módulo **"Explorando Bancos Relacionais e Consultas em SQL"** do **Bootcamp Klabin - Análise de Dados com Excel e Power BI Dashboards** da [Digital Innovation One (DIO)](https://www.dio.me/) em parceria com a empresa **Klabin**.
---

## 🎯 Sobre o Projeto

Escolhi trabalhar com o cenário de bancos digitais porque acredito que o futuro das finanças está na inovação de dados, e queria compreender melhor como um banco digital estrutura e analisa suas operações.  
A partir de consultas SQL, foi possível explorar temas como inadimplência, comportamento de consumo, relação entre score de crédito e engajamento com produtos, e políticas de aumento de limite de crédito.

> ⚠️ Observação: todos os dados utilizados para abastecer o banco foram gerados de forma aleatória utilizando **inteligência artificial**, garantindo diversidade sem expor informações reais de clientes ou empresas.

## 🎯 Objetivo do Projeto

O foco deste trabalho é aplicar conhecimentos em **SQL e modelagem de dados** em um contexto financeiro, abordando desde a criação das tabelas e seus relacionamentos até a elaboração de **consultas analíticas baseadas em hipóteses de negócio**.  

Além do desenvolvimento técnico, o projeto também reflete um interesse pessoal em entender melhor o setor financeiro e como a análise de dados pode apoiar decisões dentro de um banco digital.

---

## 🧩 Modelagem do Banco de Dados

A estrutura foi desenvolvida para representar o funcionamento de um **banco digital**, com entidades que simulam clientes, contas, transações, investimentos, empréstimos e produtos financeiros.

Abaixo está o diagrama relacional criado para representar o modelo do banco de dados:

<p align="center">
  <img width="942" height="1361" alt="Image" src="https://github.com/user-attachments/assets/ab2e652d-6ebb-431f-b27b-a3297da938a8" />
</p>

---

## 🛠️ Tecnologias Utilizadas  

- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" alt="MySQL Logo" width="35" style="vertical-align:middle; margin-right:5px;"> MySQL** para criação, estruturação e gerenciamento do banco de dados relacional.  
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-original.svg" alt="Workbench Logo" width="30" style="vertical-align:middle; margin-right:5px;"> Workbench** para modelagem visual e desenvolvimento do diagrama entidade-relacionamento (DER).  
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/azuresqldatabase/azuresqldatabase-original.svg" alt="SQL Logo" width="30" style="vertical-align:middle; margin-right:5px;"> SQL** para consultas analíticas, manipulação e exploração dos dados.  
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" alt="Git Logo" width="30" style="vertical-align:middle; margin-right:5px;"> Git & GitHub** para versionamento e hospedagem do projeto.  

---

## 🗂️ Estrutura do Banco de Dados

O banco `digital_bank` representa as principais entidades e relações de um banco digital, incluindo:

- **Cliente:** dados cadastrais e status da conta.  
- **Conta:** saldo e movimentações financeiras.  
- **Cartão e Fatura:** limites, pagamentos e histórico de crédito.  
- **Empréstimo:** valores, parcelas e inadimplência.  
- **Investimento:** tipos e valores aplicados.  
- **Seguros:** status e cancelamentos.  
- **Tarifas:** fontes de receita do banco.  
- **Risco_Cliente:** score de crédito.  
- **Transação:** PIX, TED, DOC e transferências internas.  
- **Limite_Historico:** registros de aumento e motivo das alterações de limite.

---

## 🔍 Consultas e Perguntas de Negócio

As consultas foram criadas para responder perguntas de gestão e operação, como:

| Nº | Pergunta | Objetivo |
|----|-----------|-----------|
| 1 | Quem são os clientes com contas ativas? | Identificar clientes ativos. |
| 2 | Qual a idade atual de cada cliente? | Entender o perfil demográfico. |
| 3 | Quais clientes possuem saldo maior que a média geral? | Detectar clientes de maior valor. |
| 4 | Quais clientes mais enviaram dinheiro em transações? | Identificar clientes mais movimentados. |
| 5 | Quem são os clientes inadimplentes em empréstimos? | Avaliar risco de crédito. |
| 6 | Quais clientes possuem faturas atrasadas? | Medir inadimplência de cartões. |
| 7 | Quanto o banco arrecadou em tarifas por tipo? | Calcular receita operacional. |
| 8 | Quais são os top 5 clientes com melhor score? | Identificar perfis de baixo risco. |
| 9 | Quanto cada cliente tem investido em produtos ativos? | Avaliar engajamento em investimentos. |

---

## 🔬 Hipóteses e Análises do Projeto

| Análise | Hipótese | Descrição / Objetivo | Conclusão |
|----------|-----------|----------------------|------------|
| Limite x Gastos | Clientes com limite mais alto tendem a gastar mais | Verificar se o limite influencia o volume de gastos | Relação positiva identificada: maiores limites estão ligados a maiores volumes de transações |
| Investimentos x Saldo | Clientes que investem mantêm saldos mais altos | Analisar se há correlação entre valor investido e saldo total | Clientes com investimentos ativos possuem saldos mais robustos |
| Inadimplência cruzada | Clientes que atrasam faturas também atrasam empréstimos | Identificar sobreposição entre inadimplências | Parte significativa apresenta atrasos em ambos os produtos |
| Tarifas x Saldo | Receita de tarifas vem de clientes com baixo saldo | Avaliar se clientes de baixo saldo geram mais tarifas | Confirmado: maior receita vem de contas com saldo menor |
| Diversificação x Receita | Clientes com múltiplos produtos geram mais receita | Medir impacto da diversificação na rentabilidade | Clientes com mais produtos ativos geram mais receita |
| Engajamento x Score | Clientes com mais produtos têm score maior | Testar se engajamento reduz risco de crédito | Confirmado: quanto mais produtos, melhor o score médio |
| Limite x Histórico de Pagamento | Aumento de limite está ligado a bom histórico | Verificar se o banco premia bons pagadores | Padrão observado: bons pagadores têm mais aumentos |
| Transações x Perfil de Investimento | Clientes que movimentam valores altos investem mais em risco | Relacionar volume de transações e perfil de investimento | Clientes de alta movimentação investem mais em ações e FIIs |
| Score x Cancelamento de Seguros | Score baixo aumenta taxa de cancelamento | Avaliar se score impacta retenção de seguros | Confirmado: clientes com score baixo cancelam mais seguros |

---

## ⚙️ Como Executar o Projeto

Para rodar o projeto na sua máquina, siga os passos abaixo:

1. **Clonar o repositório**  
```bash
git clone https://github.com/LucasPBar/sql-ecommerce-analytics.git
cd sql-ecommerce-analytics
```
2. Abrir o MySQL Workbench ou outro cliente SQL de sua preferência.

3. Criar um novo schema com o nome desejado (ex: `ecommerce_db`).

4. Executar os scripts SQL na seguinte ordem para garantir a criação correta do banco, inserção de dados e execução das queries de análise:

  - `project_ecommerce_dio_database.sql` → Criação da infraestrutura do banco de dados (tabelas, chaves e relacionamentos).  
  - `project_ecommerce_dio_data.sql` → Abastecimento do banco com dados de teste gerados por inteligência artificial.  
  - `project_ecommerce_dio_analise.sql` → Queries para recuperar informações e testar hipóteses de negócio.

5. Explorar os dados: abra o arquivo de queries (`project_ecommerce_dio_analise.sql`) para testar consultas ou criar análises adicionais conforme desejar.

> ⚠️ Observação: Todos os dados utilizados foram gerados de forma aleatória com o uso de inteligência artificial, não correspondendo a informações reais de clientes ou empresas.
**


---

## 📬 Contato

| | | |
| :--- | :--- | :--- |
| **👤 Nome:** | Lucas Pimenta Barretto | |
| **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linkedin/linkedin-original.svg" alt="LinkedIn" width="24" style="vertical-align:middle; margin-right:8px;"> LinkedIn:** | [linkedin.com/in/lucaspimentabarretto](https://www.linkedin.com/in/lucaspimentabarretto) | |
| **📧 Email:** | lucaspimenta1805@gmail.com | |
| **💼 Portfólio**  | [Data Science Portfolio](https://www.datascienceportfol.io/lucaspimenta1805) |



