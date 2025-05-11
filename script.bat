@echo off
:: Verifica se foi chamado com o argumento correto
IF "%1" NEQ "token123" (
    echo Acesso negado. Fechando...
    timeout /t 2 >nul
    exit /b
)

echo Acesso autorizado!
echo Executando comandos importantes...
:: Coloque aqui os comandos reais que você quiser executar
pause
