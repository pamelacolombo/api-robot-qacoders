*** Settings ***
Resource    ../resources/0_auth.resource
Resource    ../resources/3_board.resource
*** Variables ***


    
*** Test Cases ***
Cadastrar um novo usuário com sucesso, consultar e alterar novo usuário
  Login com usuário Sysadmin
  Cadastrar um novo usuário Board
  Conferir se o novo usuário foi cadastrado corretamente
  Conferir os dados retornados do novo usuário
  Consultar os dados do usuário 
  Alterar dados de um usuário

Deixar o campo boardName sem preenchimento 
  Login com usuário Sysadmin
  Campo boardName sem preenchimento

#Cenário com Post: Preencher o campo boardName com 51 caracteres 
  #Login com usuário Sysadmin
  #Campo boardName com 51 caracteres

Preencher o campo diretoria com caractere especial diferente de & 
  Login com usuário Sysadmin
  Campo boardName com caractere difente de &