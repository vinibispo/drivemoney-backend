# DrivemoneyBackend

<a href="https://raw.githubusercontent.com/vinibispo/drivemoney-backend/main/public/logo.png">
<img alt="Logo" src="https://raw.githubusercontent.com/vinibispo/drivemoney-backend/main/public/logo.png" alt="">
</a>

<p align="center">
<img src="http://img.shields.io/static/v1?label=Ruby&message=2.7.2&color=red&style=for-the-badge&logo=ruby"/>
<img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=6.0.3.5&color=red&style=for-the-badge&logo=ruby"/>
<a href="https://heroku.com/deploy">
<img src="https://www.herokucdn.com/deploy/button.svg" alt="">
</a>
</p>

<p align="center">
<a href="https://github.com/testdouble/standard">
<img src="https://img.shields.io/badge/code_style-standard-brightgreen.svg" alt="">
</a>
<a href='https://coveralls.io/github/vinibispo/drivemoney-backend?branch=main'><img src='https://coveralls.io/repos/github/vinibispo/drivemoney-backend/badge.svg?branch=main' alt='Coverage Status' /></a>
<a href="https://drivemoney-backend.herokuapp.com/api/v1/accounts">
<img src="https://heroku-badge.herokuapp.com/?app=drivemoney-backend&root=/api/v1/accounts" alt="">
</a>
<a href="https://badgen.net/codeclimate/maintainability/vinibispo/drivemoney-backend">
<img src="https://badgen.net/codeclimate/maintainability/vinibispo/drivemoney-backend" alt="">
</a>

</p>

---

### Tópicos

:large_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:large_blue_diamond: [Funcionalidades](#funcionalidades)

:large_blue_diamond: [Tecnologias utilizadas](#tecnologias-utilizadas) 

:large_blue_diamond: [Pré-requisitos](#pré-requisitos)

:large_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação)

:large_blue_diamond: [Como rodar os testes da aplicação](#como-rodar-os-testes-da-Aplicação)

---

### Descrição do projeto

<p align="center">🤑 API para você gerenciar quanto você ganha e quanto você gasta</p>

---

### Funcionalidades

- [x] Cadastro de Usuários

- [x] Login de Usuário

- [x] Cadastro de contas

- [x] Listagem de contas

- [x] Atualização de conta

- [x] Exclusão de conta

- [x] Mostrar conta individualmente

- [x] Cadastro de transações

- [x] Listagem de transações

- [x] Atualização de transação

- [x] Mostrar transação individualmente

---

### Tecnologias utilizadas

:heavy_check_mark: Ruby

Linguagem de programação utilizada para o backend



:heavy_check_mark: Ruby on Rails

Framework para o Backend



:heavy_check_mark: Docker

Ambiente virtual independente de sistema operacional



:heavy_check_mark: Docker Compose

Forma de gerenciar os ambientes do docker



:heavy_check_mark: RSpec

Suíte de testes para Ruby



:heavy_check_mark: Standard

Lint para ruby



:heavy_check_mark: Brakeman

Audit de código para ruby



:heavy_check_mark: U-Case

Gem para representar casos de uso de um jeito simples e poderoso

---

### Pré requisitos

:warning: [Git](https://git-scm.com)

:warning: [Docker](https://www.docker.com/get-started)

:warning: [Docker Compose](https://docs.docker.com/compose/install/)

---

### Como rodar a aplicação

- Clonando repositório
  
  ```bash
  git clone https://vinibispo/drivemoney-backend
  ```

- Entrando na pasta
  
  ```bash
  cd drivemoney-backend
  ```

- Iniciando serviços
  
  ```bash
  docker-compose up -d
  ```
* Criação do banco de dados

* ```bash
  docker-compose exec web rails db:create
  ```

* Migração do banco de dados
  
  ```bash
  docker-compose exec web rails db:migrate
  ```
  
  ### Como executar a suíte de testes
  
  - [Certifique-se de que executou os comandos anteriores](#como-rodar-a-aplicação)
  
  - Agora execute
  
  ```bash
  docker-compose exec -e "RAILS_ENV=test" web bundle exec rspec
  ```
