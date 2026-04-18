FROM mcr.microsoft.com/powershell:7.4-alpine-3.20

WORKDIR /app

COPY . /app

CMD ["pwsh", "./check-ssl-expiry.ps1"]
