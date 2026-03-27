*** Settings ***
Documentation     Pruebas automatizadas para Demoblaze basadas en los 8 TC.
Library           SeleniumLibrary
Resource          ../Recursos/funcionalidades.robot
Suite Setup       Abrir Navegador
Suite Teardown    Close All Browsers
*** Variables ***
${URL}            https://www.demoblaze.com/
${BROWSER}        chrome

*** Test Cases ***

1. Verificar la Funcionalidad de Agregar al Carrito
    [Documentation]    Verifica que se pueda agregar un producto al carrito[cite: 30].
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Samsung galaxy s6')]    10s
    Click Element    xpath=//a[contains(text(),'Samsung galaxy s6')]
    Wait Until Element Is Visible    xpath=//a[text()='Add to cart']    10s
    Click Element    xpath=//a[text()='Add to cart']
    Sleep    2s
    Handle Alert    ACCEPT

2. Verificar el Flujo de Compra de un Producto
    [Documentation]    Verifica que el usuario pueda completar una compra[cite: 31].
    Go To    ${URL}cart.html
    Wait Until Element Is Visible    xpath=//button[text()='Place Order']    10s
    Click Element    xpath=//button[text()='Place Order']
    Wait Until Element Is Visible    id=name    10s
    Input Text    id=name    Juan Perez
    Input Text    id=country    Mexico
    Input Text    id=city    CDMX
    Input Text    id=card    1234567890123456
    Input Text    id=month    12
    Input Text    id=year    2025
    Click Element    xpath=//button[text()='Purchase']
    Wait Until Element Is Visible    xpath=//h2[text()='Thank you for your purchase!']    10s
    Click Element    xpath=//button[text()='OK']

3. Verificar la Navegación entre Categorías
    [Documentation]    Verifica que los filtros de categorías funcionen correctamente[cite: 33].
    Go To    ${URL}
    Wait Until Element Is Visible    id=itemc    10s
    # Laptops
    Click Element    xpath=//a[text()='Laptops']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Sony vaio')]    10s
    # Monitors
    Click Element    xpath=//a[text()='Monitors']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Apple monitor')]    10s

4. Verificar el Envío del Formulario de Contacto
    [Documentation]    Verifica que el formulario de contacto se envíe[cite: 37].
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//a[text()='Contact']    10s
    Click Element    xpath=//a[text()='Contact']
    Wait Until Element Is Visible    id=recipient-email    10s
    Input Text    id=recipient-email    test@test.com
    Input Text    id=recipient-name    Juan Perez
    Input Text    id=message-text    Este es un mensaje de prueba.
    Click Element    xpath=//button[text()='Send message']
    Sleep    2s
    Handle Alert    ACCEPT

5. Verificar el Registro de Usuario
    [Documentation]    Verifica que un usuario pueda registrarse[cite: 40].
    Go To    ${URL}
    Click Element    id=signin2
    Wait Until Element Is Visible    id=sign-username    10s
    Input Text    id=sign-username    ${USERNAME}
    Input Text    id=sign-password    ${PASSWORD}
    Click Element    xpath=//button[text()='Sign up']
    Sleep    3s
    Handle Alert    ACCEPT    # Cerramos el mensaje de "Sign up successful"

6. Verificar la Funcionalidad de Cerrar Sesión
    [Documentation]    Verifica que el usuario pueda hacer logout.
    Go To    ${URL}
    Wait Until Element Is Visible    id=login2    10s
    Click Element    id=login2
    Wait Until Element Is Visible    id=loginusername    10s

    # Limpieza y escritura
    Clear Element Text    id=loginusername
    Input Text    id=loginusername    ${USERNAME}
    Clear Element Text    id=loginpassword
    Input Text    id=loginpassword    ${PASSWORD}

    Click Element    xpath=//button[text()='Log in']

    Wait Until Element Is Visible    id=logout2    15s
    Sleep    2s
    Click Element    id=logout2
    Wait Until Element Is Visible    id=login2    10s

7. Verificar la Visualización de Precios de los Productos
    [Documentation]    Verifica que los productos en la página principal tengan precio[cite: 34, 36].
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Samsung galaxy s6')]    10s
    Element Should Be Visible    xpath=//h5[contains(text(),'$360')]

8: Verificar la Actualización del Carrito
    [Documentation]    Agrega un producto y luego lo elimina para asegurar que el botón aparezca
    Go To    ${URL}
    Agregar Producto Al Carrito    Samsung galaxy s6
    Click Element    id=cartur
    Wait Until Element Is Visible    xpath=//a[text()='Delete']    15s
    Click Element    xpath=//a[text()='Delete']
    Sleep    2s

*** Keywords ***
Abrir Navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window