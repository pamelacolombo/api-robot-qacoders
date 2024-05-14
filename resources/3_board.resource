*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes 
Library  RequestsLibrary
Library  String
Library  Collections
Resource  0_auth.resource 

*** Variables ***



*** Keywords ***

Criar massa de dados de usuário Board
  ${palavra_randomica}  Generate Random String  length=8  chars=[LETTERS]
  ${palavra_randomica}  Convert To Lower Case    ${palavra_randomica} 
  Set Test Variable    ${BOARD_NAME}             ${palavra_randomica}
  Log                  ${BOARD_NAME}   

Cadastrar um novo usuário Board
  Criar massa de dados de usuário Board
  ${body}  Create Dictionary   boardName=${BOARD_NAME}  
  Log  ${body} 
  ${headers}  Create Dictionary  Authorization=${TOKEN}
  ${resposta}  POST On Session  alias=Suits   url=/api/board  json=${body}   expected_status=201  headers=${headers}
  Log  ${resposta.json()}
  Set Test Variable    ${ID_BOARD}  ${resposta.json()["newBoard"]["_id"]}
  Set Test Variable    ${RESPOSTA}  ${resposta.json()}

Consultar os dados do usuário 
  ${headers}  Create Dictionary  Authorization=${TOKEN}
  ${resposta_consulta}  GET On Session  alias=Suits   url=api/board/${ID_BOARD}  expected_status=200  headers=${headers}
  Set Test Variable    ${RESPOSTA_CONSULTA}                  ${resposta_consulta.json()}

Conferir se o novo usuário foi cadastrado corretamente
  Log  ${RESPOSTA}
  Dictionary Should Contain Item    ${RESPOSTA}    msg    Cadastro realizado com sucesso!
  Dictionary Should Contain Key     ${RESPOSTA}    newBoard   _id

Conferir os dados retornados do novo usuário
  Log   ${RESPOSTA}
  Should Be Equal As Strings   ${RESPOSTA["newBoard"]["boardName"]}        ${BOARD_NAME} 

Alterar dados de um usuário
  ${headers}  Create Dictionary  Authorization=${TOKEN}
    ${alterar_dados_diretoria}    PUT On Session    alias=Suits     url=/api/board/${ID_BOARD}   expected_status=200    data={"boardName":"${BOARD_NAME}"}  headers=${headers}
    Set Test Variable    ${ALTERAR_DADOS_DIRETORIA}                  ${alterar_dados_diretoria.json()}
    Log  ${ALTERAR_DADOS_DIRETORIA}
    Dictionary Should Contain Item    ${ALTERAR_DADOS_DIRETORIA}    msg    Cadastro atualizado com sucesso.

Campo boardName sem preenchimento  
  ${body}  Create Dictionary   boardName=
  Log  ${body} 
  ${headers}  Create Dictionary  Authorization=${TOKEN}
  ${resposta}  POST On Session  alias=Suits   url=/api/board  json=${body}   expected_status=400  headers=${headers}
  Log  ${resposta.json()}
  Should Be Equal As Strings      ${resposta.json()}[error]   	["O campo 'diretoria' é obrigatório."] 

#Campo boardName com 51 caracteres 
  #${body}  Create Dictionary   boardName=Aaaaaaaaaaaaaaaaaaaaaaaa Aaaaaaaaaaaaaaaaaaaaaaaaa
  #Log  ${body} 
  #${headers}  Create Dictionary  Authorization=${TOKEN}
  #${resposta}  POST On Session  alias=Suits   url=/api/board  json=${body}   expected_status=400  headers=${headers}
  #Log  ${resposta.json()}
  #Set Test Variable    ${BOARDNAME_CARACTER_MAXIMO}    ${resposta.json()}
  #Dictionary Should Contain Item    ${BOARDNAME_CARACTER_MAXIMO}    error    O campo 'diretoria' deve possuir no máximo 50 caracteres. (RETORNOU STATUS 201)

Campo boardName com caractere difente de &
  ${body}  Create Dictionary   boardName=***
  Log  ${body} 
  ${headers}  Create Dictionary  Authorization=${TOKEN}
  ${resposta}  POST On Session  alias=Suits   url=/api/board  json=${body}   expected_status=400  headers=${headers}
  Log  ${resposta.json()}
  Should Be Equal As Strings      ${resposta.json()}[error]     ["O campo 'diretoria' só pode conter letras e o caractere especial '&'."] 


