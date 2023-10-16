*** Settings ***
Library    ../CostumerLibraries/config_reader.py
Library  OperatingSystem
Library    ../CostumerLibraries/ActiveMQLibrary.py

*** Test Cases ***
Test 1
    ${x}=   Read Config Data    config.ini    Environment     password
    log    desired: ${x}
Test 2
    ${y}=   Read Config Data    config.ini    WebUI       login_url
    log    desired: ${y}
Test 3
    [Tags]    ActiveMQ
    ${destination}=    Set Variable    /queue/myQueue
    ${message}=    Set Variable    Hello, From Robot!
    ${result}=    Send Message To ActiveMQ    ${destination}    ${message}
    Log    ${result}

*** Keywords ***
Read Config Data
    [Arguments]    ${path}      ${target}       ${target_key}
    ${config_data} =    Read Config File    ${path}
    Log    Configuration Data: ${config_data}
    ${disered_data} =    Set Variable    ${config_data}[${target}][${target_key}]
    [Return]    ${disered_data}

