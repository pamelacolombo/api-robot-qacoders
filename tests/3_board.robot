*** Settings ***
Resource    ../resources/0_auth.resource
Resource    ../resources/3_board.resource
*** Variables ***


    
*** Test Cases ***
Cenário com Post: Cadastrar um novo usuário com sucesso
  Login com usuário Sysadmin
  Cadastrar um novo usuário Board
  Conferir se o novo usuário foi cadastrado corretamente
  Conferir os dados retornados do novo usuário
  Consultar os dados do usuário 
  Alterar dados de um usuário

 
  
