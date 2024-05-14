*** Settings ***
Resource    ../resources/1_users.resource
Resource    ../resources/0_auth.resource

*** Variables ***


    
*** Test Cases ***
Cadastrar um novo usuário com sucesso, consultar, logar e alterar novo usuário
  Login com usuário Sysadmin
  Cadastrar um novo usuário
  Conferir se o novo usuário foi cadastrado corretamente
  Consultar os dados do usuário 
  Conferir os dados retornados do novo usuário 
  Login com usuário criado
  Alterar dados de um usuário  

Excluir usuário cadastrado
  Login com usuário Sysadmin
  Cadastrar um novo usuário
  Excluir usuário criado  


 
