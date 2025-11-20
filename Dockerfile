FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY WebApplication9/*.csproj ./WebApplication9/
RUN dotnet restore "WebApplication9/WebApplication9.csproj"
COPY . .
WORKDIR /src/WebApplication9
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "WebApplication9.dll"]