*** Settings ***
Resource    ../resources/users_recursos_DESAFIO.resource

*** Variables ***


    
*** Test Cases ***
Cenário com Post: Cadastrar um novo usuário com sucesso
  Criar sessão
  Cadastrar um novo usuário
  Consultar os dados do usuário
  Conferir se este novo usuário foi cadastrado corretamente
  Conferir os dados retornados do novo usuário
  Login com usuário criado
  Alterar dados de um usuário
 
  