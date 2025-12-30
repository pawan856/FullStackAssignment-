using Part1_REST_API.Models;
using System.Collections.Concurrent;

namespace Part1_REST_API.Services;

public interface IOrderStore
{
    IEnumerable<Order> GetAll();
    IEnumerable<Order> GetFiltered(string? status, string? category);
    Order? GetById(int id);
    Order Add(Order order);
    bool Update(int id, Order order);
    bool Delete(int id);
}

// Simple in-memory storage for the assignment. 
// NOTE: Data is lost when the app restarts!
public class InMemoryOrderStore : IOrderStore
{
    private readonly ConcurrentDictionary<int, Order> _orders = new();
    private int _nextId = 1;

    public IEnumerable<Order> GetAll() => _orders.Values;

    public IEnumerable<Order> GetFiltered(string? status, string? category)
    {
        var query = _orders.Values.AsQueryable();
        
        if (!string.IsNullOrEmpty(status))
            query = query.Where(o => o.Status.Equals(status, StringComparison.OrdinalIgnoreCase));
        
        if (!string.IsNullOrEmpty(category))
            query = query.Where(o => o.Category.Equals(category, StringComparison.OrdinalIgnoreCase));
            
        return query;
    }

    public Order? GetById(int id)
    {
        _orders.TryGetValue(id, out var order);
        return order;
    }

    public Order Add(Order order)
    {
        order.Id = Interlocked.Increment(ref _nextId);
        if (order.OrderDate == default) order.OrderDate = DateTime.UtcNow;
        
        _orders.TryAdd(order.Id, order);
        return order;
    }

    public bool Update(int id, Order order)
    {
        if (!_orders.TryGetValue(id, out var existing)) return false;
        
        // Manual mapping for now - simpler than AutoMapper for this small task
        if (!string.IsNullOrWhiteSpace(order.Product)) existing.Product = order.Product;
        if (!string.IsNullOrWhiteSpace(order.Category)) existing.Category = order.Category;
        if (!string.IsNullOrWhiteSpace(order.Status)) existing.Status = order.Status;
        if (order.Quantity > 0) existing.Quantity = order.Quantity; 
        
        return true;
    }

    public bool Delete(int id) => _orders.TryRemove(id, out _);
}
