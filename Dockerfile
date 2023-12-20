#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE $HTTP_PORT
EXPOSE $HTTPS_PORT

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SimpleCalculatorWeblinux.csproj", "."]
RUN dotnet restore "./././SimpleCalculatorWeblinux.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./SimpleCalculatorWeblinux.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "./SimpleCalculatorWeblinux.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY SimpleCalculatorWeblinux/.env.development ./.env
ENTRYPOINT ["dotnet", "SimpleCalculatorWeblinux.dll"]