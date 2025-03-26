# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the .csproj file and restore any dependencies (via dotnet restore)
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET runtime image for the final image (smaller image)
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

# Set the working directory inside the container
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/publish .

# Expose the port the application will run on
EXPOSE 80

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "YourAppName.dll"]
