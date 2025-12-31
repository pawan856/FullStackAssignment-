using Microsoft.AspNetCore.Mvc;
using Part1_REST_API.Models;
using Part1_REST_API.Services;

namespace Part1_REST_API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class OrdersController : ControllerBase
{
    private readonly IOrderStore _store;

    public OrdersController(IOrderStore store)
    {
        _store = store;
    }

    [HttpPost]
    public IActionResult CreateOrder([FromBody] Order order)
    {
        if (order == null) return BadRequest("Order cannot be null");
        if (!ModelState.IsValid) return BadRequest(ModelState);

        var created = _store.Add(order);
        return CreatedAtAction(nameof(GetOrder), new { id = created.Id }, created);
    }

    [HttpGet("{id}")]
    public IActionResult GetOrder(int id)
    {
        var order = _store.GetById(id);
        if (order == null) return NotFound($"Order {id} not found");
        return Ok(order);
    }

    [HttpGet]
    public IActionResult GetOrders([FromQuery] string? status, [FromQuery] string? category)
    {
        return Ok(_store.GetFiltered(status, category));
    }

    [HttpPut("{id}")]
    public IActionResult UpdateOrder(int id, [FromBody] Order order)
    {
        if (order == null) return BadRequest();
        
        // This is technically a partial update logic (PATCH-like) 
        var updated = _store.Update(id, order);
        
        if (!updated) return NotFound();
        return NoContent();
    }

    [HttpDelete("{id}")]
    public IActionResult DeleteOrder(int id)
    {
        var deleted = _store.Delete(id);
        if (!deleted) return NotFound();
        return NoContent();
    }
}
