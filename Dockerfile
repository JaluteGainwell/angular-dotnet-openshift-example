# get redhat openshift dotnet core 5.0 build
FROM registry.access.redhat.com/ubi8/dotnet-50 AS build
WORKDIR /build

# elevate root access to copy contents to published folder
USER root

# copy csproj and restore as distinct layers
COPY ./*.csproj .
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /build
RUN dotnet publish -c release -o published --no-cache

# final stage/image
FROM registry.access.redhat.com/ubi8/dotnet-50 AS runImg
WORKDIR /app
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000
COPY --from=build /build/published ./
ENTRYPOINT ["dotnet", "angular-dotnet-example.dll"]