FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy everything and build
COPY . ./
WORKDIR /app/Server
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/Server/out .

CMD ASPNETCORE_URLS=http://+:$PORT dotnet blazor-wasm-identityserver-new-app.Server.dll

