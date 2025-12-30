# Part 1: REST API

This is a basic REST API built with ASP.NET Core 8.0.

## Features
- **Add Record**: POST `/api/records`
- **Retrieve Records**: GET `/api/records` (supports filtering by `status` and `category`)
- **Get Record**: GET `/api/records/{id}`
- **Update Record**: PUT `/api/records/{id}`
- **Delete Record**: DELETE `/api/records/{id}`
- **Security**: API Key authentication (`X-API-KEY`).
- **Documentation**: Swagger UI.

## How to Run
1. Navigate to the project folder:
   ```bash
   cd Part1_REST_API
   ```
2. Run the application:
   ```bash
   dotnet run
   ```
3. Open your browser and go to:
   `https://fullstack-assignment-api.onrender.com/swagger/index.html` 

## Authentication
You must provide the API Key in the header for all requests:
- **Header**: `X-API-KEY`
- **Value**: `SecretKey123`


## Known Limitations
- The project uses an **In-Memory Store**, so all data is lost when the application stops. This was chosen to keep the assignment simple and avoiding external DB dependencies.
- The **API Key** is simple middleware. In a real-world scenario, we can use OAuth or JWT.
