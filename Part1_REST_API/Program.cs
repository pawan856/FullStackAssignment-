using Microsoft.OpenApi.Models;
using Part1_REST_API.Authentication;
using Part1_REST_API.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Assignment API", Version = "v1" });
    c.AddSecurityDefinition("ApiKey", new OpenApiSecurityScheme
    {
        Name = "X-API-KEY",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Description = "API Key needed to access the endpoints."
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "ApiKey"
                }
            },
            new string[] {}
        }
    });
});

// Register In-Memory Store as Singleton
builder.Services.AddSingleton<IOrderStore, InMemoryOrderStore>();

var app = builder.Build();

// Configure the HTTP request pipeline.
// Enable Swagger  for testing
app.UseSwagger();
app.UseSwaggerUI();

// Using custom basic middleware for  simplicity
app.UseMiddleware<ApiKeyMiddleware>();

app.UseAuthorization();

app.MapControllers();

app.Run();
