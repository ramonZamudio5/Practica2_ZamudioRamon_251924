*** Settings ***
Library           SeleniumLibrary
Resource          ../Datos/Usuarios.robot

*** Keywords ***
Abrir Navegador
    [Documentation]    Configuración inicial del navegador.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Agregar Producto Al Carrito
    [Arguments]    ${nombre_producto}
    [Documentation]    Automatiza el clic en un producto y su agregado al carrito.
    Wait Until Element Is Visible    xpath=//a[contains(text(),'${nombre_producto}')]    15s
    Click Element    xpath=//a[contains(text(),'${nombre_producto}')]
    Wait Until Element Is Visible    xpath=//a[text()='Add to cart']    10s
    Click Element    xpath=//a[text()='Add to cart']
    Sleep    2s
    Handle Alert    ACCEPT

Hacer Login Correcto
    [Arguments]    ${user}    ${pass}
    [Documentation]    Realiza el login con una espera extra para evitar errores de sincronización.
    Go To    ${URL}
    Wait Until Element Is Visible    id=login2    10s
    Click Element    id=login2
    Wait Until Element Is Visible    id=loginusername    10s
    Clear Element Text    id=loginusername
    Input Text    id=loginusername    ${user}
    Input Text    id=loginpassword    ${pass}
    Click Element    xpath=//button[text()='Log in']
    Sleep    4s

Cerrar Sesion
    [Documentation]    Hace clic en el botón de Logout.
    Wait Until Element Is Visible    id=logout2    10s
    Click Element    id=logout2
    Wait Until Element Is Visible    id=login2    10s