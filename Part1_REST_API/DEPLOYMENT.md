# Deployment Guide (Part 1)

This guide explains how to deploy the ASP.NET Core Web API to **Render** (a popular cloud platform with a free tier).

## Prerequisites
1.  A GitHub account.
2.  This project pushed to a GitHub repository.
3.  A [Render](https://render.com/) account.

## Steps to Deploy

1.  **Log in to Render**.
2.  Click **New +** and select **Web Service**.
3.  **Connect your GitHub repository**.
    *   Grant access to the specific repository containing this assignment.
4.  **Configure the Service**:
    *   **Name**: `fullstack-assignment-api` (or similar)
    *   **Region**: Choose the one closest to you.
    *   **Branch**: `master` (or `main`)
    *   **Root Directory**: `Part1_REST_API` (Important: This tells Render where the Dockerfile is).
    *   **Runtime**: **Docker** (Render now requires Docker for .NET Core apps).
    *   **Instance Type**: Free
5.  **Environment Variables**:
    *   Add `ASPNETCORE_ENVIRONMENT` = `Production`
    *   (Optional) If you have a real database, add connection strings here.
6.  **Click "Create Web Service"**.

Render will clone your repo, build the app, and deploy it. Once finished, you will get a URL (e.g., `https://fullstack-assignment.onrender.com`).

## Testing the Deployed API

1.  Open the URL provided by Render.
2.  Append `/swagger/index.html` to the URL ('https://fullstack-assignment-api.onrender.com/swagger/index.html').
    *   *Note*: Ensure `app.UseSwagger()` is enabled in `Program.cs` even for Production if you want to see this page. (In the provided code, it is enabled generally).
3.  Use the `X-API-KEY` (`SecretKey123`) to test endpoints.
