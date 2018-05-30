FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# run tests and publish application
COPY . ./
RUN find * -maxdepth 0 -name "*.Tests" -type d | xargs -L 1 dotnet test
RUN dotnet publish -c Release -o publish HelloService

# build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/HelloService/publish .
ENTRYPOINT ["dotnet", "HelloService.dll"]
