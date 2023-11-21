*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}        http://localhost:8080

*** Test Cases ***

TC1: Display all video games using GET REQUEST
    Create Session    mysession    ${base_url}
    ${response} =    Get Request    mysession    /app/videogames


    Log To Console    ${response.status_code}
    Log To Console    ${response.content}


    # VALIDATIONS
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200



TC2: Add a video game using POST REQUST
    Create Session  mysession   ${base_url}
    ${body}=    Create Dictionary   id=39  name=Batman releaseDate=2023-11-18T03:08:25.516Z reviewScore=10 category=action rating=seven
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response} =  Post Request    mysession    /app/videogames  json=${body}    headers=${header}


    Log To Console    ${response.status_code}
    Log To Console    ${response.content}


    #Valiadtions
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${status_code}    200

    ${res_body} =   Convert To String  ${response.content}
    Should Contain    ${res_body}     Record Added Successfully

TC3: Returns all details about single video game by ID GET REQUEST
    Create Session    mysession    ${base_url}
    ${response} =    Get Request    mysession    /app/videogames/67

    Log To Console    ${response.status_code}
    Log To Console    ${response.content}


    # VALIDATIONS
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200

    ${res_body} =   Convert To String  ${response.content}
    Should Contain    ${res_body}     Batman


TC4: Update a video game using PUT REQUEST
    Create Session  mysession   ${base_url}
    ${body}=    Create Dictionary   id=39  name=Spider Man releaseDate=2023-11-18T03:08:25.516Z reviewScore=10 category=action rating=seven
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response} =  Put Request    mysession    /app/videogames/39  json=${body}    headers=${header}


    Log To Console    ${response.status_code}
    Log To Console    ${response.content}


    #Valiadtions
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${status_code}    200

    ${res_body} =   Convert To String  ${response.content}
    Should Contain    ${res_body}     Spder Man

TC5: Delete a video game using DELETE REQUEST By ID
    Create Session  mysession   ${base_url}
   ${response}=  Delete Request    mysession     /app/videogames/39

    #Validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${status_code}    200

    ${res_body} =   Convert To String  ${response.content}
    Should Contain    ${res_body}     Record Deleted Successfully