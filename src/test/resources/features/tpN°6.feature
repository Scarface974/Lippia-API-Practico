@Sample
Feature: clockify

   @Listar_Proyectos
 Scenario: Listar los Proyectos
   Given base url https://api.clockify.me/api
   And   endpoint /v1/workspaces/6525c84c1b87f66587f0a8b2/projects
   And header Content-Type = application/json
   And header Accept = */*
   And header x-api-key = Y2U4YzdiMDgtMDE1Yi00NDQyLWIwMzAtNDA4MGI0NDI1M2I3
   When  execute method GET
   Then  the status code should be 200
  * define idWorkspace = $.[0].id

  @Listar_Proyectos_401
  Scenario: Listar los Proyectos No Autorizado
    Given base url https://api.clockify.me/api
    And   endpoint /v1/workspaces/6525c84c1b87f66587f0a8b2/projects
    And header Content-Type = application/json
    And header Accept = */*
    When  execute method GET
    Then  the status code should be 401

  @CreateProject @Listar_Proyectos_400
  Scenario: Listar los Proyectos No Encontrado
    Given base url https://api.clockify.me/api
    And   endpoint /v1/workspaces/652ea6cb12942c739a/projects
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = Y2U4YzdiMDgtMDE1Yi00NDQyLWIwMzAtNDA4MGI0NDI1M2I3
    When  execute method GET
    Then  the status code should be 404

  Scenario: Agregar un Workspace
    Given call PruebaApi.feature@Listar_espacio_de_trabajo
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkspace}}
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = Y2U4YzdiMDgtMDE1Yi00NDQyLWIwMzAtNDA4MGI0NDI1M2I3
    And body addworkspace.json
    When ejecutar metodo POST


  Scenario: Agregar Workspace
    Given base url https://api.clockify.me/api
    And   endpoint /v1/workspaces
    And   set value "MyWorkspace" of key name in body addWorkspace.json
    Then the status code should be 201

  @Agregar_Cliente_a_Workspace
    Scenario: Agregar Cliente a Workspace
      Given call PruebaApi.feature@Listar_espacio_de_trabajo
      And base url https://api.clockify.me/api
      And endpoint /v1/workspaces/{{idWorkspace}}/clients
      And header Content-Type = application/json
      And header Accept = */*
      And header x-api-key = Y2U4YzdiMDgtMDE1Yi00NDQyLWIwMzAtNDA4MGI0NDI1M2I3
      And body addClient.json
      When ejecutar metodo POST
      Then the status code should be 201
       And response should be name = cliente1
     * define idClient = $.id

   @DeleteClient
    Scenario: Eliminar Cliente del Espacio de Trabajo
      Given call PruebaApi.feature@Agregar_Cliente_a_Workspace
        And base url https://api.clockify.me/api
        And endpoint /v1/workspaces/{{idWorkspace}}/clients/{{idClient}}
       When execute method DELETE 
       Then the status code should be 200

      

  
