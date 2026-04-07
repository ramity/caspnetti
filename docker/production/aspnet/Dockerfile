FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /caspnetti
RUN apt update
RUN apt upgrade -y
COPY ./src/backend/ .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /caspnetti
COPY --from=build /publish .
ENTRYPOINT dotnet Caspnetti.API.dll
