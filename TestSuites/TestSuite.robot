*** Settings ***
Library    config_reader.py
Library     JMSLibrary
Library  OperatingSystem

*** Variables ***
${queue_name}   Robot.Framework.Testing
${qMessage}     Test Message

*** Test Cases ***
Test 1
    ${x}=   Read Config Data    config.ini    Environment     password
    log    desired: ${x}
Test 2
    ${y}=   Read Config Data    config.ini    WebUI       login_url
    log    desired: ${y}
Test 3
    ${broker}=  Read Config Data    config.ini    ActiveMQ       activemq_broker_url
    Connect To JMS      ${broker}
    Create JMS Queue    ${queue_name}
    Send JMS Text Message   ${queue_name}  ${qMessage}
    Disconnect From JMS

*** Keywords ***
Read Config Data
    [Arguments]    ${path}      ${target}       ${target_key}
    ${config_data} =    Read Config File    ${path}
    Log    Configuration Data: ${config_data}
    ${disered_data} =    Set Variable    ${config_data}[${target}][${target_key}]
    [Return]    ${disered_data}