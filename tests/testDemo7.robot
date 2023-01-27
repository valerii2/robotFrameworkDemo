*** Settings ***
Library    JSONLibrary
Library    RequestsLibrary
Library    Collections


*** Variables ***
${base_url}    http://216.10.245.166
${book_id}
${book_name}    Bob

*** Test Cases ***
POST book into library Database
    [Tags]    API
#    ${request_body}=    Load Json From File     tests/post.json
    &{request_body}=    Create Dictionary    name=${book_name}      isbn=428        aisle=1651       author=bobby
    Log    ${request_body}
    ${responce}=    POST    ${base_url}/Library/Addbook.php     json=${request_body}    expected_status=200
    Log    ${responce.json()}
    Dictionary Should Contain Key    ${responce.json()}     ID
    ${book_id}=     Get From Dictionary    ${responce.json()}       ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added        ${responce.json()}[Msg]
    Status Should Be    200     ${responce}

GET book from Database
    [Tags]    API
    ${get_responce}=    GET    ${base_url}/Library/GetBook.php      params=ID=${book_id}        expected_status=200
    log     ${get_responce.json()}
    Should Be Equal As Strings      ${book_name}        ${get_responce.json()}[0][book_name]

DELETE book from database
    [Tags]    API
    &{delete_req}=      Create Dictionary       ID=${book_id}
    Log    ${delete_req}
    ${delete_responce}=     POST    ${base_url}/Library/DeleteBook.php      json=${delete_req}      expected_status=200
    Log    ${delete_responce.json()}
    Should Be Equal As Strings    book is successfully deleted      ${delete_responce.json()}[msg]