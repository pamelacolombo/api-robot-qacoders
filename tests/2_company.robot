*** Settings ***
Resource    ../resources/2_company.resource
Resource    ../resources/0_auth.resource

*** Variables ***


    
*** Test Cases ***
Cenário com Post: Cadastrar um novo usuário com sucesso
  Login com usuário Sysadmin
  Cadastrar um novo usuário Company
  Conferir se o novo usuário Company foi cadastrado corretamente
  Conferir os dados retornados do novo usuário Company
  Consultar os dados do usuário Company
  Alterar dados de um usuário Company


 
  