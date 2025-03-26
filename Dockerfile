# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the csproj file and restore any dependencies (via nuget)
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY . ./

# Build the application in Release mode
RUN dotnet publish -c Release -o out

# Generate the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY --from=build /app/out ./

# Expose the application port (for web applications)
EXPOSE 8000

# Specify the entry point for the application (adjust for your app's entry point)
ENTRYPOINT ["dotnet", "YourApp.dll"]
