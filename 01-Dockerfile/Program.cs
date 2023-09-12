using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.UseStaticFiles(); // Enable serving static files like CSS

// Create a list to store registered participants
var participants = new List<Participant>();

app.MapGet("/", async (context) =>
{
    // Display the homepage with a form to register
    await context.Response.WriteAsync("<html><head><style>");
    await context.Response.WriteAsync("body { background: linear-gradient(to bottom, #3498db, #1abc9c); background-size: cover; font-family: Arial, sans-serif; }");
    await context.Response.WriteAsync(".registration-form { background-color: rgba(255, 255, 255, 0.8); padding: 20px; border-radius: 10px; }");
    await context.Response.WriteAsync("h1 { color: #e74c3c; font-size: 36px; text-shadow: 2px 2px 4px #000000; }");
    await context.Response.WriteAsync("</style></head><body>");

    // Display the version next to the headline
    await context.Response.WriteAsync("<h1>Kamil's Soccer Camp - V1</h1>");

    // Background images
    await context.Response.WriteAsync("<div id='background-container' style='position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1;'>");
    await context.Response.WriteAsync("<img src='https://example.com/soccer-image1.jpg' alt='Soccer Image 1' style='position: absolute; top: 0; left: 0; min-width: 100%; min-height: 100%; object-fit: cover;'>");
    await context.Response.WriteAsync("<img src='https://example.com/soccer-image2.jpg' alt='Soccer Image 2' style='position: absolute; top: 0; left: 0; min-width: 100%; min-height: 100%; object-fit: cover;'>");
    await context.Response.WriteAsync("</div>");

    // Styling for the registration form
    await context.Response.WriteAsync("<p>Register with your name and phone number:</p>");

    // Display the registration form
    await context.Response.WriteAsync("<form method='post' class='registration-form'>");
    await context.Response.WriteAsync("<label for='name'>Name:</label> <input type='text' name='name' id='name' required><br>");
    await context.Response.WriteAsync("<label for='phone'>Phone Number:</label> <input type='text' name='phone' id='phone' required><br>");
    await context.Response.WriteAsync("<input type='submit' value='Register'>");
    await context.Response.WriteAsync("</form>");

    // List of registered participants
    await context.Response.WriteAsync("<h2>Registered Participants:</h2>");
    await context.Response.WriteAsync("<ul>");
    foreach (var participant in participants)
    {
        await context.Response.WriteAsync($"<li>{participant.Name}, {participant.Phone}</li>");
    }
    await context.Response.WriteAsync("</ul>");

    // Registration flag
    await context.Response.WriteAsync("<div style='background-color: red; color: white; text-align: center; padding: 10px;'>Registration is now open</div>");

    // Background video
    await context.Response.WriteAsync("<div id='media-container' style='position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1;'>");
    await context.Response.WriteAsync("<video autoplay muted loop style='position: absolute; top: 0; left: 0; min-width: 100%; min-height: 100%; object-fit: cover;'>");
    await context.Response.WriteAsync("<source src='https://example.com/soccer-video.mp4' type='video/mp4'>");
    await context.Response.WriteAsync("</video>");
    await context.Response.WriteAsync("</div>");

    await context.Response.WriteAsync("</body></html>");
});

app.MapPost("/", async (context) =>
{
    // Handle the registration form submission
    var name = context.Request.Form["name"];
    var phone = context.Request.Form["phone"];
    if (!string.IsNullOrWhiteSpace(name) && !string.IsNullOrWhiteSpace(phone))
    {
        // Add the participant to the list
        participants.Add(new Participant { Name = name, Phone = phone });
    }

    // Redirect back to the homepage
    context.Response.Redirect("/");
});

app.Run();

public record Participant
{
    public string Name { get; init; }
    public string Phone { get; init; }
}

