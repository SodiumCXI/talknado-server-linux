using Microsoft.Extensions.DependencyInjection;
using Talknado.Server.Core;
using Talknado.Server.Infrastructure;

namespace Talknado.Server;

public sealed class ServerHost : IDisposable
{
    private readonly ServiceProvider _provider;

    public ServerHost()
    {
        var services = new ServiceCollection().RegisterCoreServices();
        _provider = services.BuildServiceProvider();

        foreach (var descriptor in services.Where(d => d.Lifetime == ServiceLifetime.Singleton))
        {
            _provider.GetService(descriptor.ServiceType);
        }
    }

    public string? StartServer(string password)
    {
        var serverManager = _provider.GetRequiredService<IServerManager>();
        if (password != string.Empty)
        {
            var result = serverManager.Start(password);
            if (result.Item1)
                return null;
            else
                return result.Item2;
        }
        else
        {
            var result = serverManager.Start(null);
            if (result.Item1)
                return null;
            else
                return result.Item2;
        }
    }

    public void Dispose()
    {
        _provider.Dispose();
    }
}
