FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
RUN git clone https://github.com/whaakman/festive-tech-santa-wishlist.git
WORKDIR /festive-tech-santa-wishlist
RUN dotnet restore "SantaWishList.csproj"
COPY . .
RUN dotnet build "SantaWishList.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SantaWishList.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SantaWishList.dll"]
