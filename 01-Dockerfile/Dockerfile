# Use the official ASP.NET Core runtime image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

# Use the official ASP.NET Core SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

# Copy the .csproj file and restore any dependencies
COPY ["PizzaApp.csproj", ""]

# Restore dependencies
RUN dotnet restore "PizzaApp.csproj"

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet build "PizzaApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PizzaApp.csproj" -c Release -o /app/publish

# Create the final image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PizzaApp.dll"]
