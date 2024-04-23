*** Settings ***
Resource    ../resources/1_users.resource
Resource    ../resources/0_auth.resource

*** Variables ***


    
*** Test Cases ***
Cenário com Post: Cadastrar um novo usuário com sucesso
  Login com usuário Sysadmin
  Cadastrar um novo usuário
  Conferir se o novo usuário foi cadastrado corretamente

Cenario com Get
  Login com usuário Sysadmin
  Cadastrar um novo usuário
  Consultar os dados do usuário 
  Conferir os dados retornados do novo usuário 

Cenario com Put
  Login com usuário Sysadmin
  Cadastrar um novo usuário
  Login com usuário criado
  Alterar dados de um usuário  
 
