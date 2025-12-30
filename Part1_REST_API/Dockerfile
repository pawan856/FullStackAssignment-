# Use the official .NET SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["Part1_REST_API.csproj", "./"]
RUN dotnet restore "./Part1_REST_API.csproj"

# Copy the remaining source code
COPY . .
WORKDIR "/src/."

# Build the application
RUN dotnet build "Part1_REST_API.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "Part1_REST_API.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Use the official ASP.NET Core runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Expose the port (Render typically expects 80 or uses the PORT env var, but 8080 is default for non-root .NET images now)
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Part1_REST_API.dll"]
