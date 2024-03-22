FROM mcr.microsoft.com/dotnet/sdk:6.0-jammy AS build
WORKDIR /work
COPY ./docker-basic/net/ /work
RUN dotnet build WebApplication_DIT_Docker.sln

FROM mcr.microsoft.com/dotnet/aspnet:6.0-jammy
WORKDIR /App
COPY --from=build /work/WebApplication_DIT_Docker/bin/Debug/net6.0/*.dll /App/
COPY --from=build /work/WebApplication_DIT_Docker/bin/Debug/net6.0/*.json /App/
EXPOSE 80
ENTRYPOINT ["dotnet", "/App/WebApplication_DIT_Docker.dll"]
