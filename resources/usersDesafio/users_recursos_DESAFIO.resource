*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes 
Library  RequestsLibrary
Library  String
Library  Collections


*** Variables ***
${TOKEN}  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTMzMGI5YzQxODQwMjkwNGVjN2E3ZGUiLCJmdWxsTmFtZSI6IlFhLUNvZGVycy1TWVNBRE1JTiIsIm1haWwiOiJzeXNhZG1pbkBxYWNvZGVycy5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCQ3MFpsYk05RjZvM053RWs2MThtRVh1a3JzN3A3SXIzWS5HaEhicU9nWjJDcnBFZmNvbVIzTyIsImFjY2Vzc1Byb2ZpbGUiOiJTWVNBRE1JTiIsImNwZiI6IjExMTExMTExMTExIiwic3RhdHVzIjp0cnVlLCJhdWRpdCI6W3sicmVnaXN0ZXJlZEJ5Ijp7InVzZXJJZCI6IjExMTExMTExMTExMTExMTExMSIsInVzZXJMb2dpbiI6InN5c2FkbWluQHFhY29kZXJzLmNvbSJ9LCJyZWdpc3RyYXRpb25EYXRlIjoic2V4dGEtZmVpcmEsIDIwLzEwLzIwMjMsIDIwOjIyOjA0IEJSVCIsInJlZ2lzdHJhdGlvbk51bWJlciI6IjAxIiwiY29tcGFueUlkIjoiUWEuQ29kZXJzIiwiX2lkIjoiNjUzMzBiOWM0MTg0MDI5MDRlYzdhN2RmIn1dLCJfX3YiOjAsImlhdCI6MTcxMjI1OTg2MCwiZXhwIjoxNzEyMzQ2MjYwfQ.1pvUmXg7B0BMMKmEuF2hrxhcqXorh3SDcpi18V9jTDM

*** Keywords **

Criar sessão
  ${headers}  Create Dictionary  accept=application/json  Content-Type=application/json  Authorization=${TOKEN}  
  Create Session    alias=Suits       url=https://suits.qacoders-academy.com.br  headers=${headers}

Criar sessão de usuário
  ${headers}  Create Dictionary  accept=application/json  Content-Type=application/json  Authorization=${TOKEN_USER}  
  Create Session    alias=Suits      url=https://suits.qacoders-academy.com.br  headers=${headers}

Criar massa de dados de usuário
  ${palavra_randomica}  Generate Random String  length=8  chars=[LETTERS]
  ${palavra_randomica}  Convert To Lower Case    ${palavra_randomica} 
  Set Test Variable    ${EMAIL_TEST}             ${palavra_randomica}@qacoders.com.br
  Log                  ${EMAIL_TEST}    
  ${palavra_randomica_cpf}  Generate Random String  length=11  chars=[NUMBERS]
  Set Test Variable    ${CPF}                    ${palavra_randomica_cpf}     
  Log                  ${CPF}  

Cadastrar um novo usuário
  Criar massa de dados de usuário 
  ${body}  Create Dictionary  fullName=Teste do Teste   mail=${EMAIL_TEST}  password=1234@Test  accessProfile=ADMIN  cpf=${CPF}  confirmPassword=1234@Test
  Log  ${body}
  ${resposta}  POST On Session  alias=Suits  url=/api/user  json=${body}  expected_status=201
  Log  ${resposta.json()}
  Set Test Variable    ${ID_USUARIO}  ${resposta.json()["user"]["_id"]}
  Set Test Variable    ${RESPOSTA}  ${resposta.json()}

Consultar os dados do usuário
  ${resposta_consulta}  GET On Session  alias=Suits  url=api/user/${ID_USUARIO}  expected_status=200
  Set Test Variable    ${RESPOSTA_CONSULTA}                  ${resposta_consulta.json()}

Conferir se este novo usuário foi cadastrado corretamente
  Log  ${RESPOSTA}
  Dictionary Should Contain Item    ${RESPOSTA}    msg    Olá Teste do Teste, cadastro realizado com sucesso.
  Dictionary Should Contain Key     ${RESPOSTA}    user   _id

Conferir os dados retornados do novo usuário
  Log  ${RESPOSTA_CONSULTA}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    fullName             Teste do Teste
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    mail                 ${EMAIL_TEST}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    accessProfile        ADMIN
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    cpf                  ${CPF}  
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    _id                  ${ID_USUARIO}

Login com usuário criado
    ${body}  Create Dictionary  mail=${EMAIL_TEST}  password=1234@Test
   Log  ${body}
   ${resposta}  POST On Session  alias=Suits  url=/api/login  json=${body} 
   Log  ${resposta.json()}
   Set Test Variable    ${TOKEN_USER}  ${resposta.json()["token"]} 

Validar o token e gravar em um header de autorização
  ${headers}  Create Dictionary  Authorization=Bearer ${TOKEN_USER}
  ${resposta}  GET On Session  alias=Suits  url=/api/validateToken  headers=${headers}
  Log  ${resposta.content} 
  Log  ${TOKEN_USER}

Alterar dados de um usuário
  Criar sessão de usuário
    ${alterar_dados_usuario}    PUT On Session    alias=Suits    url=/api/user/${ID_USUARIO}   expected_status=200    data={"fullName":"Ana Maria", "mail":"${EMAIL_TEST}"}
    Set Test Variable    ${ALTERAR_DADOS_USUARIO}                  ${alterar_dados_usuario.json()}
    Log  ${ALTERAR_DADOS_USUARIO}
  Dictionary Should Contain Item    ${ALTERAR_DADOS_USUARIO}    msg    Dados atualizados com sucesso!

