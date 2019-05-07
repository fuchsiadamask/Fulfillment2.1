FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY fulfillment2.1/*.csproj ./fulfillment2.1/
RUN dotnet restore

# copy everything else and build app
COPY fulfillment2.1/. ./fulfillment2.1/
WORKDIR /app/fulfillment2.1
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app/fulfillment2.1
COPY --from=build-env /app/fulfillment2.1/out .
ENTRYPOINT ["dotnet", "fulfillment2.1.dll"]