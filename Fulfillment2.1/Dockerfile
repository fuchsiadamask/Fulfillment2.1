FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["Fulfillment2.1/Fulfillment2.1.csproj", "Fulfillment2.1/"]
RUN dotnet restore "Fulfillment2.1/Fulfillment2.1.csproj"
COPY . .
WORKDIR "/src/Fulfillment2.1"
RUN dotnet build "Fulfillment2.1.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Fulfillment2.1.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Fulfillment2.1.dll"]