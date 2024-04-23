*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes 
Library  RequestsLibrary
Library  String
Library  Collections



*** Variables ***
${MAIL}  sysadmin@qacoders.com 
${PASSWORD}  1234@Test
${URL}  https://suits.qacoders-academy.com.br

*** Keywords ***
 
Criar sessão
  ${headers}  Create Dictionary    Content-Type=application/json  
  Create Session    alias=Suits      url=${URL}   headers=${headers}

Login com usuário Sysadmin
  ${body}        Create Dictionary  mail=${mail}  password=${PASSWORD}
   Log  ${body}
   Criar sessão     
   ${resposta}  POST On Session  alias=Suits   url=/api/login  json=${body}
   Log  ${resposta.json()}
   Set Test Variable    ${TOKEN}  ${resposta.json()["token"]}

Validar o token e gravar em um header de autorização
  ${headers}  Create Dictionary  Authorization=Bearer ${TOKEN}
  ${resposta}  GET On Session  alias=Suits   url=/api/validateToken  headers=${headers}
  Log  ${resposta.content} 
  Log  ${TOKEN}

  