#get the base image from microsoft
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

#Copy the csproj
COPY *.csproj ./
RUN dotnet restore  

#copy the project
COPY . ./
RUN dotnet publish -c Release -o out 

#generate runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet","DockerApi.dll"]
